#!/bin/bash -x

set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PYTHON=${DIR}/tessfpe/bin/python

make -C ${DIR} reinstall

${PYTHON} ${DIR}/tessfpe/bin/observatory_simulator_version
# TODO: Load specified file?
${PYTHON} ${DIR}/tessfpe/bin/house_keeping
${PYTHON} ${DIR}/tessfpe/bin/load_wrapper --help
${PYTHON} ${DIR}/tessfpe/bin/load_wrapper 6.1t.4 --force
${PYTHON} ${DIR}/tessfpe/bin/load_wrapper
${PYTHON} ${DIR}/tessfpe/bin/load_wrapper --dhu-reset
${PYTHON} ${DIR}/tessfpe/bin/house_keeping --help
${PYTHON} ${DIR}/tessfpe/bin/house_keeping
${PYTHON} ${DIR}/tessfpe/bin/house_keeping --samples 20 --channels pt1000_sensor_*
${DIR}/tessfpe/bin/voltage_test --samples 20
${DIR}/tessfpe/bin/bias_test --samples 20
${DIR}/tessfpe/bin/rtd_test --samples 20
# TODO: Upload binary files?
${PYTHON} ${DIR}/tessfpe/bin/upload_fpe_program --help
${PYTHON} ${DIR}/tessfpe/bin/upload_fpe_program < ${DIR}/program.fpe
${PYTHON} ${DIR}/tessfpe/bin/upload_fpe_program ${DIR}/program.fpe

${PYTHON} ${DIR}/tessfpe/bin/start_frames
${PYTHON} ${DIR}/tessfpe/bin/observatory_simulator_version
${PYTHON} ${DIR}/tessfpe/bin/frames_running_status --check-running
${PYTHON} ${DIR}/tessfpe/bin/stop_frames
${PYTHON} ${DIR}/tessfpe/bin/frames_running_status --check-not-running
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --set-defaults
${PYTHON} ${DIR}/tessfpe/bin/start_frames
# TODO: Load from binary file?
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --set-defaults
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters < ${DIR}/low_params.json
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --set-defaults
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters ${DIR}/low_params.json
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --set-defaults
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --set ccd4_substrate=0.0 ccd4_output_gate=-8
${PYTHON} ${DIR}/tessfpe/bin/frames_running_status --check-running
${PYTHON} ${DIR}/tessfpe/bin/stop_frames

${PYTHON} ${DIR}/tessfpe/bin/scan_plot ccd1_reset_low --steps 100 --output $(mktemp -u /tmp/ccd1_reset_low.XXXXXXXXXX)

${PYTHON} ${DIR}/tessfpe/bin/tessfpe_version
${PYTHON} ${DIR}/tessfpe/bin/compile_fpe_programs --help
${PYTHON} ${DIR}/tessfpe/bin/compile_fpe_programs < ${DIR}/program.fpe
${PYTHON} ${DIR}/tessfpe/bin/compile_fpe_programs ${DIR}/program.fpe
${PYTHON} ${DIR}/tessfpe/bin/compile_fpe_programs ${DIR}/program.fpe program.bin

${PYTHON} ${DIR}/tessfpe/bin/compile_fpe_sequences --help
${PYTHON} ${DIR}/tessfpe/bin/compile_fpe_sequences < ${DIR}/program.fpe
${PYTHON} ${DIR}/tessfpe/bin/compile_fpe_sequences ${DIR}/program.fpe
${PYTHON} ${DIR}/tessfpe/bin/compile_fpe_sequences ${DIR}/program.fpe program.bin

${PYTHON} ${DIR}/tessfpe/bin/compile_operating_parameters --help
${PYTHON} ${DIR}/tessfpe/bin/compile_operating_parameters < ${DIR}/low_params.json
${PYTHON} ${DIR}/tessfpe/bin/compile_operating_parameters ${DIR}/low_params.json
${PYTHON} ${DIR}/tessfpe/bin/compile_operating_parameters ${DIR}/low_params.json low_params.bin

echo "--------------------- $(tput setaf 2) ☺︎ SUCCESS! ☺︎ $(tput sgr0) ---------------------"
