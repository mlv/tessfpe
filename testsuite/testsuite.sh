#!/bin/bash -x

set -euo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PYTHON=${DIR}/tessfpe/bin/python
FPE_NUMBER=${FPE_NUMBER-1}

make -C ${DIR} reinstall

FPE_HOSTNAME=observatorysim
${PYTHON} ${DIR}/tessfpe/bin/observatory_simulator_version
${PYTHON} ${DIR}/tessfpe/bin/house_keeping --FPE-number $FPE_NUMBER
#${PYTHON} ${DIR}/tessfpe/bin/upload_fpe_program UpAndRunning --FPE-number $FPE_NUMBER
# TODO: Load specified file?
${PYTHON} ${DIR}/tessfpe/bin/load_wrapper --help --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/load_wrapper --force --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/load_wrapper --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/load_wrapper --dhu-reset --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/house_keeping --help --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/house_keeping --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/house_keeping --samples 20 --channels pt1000_sensor_* --FPE-number $FPE_NUMBER
${DIR}/tessfpe/bin/voltage_test --samples 20 --FPE-number $FPE_NUMBER --FPE-number $FPE_NUMBER
${DIR}/tessfpe/bin/bias_test --samples 20 --FPE-number $FPE_NUMBER --FPE-number $FPE_NUMBER
${DIR}/tessfpe/bin/rtd_test --samples 20 --FPE-number $FPE_NUMBER --FPE-number $FPE_NUMBER
# TODO: Upload binary files?
${PYTHON} ${DIR}/tessfpe/bin/upload_fpe_program --help
${PYTHON} ${DIR}/tessfpe/bin/upload_fpe_program --FPE-number $FPE_NUMBER < ${DIR}/program.fpe 
${PYTHON} ${DIR}/tessfpe/bin/upload_fpe_program ${DIR}/program.fpe --FPE-number $FPE_NUMBER

${PYTHON} ${DIR}/tessfpe/bin/start_frames --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/observatory_simulator_version --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/frames_running_status --check-running --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/stop_frames --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/frames_running_status --check-not-running --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --set-defaults --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/start_frames --FPE-number $FPE_NUMBER
# TODO: Load from binary file?
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --set-defaults --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --FPE-number $FPE_NUMBER < ${DIR}/low_params.json
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --set-defaults --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters ${DIR}/low_params.json --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --set-defaults --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/operating_parameters --set ccd4_substrate=0.0 ccd4_output_gate=-8 --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/frames_running_status --check-running --FPE-number $FPE_NUMBER
${PYTHON} ${DIR}/tessfpe/bin/stop_frames --FPE-number $FPE_NUMBER

#${PYTHON} ${DIR}/tessfpe/bin/scan_plot ccd1_reset_low --steps 100 --output $(mktemp -u /tmp/ccd1_reset_low.XXXXXXXXXX)

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
