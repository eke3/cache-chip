#!/bin/bash

# Compile Logic Gates
echo "Compiling Logic Gates..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  src/logic_gates/inverter.vhd \
  src/logic_gates/and_2x1.vhd \
  src/logic_gates/or_2x1.vhd \
  src/logic_gates/nand_2x1.vhd \
  src/logic_gates/nor_2x1.vhd \
  src/logic_gates/xor_2x1.vhd \
  src/logic_gates/xnor_2x1.vhd \
  src/logic_gates/and_3x1.vhd \
  src/logic_gates/and_4x1.vhd \
  src/logic_gates/or_3x1.vhd \
  src/logic_gates/or_4x1.vhd \
  src/logic_gates/or_4x1_2bit.vhd \
  src/logic_gates/or_8x1.vhd \
  src/logic_gates/or_16x1.vhd -work work

# Compile Latches and Flip Flops
echo "Compiling Latches and Flip Flops..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  src/latches_ffs/sr_latch.vhd \
  src/latches_ffs/d_latch.vhd \
  src/latches_ffs/dff_posedge.vhd \
  src/latches_ffs/dff_negedge.vhd \
  src/latches_ffs/dff_posedge_4bit.vhd \
  src/latches_ffs/dff_posedge_8bit.vhd \
  src/latches_ffs/dff_negedge_2bit.vhd \
  src/latches_ffs/dff_negedge_8bit.vhd -work work

# Compile Muxes and Demuxes
echo "Compiling Muxes and Demuxes..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  src/mux_demux/mux_2x1.vhd \
  src/mux_demux/mux_2x1_2bit.vhd \
  src/mux_demux/mux_2x1_8bit.vhd \
  src/mux_demux/demux_1x2.vhd \
  src/mux_demux/mux_4x1.vhd \
  src/mux_demux/mux_4x1_2bit.vhd \
  src/mux_demux/demux_1x4.vhd \
  src/mux_demux/demux_1x4_2bit.vhd \
  src/mux_demux/demux_1x8.vhd \
  src/mux_demux/mux_16x1.vhd \
  src/mux_demux/mux_16x1_8bit.vhd \
  src/mux_demux/demux_1x16.vhd \
  src/mux_demux/demux_1x16_8bit.vhd -work work

# Compile Utils
echo "Compiling Utils..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  src/util/buffer_8bit.vhd \
  src/util/byte_selector.vhd \
  src/util/selector.vhd \
  src/util/decoder_2x4.vhd \
  src/util/one_hot_to_binary.vhd \
  src/util/shift_register_3bit.vhd \
  src/util/shift_register_7bit.vhd \
  src/util/shift_register_19bit.vhd \
  src/util/tag_comparator_2x1.vhd \
  src/util/tx.vhd \
  src/util/tx_6bit.vhd \
  src/util/tx_8bit.vhd -work work

# Compile Cells
echo "Compiling Cells..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  src/cells/cache_cell.vhd \
  src/cells/cache_cell_2bit.vhd \
  src/cells/cache_cell_8bit.vhd \
  src/cells/valid_cell.vhd \
  src/cells/valid_vector.vhd \
  src/cells/tag_vector.vhd \
  src/cells/block_cache.vhd -work work

# Compile Main Parts
echo "Compiling Main Parts..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  src/state_machine.vhd \
  src/timed_cache.vhd \
  src/chip.vhd -work work

# Compile Test Benches
echo "Compiling Test Benches..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  tb/chip_test_stdout.vhd \
  tb/tb_state_machine.vhd \
  tb/tb_timed_cache.vhd \
  tb/tb_cache_cell.vhd \
  tb/tb_byte_selector.vhd -work work

echo "All files compiled successfully!"

