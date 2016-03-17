#!/bin/bash

set -euo pipefail
IFS=$'\n\t'
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SAMPLES_PER_STEP=10
STEPS=20
OUTPUT_DIR=${DIR}/operating_parameter_scan_plots
SCAN_CMD=${DIR}/venv/bin/scan_plot --steps ${STEPS} --samples-per-step ${SAMPLES_PER_STEP} --output ${OUTPUT_DIR}

make -C ${DIR} reinstall
mkdir -p ${OUTPUT_DIR}

${SCAN_CMD} ccd1_backside
${SCAN_CMD} ccd1_input_diode_high
${SCAN_CMD} ccd1_input_diode_low
${SCAN_CMD} ccd1_input_gate_1
${SCAN_CMD} ccd1_input_gate_2
${SCAN_CMD} ccd1_output_drain_a
${SCAN_CMD} ccd1_output_drain_a_offset
${SCAN_CMD} ccd1_output_drain_b
${SCAN_CMD} ccd1_output_drain_b_offset
${SCAN_CMD} ccd1_output_drain_c
${SCAN_CMD} ccd1_output_drain_c_offset
${SCAN_CMD} ccd1_output_drain_d
${SCAN_CMD} ccd1_output_drain_d_offset
${SCAN_CMD} ccd1_output_gate
${SCAN_CMD} ccd1_parallel_high
${SCAN_CMD} ccd1_parallel_high_offset
${SCAN_CMD} ccd1_parallel_low
${SCAN_CMD} ccd1_reset_drain
${SCAN_CMD} ccd1_reset_high
${SCAN_CMD} ccd1_reset_low
${SCAN_CMD} ccd1_reset_low_offset
${SCAN_CMD} ccd1_scupper
${SCAN_CMD} ccd1_serial_high
${SCAN_CMD} ccd1_serial_low
${SCAN_CMD} ccd1_serial_low_offset
${SCAN_CMD} ccd1_substrate
${SCAN_CMD} ccd2_backside
${SCAN_CMD} ccd2_input_diode_high
${SCAN_CMD} ccd2_input_diode_low
${SCAN_CMD} ccd2_input_gate_1
${SCAN_CMD} ccd2_input_gate_2
${SCAN_CMD} ccd2_output_drain_a
${SCAN_CMD} ccd2_output_drain_a_offset
${SCAN_CMD} ccd2_output_drain_b
${SCAN_CMD} ccd2_output_drain_b_offset
${SCAN_CMD} ccd2_output_drain_c
${SCAN_CMD} ccd2_output_drain_c_offset
${SCAN_CMD} ccd2_output_drain_d
${SCAN_CMD} ccd2_output_drain_d_offset
${SCAN_CMD} ccd2_output_gate
${SCAN_CMD} ccd2_parallel_high
${SCAN_CMD} ccd2_parallel_high_offset
${SCAN_CMD} ccd2_parallel_low
${SCAN_CMD} ccd2_reset_drain
${SCAN_CMD} ccd2_reset_high
${SCAN_CMD} ccd2_reset_low
${SCAN_CMD} ccd2_reset_low_offset
${SCAN_CMD} ccd2_scupper
${SCAN_CMD} ccd2_serial_high
${SCAN_CMD} ccd2_serial_low
${SCAN_CMD} ccd2_serial_low_offset
${SCAN_CMD} ccd2_substrate
${SCAN_CMD} ccd3_backside
${SCAN_CMD} ccd3_input_diode_high
${SCAN_CMD} ccd3_input_diode_low
${SCAN_CMD} ccd3_input_gate_1
${SCAN_CMD} ccd3_input_gate_2
${SCAN_CMD} ccd3_output_drain_a
${SCAN_CMD} ccd3_output_drain_a_offset
${SCAN_CMD} ccd3_output_drain_b
${SCAN_CMD} ccd3_output_drain_b_offset
${SCAN_CMD} ccd3_output_drain_c
${SCAN_CMD} ccd3_output_drain_c_offset
${SCAN_CMD} ccd3_output_drain_d
${SCAN_CMD} ccd3_output_drain_d_offset
${SCAN_CMD} ccd3_output_gate
${SCAN_CMD} ccd3_parallel_high
${SCAN_CMD} ccd3_parallel_high_offset
${SCAN_CMD} ccd3_parallel_low
${SCAN_CMD} ccd3_reset_drain
${SCAN_CMD} ccd3_reset_high
${SCAN_CMD} ccd3_reset_low
${SCAN_CMD} ccd3_reset_low_offset
${SCAN_CMD} ccd3_scupper
${SCAN_CMD} ccd3_serial_high
${SCAN_CMD} ccd3_serial_low
${SCAN_CMD} ccd3_serial_low_offset
${SCAN_CMD} ccd3_substrate
${SCAN_CMD} ccd4_backside
${SCAN_CMD} ccd4_input_diode_high
${SCAN_CMD} ccd4_input_diode_low
${SCAN_CMD} ccd4_input_gate_1
${SCAN_CMD} ccd4_input_gate_2
${SCAN_CMD} ccd4_output_drain_a
${SCAN_CMD} ccd4_output_drain_a_offset
${SCAN_CMD} ccd4_output_drain_b
${SCAN_CMD} ccd4_output_drain_b_offset
${SCAN_CMD} ccd4_output_drain_c
${SCAN_CMD} ccd4_output_drain_c_offset
${SCAN_CMD} ccd4_output_drain_d
${SCAN_CMD} ccd4_output_drain_d_offset
${SCAN_CMD} ccd4_output_gate
${SCAN_CMD} ccd4_parallel_high
${SCAN_CMD} ccd4_parallel_high_offset
${SCAN_CMD} ccd4_parallel_low
${SCAN_CMD} ccd4_reset_drain
${SCAN_CMD} ccd4_reset_high
${SCAN_CMD} ccd4_reset_low
${SCAN_CMD} ccd4_reset_low_offset
${SCAN_CMD} ccd4_scupper
${SCAN_CMD} ccd4_serial_high
${SCAN_CMD} ccd4_serial_low
${SCAN_CMD} ccd4_serial_low_offset
${SCAN_CMD} ccd4_substrate
${SCAN_CMD} heater_1_current
${SCAN_CMD} heater_2_current
${SCAN_CMD} heater_3_current
