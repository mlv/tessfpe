#!/bin/bash

set -euo pipefail
IFS=$'\n\t'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
RESET="$(tput sgr0)"

if [ -f "summary.pdf" ] ; then
   echo "${RED}Please make a backup of summary.pdf BEFORE running this program!${RESET}" > /dev/stderr
   exit 1
fi

# Increase these numbers to make this take longer to run
SAMPLES_PER_STEP=5
STEPS=20

# Where to dump the plots; change this for different scripts.  Make sure it is empty before running this script
OUTPUT_DIR=$(mktemp -d)

function scan_plot {
  ${DIR}/venv/bin/scan_plot --steps ${STEPS} --samples-per-step ${SAMPLES_PER_STEP} --output ${OUTPUT_DIR} $*
}

make -C ${DIR} reinstall > /dev/null 2>&1
mkdir -p ${OUTPUT_DIR}

# In each case, the first argument is the operating parameter, the second is the low value, the third is the high value
# Low and high values default to listings in the data sheet if not specified
# Output is summarized in ${OUTPUT_DIR}/summary.pdf

scan_plot ccd1_backside # Doesn't work :( ...delete?
scan_plot ccd1_input_diode_high 0 14.5
scan_plot ccd1_input_diode_low
scan_plot ccd1_input_gate_1
scan_plot ccd1_input_gate_2
scan_plot ccd1_output_drain_a
scan_plot ccd1_output_drain_b
scan_plot ccd1_output_drain_c
scan_plot ccd1_output_drain_d
scan_plot ccd1_output_gate
scan_plot ccd1_parallel_high
scan_plot ccd1_parallel_low
scan_plot ccd1_reset_drain
scan_plot ccd1_reset_high
scan_plot ccd1_reset_low
scan_plot ccd1_scupper
scan_plot ccd1_serial_high
scan_plot ccd1_serial_low
scan_plot ccd1_substrate
scan_plot ccd2_backside
scan_plot ccd2_input_diode_high
scan_plot ccd2_input_diode_low
scan_plot ccd2_input_gate_1
scan_plot ccd2_input_gate_2
scan_plot ccd2_output_drain_a
scan_plot ccd2_output_drain_b
scan_plot ccd2_output_drain_c
scan_plot ccd2_output_drain_d
scan_plot ccd2_output_gate
scan_plot ccd2_parallel_high
scan_plot ccd2_parallel_low
scan_plot ccd2_reset_drain
scan_plot ccd2_reset_high
scan_plot ccd2_reset_low
scan_plot ccd2_scupper
scan_plot ccd2_serial_high
scan_plot ccd2_serial_low
scan_plot ccd2_substrate
scan_plot ccd3_backside
scan_plot ccd3_input_diode_high
scan_plot ccd3_input_diode_low
scan_plot ccd3_input_gate_1
scan_plot ccd3_input_gate_2
scan_plot ccd3_output_drain_a
scan_plot ccd3_output_drain_b
scan_plot ccd3_output_drain_c
scan_plot ccd3_output_drain_d
scan_plot ccd3_output_gate
scan_plot ccd3_parallel_high
scan_plot ccd3_parallel_low
scan_plot ccd3_reset_drain
scan_plot ccd3_reset_high
scan_plot ccd3_reset_low
scan_plot ccd3_scupper
scan_plot ccd3_serial_high
scan_plot ccd3_serial_low
scan_plot ccd3_substrate
scan_plot ccd4_backside
scan_plot ccd4_input_diode_high
scan_plot ccd4_input_diode_low
scan_plot ccd4_input_gate_1
scan_plot ccd4_input_gate_2
scan_plot ccd4_output_drain_a
scan_plot ccd4_output_drain_b
scan_plot ccd4_output_drain_c
scan_plot ccd4_output_drain_d
scan_plot ccd4_output_gate
scan_plot ccd4_parallel_high
scan_plot ccd4_parallel_low
scan_plot ccd4_reset_drain
scan_plot ccd4_reset_high
scan_plot ccd4_reset_low
scan_plot ccd4_scupper
scan_plot ccd4_serial_high
scan_plot ccd4_serial_low
scan_plot ccd4_substrate
scan_plot heater_1_current
scan_plot heater_2_current
scan_plot heater_3_current

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=summary.pdf ${OUTPUT_DIR}/*.pdf 
echo Wrote summary.pdf ${GREEN}ok${RESET}
