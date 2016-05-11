#!/bin/bash -x

set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PYTHON=${DIR}/venv/bin/python

make -C ${DIR} reinstall

${PYTHON} ${DIR}/venv/bin/observatory_simulator_version
# TODO: Load specified file?
${PYTHON} ${DIR}/venv/bin/house_keeping
${PYTHON} ${DIR}/venv/bin/load_wrapper --help
${PYTHON} ${DIR}/venv/bin/load_wrapper 6.1t.4 --force
${PYTHON} ${DIR}/venv/bin/load_wrapper
${PYTHON} ${DIR}/venv/bin/load_wrapper --dhu-reset
${PYTHON} ${DIR}/venv/bin/frames_running_status --check-not-running
${PYTHON} ${DIR}/venv/bin/house_keeping --help
${PYTHON} ${DIR}/venv/bin/house_keeping
${PYTHON} ${DIR}/venv/bin/house_keeping --samples 20 --channels pt1000_sensor_*
${DIR}/venv/bin/voltage_test --samples 20
${DIR}/venv/bin/bias_test --samples 20
${DIR}/venv/bin/rtd_test --samples 20
# TODO: Upload binary files?
${PYTHON} ${DIR}/venv/bin/upload_fpe_program --help
${PYTHON} ${DIR}/venv/bin/upload_fpe_program < ${DIR}/program.fpe
${PYTHON} ${DIR}/venv/bin/upload_fpe_program ${DIR}/program.fpe

${PYTHON} ${DIR}/venv/bin/start_frames
${PYTHON} ${DIR}/venv/bin/observatory_simulator_version
${PYTHON} ${DIR}/venv/bin/frames_running_status --check-running
${PYTHON} ${DIR}/venv/bin/stop_frames
${PYTHON} ${DIR}/venv/bin/frames_running_status --check-not-running
${PYTHON} ${DIR}/venv/bin/operating_parameters
${PYTHON} ${DIR}/venv/bin/operating_parameters --set-defaults
${PYTHON} ${DIR}/venv/bin/start_frames
# TODO: Load from binary file?
${PYTHON} ${DIR}/venv/bin/operating_parameters
${PYTHON} ${DIR}/venv/bin/operating_parameters --set-defaults
${PYTHON} ${DIR}/venv/bin/operating_parameters < ${DIR}/low_params.json
${PYTHON} ${DIR}/venv/bin/operating_parameters --set-defaults
${PYTHON} ${DIR}/venv/bin/operating_parameters ${DIR}/low_params.json
${PYTHON} ${DIR}/venv/bin/operating_parameters --set-defaults
${PYTHON} ${DIR}/venv/bin/operating_parameters --set ccd4_substrate=0.0 ccd4_output_gate=-8
${PYTHON} ${DIR}/venv/bin/frames_running_status --check-running
${PYTHON} ${DIR}/venv/bin/stop_frames

${PYTHON} ${DIR}/venv/bin/scan_plot ccd1_reset_low --steps 100 --output $(mktemp -u /tmp/ccd1_reset_low.XXXXXXXXXX)

${PYTHON} ${DIR}/venv/bin/tessfpe_version
${PYTHON} ${DIR}/venv/bin/compile_fpe_programs --help
${PYTHON} ${DIR}/venv/bin/compile_fpe_programs < ${DIR}/program.fpe
${PYTHON} ${DIR}/venv/bin/compile_fpe_programs ${DIR}/program.fpe
${PYTHON} ${DIR}/venv/bin/compile_fpe_programs ${DIR}/program.fpe program.bin

${PYTHON} ${DIR}/venv/bin/compile_fpe_sequences --help
${PYTHON} ${DIR}/venv/bin/compile_fpe_sequences < ${DIR}/program.fpe
${PYTHON} ${DIR}/venv/bin/compile_fpe_sequences ${DIR}/program.fpe
${PYTHON} ${DIR}/venv/bin/compile_fpe_sequences ${DIR}/program.fpe program.bin

${PYTHON} ${DIR}/venv/bin/compile_operating_parameters --help
${PYTHON} ${DIR}/venv/bin/compile_operating_parameters < ${DIR}/low_params.json
${PYTHON} ${DIR}/venv/bin/compile_operating_parameters ${DIR}/low_params.json
${PYTHON} ${DIR}/venv/bin/compile_operating_parameters ${DIR}/low_params.json low_params.bin

echo "--------------------- $(tput setaf 2) ☺︎ SUCCESS! ☺︎ $(tput sgr0) ---------------------"
