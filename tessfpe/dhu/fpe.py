#!/usr/bin/env python2.7
from ops import OperatingParameters

import os
import house_keeping
import binary_files


class ForcedWrapperLoad(Exception):
    pass


def ping(hostname):
    """Ping the Observation Simulator to make sure it is alive"""
    from sh import ping
    out = ping('-c', '1', '-t', '1', hostname)

    return ('1 packets transmitted, 1 packets received' in str(out) or  # MacOSX
            '1 packets transmitted, 1 received' in str(out))  # Centos


def reverse_bytes32(n):
    """Reverses the bytes of a 32 bit integer
    :param n: An unsigned 32 bit integer we would like to reverse the bytes of
    """
    assert isinstance(n, int), "Argument is not an integer: {}".format(n)
    assert 0 <= n < 2 ** 32, "Argument must greater than or equal to 0" \
                             " and less than {MAX}, was {value}".format(MAX=2 ** 32, value=n)
    return reduce(lambda x, i: x + (((n >> 8 * i) & 0xFF) << (8 * (3 - i))), range(4), 0)


DEFAULT_FPE_HOSTNAME = "observatorysim"
DEFAULT_TFTP_HOSTNAME = "192.168.100.1"


class FPE(object):
    """An object for interacting with an FPE in an Observatory Simulator"""

    def __init__(self,
                 number,
                 debug=False,
                 sanity_checks=True,
                 auto_load=True):
        from fpesocketconnection import FPESocketConnection
        import os

        self.FPE_HOSTNAME = os.environ["FPE_HOSTNAME"] if "FPE_HOSTNAME" in os.environ else DEFAULT_FPE_HOSTNAME

        # First sanity check: ping the observatory simulator
        if not ping(self.FPE_HOSTNAME):
            raise Exception("Cannot ping " + self.FPE_HOSTNAME)
        self._debug = debug
        self._dir = os.path.dirname(os.path.realpath(__file__))
        self._reset_in_progress = False
        self._loading_wrapper = False
        self.fpe_number = number
        assert self.fpe_number in [1, 2], "FPE number must be either 1 or 2, was {}".format(self.fpe_number)
        self.connection = FPESocketConnection(5554 + number, self.FPE_HOSTNAME, self._debug)

        # self.ops implemented with lazy getter
        self._ops = None

        frames_status = None
        if sanity_checks is True:
            from unit_tests import check_house_keeping_voltages
            from unit_tests import UnexpectedHousekeeping
            from fpesocketconnection import TimeOutError
            try:
                try:
                    frames_status = self.frames_running_status
                    assert frames_status is True or frames_status is False
                except Exception as e:
                    raise type(e)(
                        "Could not read if frames are running on the Observatory Simulator... {0}\n".format(str(e)) +
                        "Are you sure the firmware for the Observatory Simulator is properly installed?")
                try:
                    version = self.version
                    if self._debug:
                        print version
                except Exception as e:
                    raise type(e)("Could not read Observatory Simulator version... {0}\n".format(str(e)) +
                                  "Are you sure you firmware for the Observatory Simulator is properly installed?")
                if frames_status is not True:
                    try:
                        check_house_keeping_voltages(self)
                    except (UnexpectedHousekeeping, TimeOutError) as e:
                        if auto_load is True:
                            self.load_wrapper()
                        else:
                            raise e

            finally:
                if frames_status is not None:
                    self.frames_running_status = frames_status

    def load_wrapper(self,
                     fpe_wrapper_binary=None,
                     wrapper_version='6.2.4',
                     force=False,
                     dhu_reset=False):
        """
        Load an FPGA wrapper.  Checks to see if housekeeping is reporting sane values
        :type wrapper_version: str
        :param fpe_wrapper_binary: A string containing a file name, if None is provided then wrapper_version is used
        :param wrapper_version: A string containing the version of the wrapper to be used, defaults to '6.1t.5'
        :param force: A Boolean, which flags whether the wrapper should be (re)installed even if it is already installed
        :param dhu_reset: A Boolean, which flags whether the DHU should be reset
        :return: A string saying the status of the loaded wrapper
        """
        import os.path
        from unit_tests import check_house_keeping_voltages, UnexpectedHousekeeping
        from fpesocketconnection import TimeOutError
        if self._loading_wrapper is True:
            return "Already in the process of trying to load the wrapper, not proceeding"
        try:
            self._loading_wrapper = True
            frames_status = self.frames_running_status
            if fpe_wrapper_binary is None:
                fpe_wrapper_binary = os.path.join(self._dir, "MemFiles",
                                                  "FPE_Wrapper-{version}.bin".format(version=wrapper_version))
            if not os.path.isfile(fpe_wrapper_binary):
                # Maybe we specified a version instead of a real file? No harm in trying...
                file_name = os.path.join(self._dir, "MemFiles",
                                         "FPE_Wrapper-{version}.bin".format(version=fpe_wrapper_binary))
                if os.path.isfile(file_name):
                    fpe_wrapper_binary = file_name
            assert os.path.isfile(fpe_wrapper_binary), "Wrapper file '{}' does not exist".format(fpe_wrapper_binary)
            if self.frames_running_status is True \
                    and force is not True \
                    and dhu_reset is not True:
                return "Frames are reporting to be running, *NOT* loading wrapper (tried to load '{}')".format(
                    fpe_wrapper_binary)
            if force or dhu_reset:
                raise ForcedWrapperLoad()
            self.frames_running_status = False
            self.cam_hsk(retries=1)
            check_house_keeping_voltages(self)
            return "House keeping reports sane values for reference voltages," \
                   " *NOT* loading wrapper (tried to load {})".format(fpe_wrapper_binary)
        except (ForcedWrapperLoad, UnexpectedHousekeeping, TimeOutError):
            if dhu_reset is True:
                self.dhu_reset()
            self.cam_reset(upload=False, sanity_checks=False)
            self.cam_fpga_rst()
            self.upload_fpe_wrapper_bin(fpe_wrapper_binary)
            # Reset the camera again, which uploads the register memory but doesn't check if housekeeping is sane
            self.cam_reset(upload=True, sanity_checks=False)
            # Set the housekeeping memory to the identity map
            house_keeping_memory = binary_files.write_hskmem(house_keeping.identity_map)
            assert self.upload_housekeeping_memory(house_keeping_memory), \
                "Could not load house keeping memory: {}".format(house_keeping_memory)
            # Reset the camera again, this time checking that housekeeping is reporting sane values
            # self.cam_reset(upload=True, sanity_checks=True)
            # Set the operating parameters to their defaults
            assert self.ops.reset_to_defaults(), "Could not send default operating parameters"
            # Check the house keeping is porting sane values (since we are paranoid)
            check_house_keeping_voltages(self)
            return "Wrapper {} loaded successfully".format(fpe_wrapper_binary)
        finally:
            self.frames_running_status = frames_status
            self._loading_wrapper = False

    def close(self):
        """Close the fpe object (namely its socket connection)"""
        return self.connection.close()

    def __enter__(self):
        """Enter the python object, used for context management.  See: https://www.python.org/dev/peps/pep-0343/"""
        return self

    def __exit__(self, *_):
        """Exit the python object, used for context management.  See: https://www.python.org/dev/peps/pep-0343/"""
        return self.close()

    def tftp_put(self, file_name, destination, timeout=1, retries=8):
        """Upload a file to the FPE"""
        from sh import tftp, ErrorReturnCode_1
        import re
        import os.path
        from time import sleep
        from fpesocketconnection import TimeOut, TimeOutError

        assert os.path.isfile(file_name), "Could not find file for TFTP upload: {}".format(file_name)
        assert self.fpe_number in [1, 2], "FPE number must be either 1 or 2, was {}".format(self.fpe_number)
        tftp_mode = "mode binary"
        tftp_port = "connect {TFTP_HOSTNAME} 69".format(TFTP_HOSTNAME=DEFAULT_TFTP_HOSTNAME)
        tftp_file = "put {} {}{}".format(file_name, destination, "2" if self.fpe_number is 2 else "")
        tftp_command = "\n" + tftp_mode + "\n" + tftp_port + "\n" + tftp_file

        status = self.frames_running_status
        t = None
        sleep_time = .5

        try:
            if self._debug:
                print "Running:\ntftp <<EOF\n", \
                    tftp_command, "\n", \
                    "EOF"
            self.frames_running_status = False
            for trial in range(retries):
                try:
                    with TimeOut(seconds=timeout,
                                 error_message="Timeout on trial {}".format(trial + 1)):
                        try:
                            tftp(_in=tftp_command)
                        except ErrorReturnCode_1 as e:
                            # tftp *always* fails on OS X because it's awesome
                            # so just check that it reports in stdout it sent the thing
                            if self._debug:
                                print e
                            if not re.match(r'Sent [0-9]+ bytes in [0-9]+\.[0-9]+ seconds',
                                            e.stdout):
                                raise e
                        # Wait for the fpe to report the load is complete
                        self.connection.wait_for_pattern(r'.*Load complete\n\r')
                        return True
                except TimeOutError as e:
                    sleep(sleep_time * 2 ** trial)
                    t = e
            raise t
        finally:
            self.frames_running_status = status

    def cam_reset(self, upload=True, sanity_checks=True):
        """Reset the camera after running frames"""
        from unit_tests import check_house_keeping_voltages, UnexpectedHousekeeping
        from fpesocketconnection import TimeOutError
        if self._reset_in_progress:
            return False
        self._reset_in_progress = True
        self.cam_stop_frames()
        assert 'FPE Reset complete' in self.connection.send_command(
            'camrst',
            reply_pattern='FPE Reset complete'), "Could not successfully issue camera reset command"
        # Clear cam_control
        self.control_status = 1
        status = self.control_status
        assert status is 0, "camera control status memory could not zeroed, was 0x{}".format(hex(status))
        if sanity_checks or upload:
            register_memory = os.path.join(self._dir, 'MemFiles', 'Reg.bin')
            assert self.upload_register_memory(register_memory), \
                'Could not load register memory: {}'.format(register_memory)
            # Set the housekeeping memory to the identity map
            house_keeping_memory = binary_files.write_hskmem(house_keeping.identity_map)
            assert self.upload_housekeeping_memory(house_keeping_memory), \
                "Could not load house keeping memory: {}".format(house_keeping_memory)
        if sanity_checks:
            # Try checking the housekeeping memory.  If it's bad, give reloading the wrapper
            try:
                check_house_keeping_voltages(self)
            except (TimeOutError, UnexpectedHousekeeping):
                self._reset_in_progress = False
                self.load_wrapper()
        self._reset_in_progress = False
        return True

    def cam_rst(self, upload=True, sanity_checks=True):
        """Reset the camera after running frames"""
        return self.cam_reset(upload=upload, sanity_checks=sanity_checks)

    def cam_status(self):
        """Get the camera status"""
        response = self.connection.send_command(
            "cam_status",
            reply_pattern="cam_status = 0x[0-9a-f]+")[13:]
        return int(response, 16)

    def cam_control(self, val=None):
        """Get the camera control status"""
        response = self.connection.send_command(
            "cam_control" if val is None else "cam_control = {}".format(val),
            reply_pattern="cam_control = 0x[0-9a-f]+")[14:]
        return int(response, 16)

    def cam_version(self):
        """Get the version of the Observatory Simulator DHU software"""
        import re
        # Frames must be stopped to read version, otherwise the observatory simulator will not respond
        status = self.frames_running_status
        try:
            self.frames_running_status = False
            return \
                re.sub(r'FPE[0-9]>', '',
                       self.connection.send_command(
                           "version",
                           reply_pattern="Observatory Simulator Version .*"))
        finally:
            self.frames_running_status = status

    def cam_fpga_reset(self):
        """Reset the FPGA so that another wrapper can be uploaded"""
        assert self.cam_reset(upload=False, sanity_checks=False), "Could not reset camera"
        return self.connection.send_command(
            "cam_fpga_rst",
            # TODO: switch on "Cam FPGA done."
            reply_pattern="Resetting Cam FPGA",
            timeout=3
        )

    def dhu_reset(self):
        """Reset the DHU; note that this clobbers *both* cameras attached"""
        return self.connection.send_command(
            "dhu_rst",
            reply_pattern="DHU Reset complete",
            timeout=3
        )

    def cam_fpga_rst(self):
        """Reset the FPGA so that another wrapper can be uploaded"""
        return self.cam_fpga_reset()

    def dhu_rst(self):
        """Reset the DHU; note that this clobbers *both* cameras attached"""
        return self.dhu_reset()

    def cam_start_frames(self):
        """Start running frames"""
        if self.frames_running_status is True:
            return "Control status indicates frames are already running"
        return self.connection.send_command(
            "cam_start_frames",
            reply_pattern="(Starting frames...|Frames already enabled)"
        )

    def cam_stop_frames(self):
        """Stop running frames"""
        if self.frames_running_status is False:
            return "Control status indicates frames are already stopped;" \
                   " however the FPE may not be safely in debug mode" \
                   " if cam_stop_frames was issued via the netcat console"
        assert "Frames Stopped..." in self.connection.send_command(
            "cam_stop_frames",
            reply_pattern="Frames Stopped...")
        self.cam_reset()
        assert self._reset_in_progress is False, "Reset should no longer be in progress"
        return "Frames have been stopped and the FPE has been placed in debug mode"

    def cam_hsk(self, retries=None):
        """Get the camera housekeeping data, outputs an array of the housekeeping data"""
        import re
        channels = 128
        # TODO: switch on whether frames have been started and use obsim
        status = self.frames_running_status
        try:
            self.frames_running_status = False
            out = self.connection.send_command(
                "cam_hsk",
                reply_pattern="Hsk\[[0-9]+\] = 0x[0-9a-f]+",
                matches=channels,
                retries=retries
            )
            return [int(n, 16) for n in re.findall('0x[0-9a-f]+', out)]
        finally:
            self.frames_running_status = status

    def cam_clv(self):
        """Get the clock voltage memory, returns the twelve bit values"""
        import re
        entries = 64
        status = self.frames_running_status
        try:
            self.frames_running_status = False
            out = self.connection.send_command(
                "cam_clv",
                reply_pattern="FpeClv\[[0-9]+\] = 0x[0-9a-f]+",
                matches=entries
            )
            return [(reverse_bytes32(int(n, 16)) >> shift) & mask
                    for n in re.findall('0x[0-9a-f]+', out)
                    for (mask, shift) in [(0x0FFF, 16), (0x00000FFF, 0)]]
        finally:
            self.frames_running_status = status

    def compile_and_load_fpe_program(self, program):
        """Loads the program code using tftp"""
        from ..sequencer_dsl.program import compile_programs
        from ..sequencer_dsl.sequence import compile_sequences
        from ..sequencer_dsl.parse import parse_file
        from ..data.data import data_dir
        import os.path
        if not hasattr(program, 'read'):
            data_dir_fpe_program = os.path.join(data_dir, 'sequencer', program)
            if os.path.isfile(data_dir_fpe_program):
                program = data_dir_fpe_program
            else:
                data_dir_fpe_program_fpe = os.path.join(data_dir, 'sequencer', program + ".fpe")
                if os.path.isfile(data_dir_fpe_program_fpe):
                    program = data_dir_fpe_program_fpe
        ast = parse_file(program)
        sequencer_byte_code = binary_files.write_seqmem(compile_sequences(ast))
        program_byte_code = binary_files.write_prgmem(compile_programs(ast))
        return self.upload_sequencer_memory(sequencer_byte_code) and self.upload_program_memory(program_byte_code)

    @property
    def house_keeping(self):
        """Return the house keeping as a map"""
        hsk = self.cam_hsk()
        # Create a dictionary of the analogue outputs
        analogue = house_keeping.hsk_to_analogue_dictionary(hsk)
        # Create array of digital outs; this gets wiped every time we
        # re-upload the register memory so it's not very useful
        digital = [k for i in range(0, 128, 32)
                   for j in hsk[17 + i:24 + i]
                   for k in house_keeping.unpack_pair(j)]
        return {"analogue": analogue,
                "digital": digital}

    @property
    def version(self):
        """Version property for the Observatory Simulator DHU software"""
        return self.cam_version()

    @property
    def status(self):
        """Get the camera status for the Observatory Simulator for a particular FPE"""
        return self.cam_status()

    @property
    def control_status(self):
        """Get the camera control status for the Observatory Simulator for a particular FPE"""
        return self.cam_control()

    @control_status.setter
    def control_status(self, val):
        """Set the camera control status for the Observatory Simulator for a particular FPE"""
        self.cam_control(val)

    @property
    def ops(self):
        if self._ops is None:
            self._ops = OperatingParameters(self)
        return self._ops

    @property
    def frames_running_status(self):
        """Status of whether the Observatory Simulator server is running frames."""
        return (0b10 & self.control_status) == 0b10

    @frames_running_status.setter
    def frames_running_status(self, value):
        """Set if frames are running or not"""
        if value is self.frames_running_status:
            pass
        elif value is True and self.frames_running_status is not True:
            self.cam_start_frames()
        elif value is False and self.frames_running_status is not False:
            self.cam_stop_frames()
        else:
            raise Exception("Trying to set frames_running_status to value that is not boolean: {0}".format(value))

    def upload_fpe_wrapper_bin(self, fpe_wrapper_bin):
        """Upload the FPE Wrapper binary file to the FPE
        :param fpe_wrapper_bin: Name of FPE wrapper binary to upload
        """
        return self.tftp_put(
            fpe_wrapper_bin,
            "bitmem",
            timeout=16)

    def upload_sequencer_memory(self, sequencer_memory):
        """Upload the Sequencer Memory to the FPE"""
        return self.tftp_put(
            sequencer_memory,
            "seqmem")

    def upload_register_memory(self, register_memory):
        """Upload the Register Memory to the FPE"""
        return self.tftp_put(
            register_memory,
            "regmem")

    def upload_program_memory(self, program_memory):
        """Upload the Program Memory to the FPE"""
        return self.tftp_put(
            program_memory,
            "prgmem")

    def upload_operating_parameter_memory(self, operating_parameter_memory):
        """Upload the Operating Parameter Memory to the FPE"""
        return self.tftp_put(
            operating_parameter_memory,
            "clvmem")

    def upload_housekeeping_memory(self, hsk_memory):
        """Upload the Operating Parameter Memory to the FPE"""
        return self.tftp_put(
            hsk_memory,
            "hskmem")
