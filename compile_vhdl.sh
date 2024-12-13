#!/bin/bash

# Compile Logic Gates
echo "Compiling Logic Gates..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  vhdl/src/logic_gates/inverter.vhd \
  vhdl/src/logic_gates/and_2x1.vhd \
  vhdl/src/logic_gates/or_2x1.vhd \
  vhdl/src/logic_gates/nand_2x1.vhd \
  vhdl/src/logic_gates/nor_2x1.vhd \
  vhdl/src/logic_gates/xor_2x1.vhd \
  vhdl/src/logic_gates/xnor_2x1.vhd \
  vhdl/src/logic_gates/and_3x1.vhd \
  vhdl/src/logic_gates/and_4x1.vhd \
  vhdl/src/logic_gates/or_3x1.vhd \
  vhdl/src/logic_gates/or_4x1.vhd \
  vhdl/src/logic_gates/or_4x1_2bit.vhd \
  vhdl/src/logic_gates/or_8x1.vhd \
  vhdl/src/logic_gates/or_16x1.vhd -work work

# Compile Latches and Flip Flops
echo "Compiling Latches and Flip Flops..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  vhdl/src/latches_ffs/sr_latch.vhd \
  vhdl/src/latches_ffs/d_latch.vhd \
  vhdl/src/latches_ffs/dff_posedge.vhd \
  vhdl/src/latches_ffs/dff_negedge.vhd \
  vhdl/src/latches_ffs/dff_posedge_4bit.vhd \
  vhdl/src/latches_ffs/dff_posedge_8bit.vhd \
  vhdl/src/latches_ffs/dff_negedge_2bit.vhd \
  vhdl/src/latches_ffs/dff_negedge_8bit.vhd -work work

# Compile Muxes and Demuxes
echo "Compiling Muxes and Demuxes..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  vhdl/src/mux_demux/mux_2x1.vhd \
  vhdl/src/mux_demux/mux_2x1_2bit.vhd \
  vhdl/src/mux_demux/mux_2x1_8bit.vhd \
  vhdl/src/mux_demux/demux_1x2.vhd \
  vhdl/src/mux_demux/mux_4x1.vhd \
  vhdl/src/mux_demux/mux_4x1_2bit.vhd \
  vhdl/src/mux_demux/demux_1x4.vhd \
  vhdl/src/mux_demux/demux_1x4_2bit.vhd \
  vhdl/src/mux_demux/demux_1x8.vhd \
  vhdl/src/mux_demux/mux_16x1.vhd \
  vhdl/src/mux_demux/mux_16x1_8bit.vhd \
  vhdl/src/mux_demux/demux_1x16.vhd \
  vhdl/src/mux_demux/demux_1x16_8bit.vhd -work work

# Compile Utils
echo "Compiling Utils..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  vhdl/src/util/buffer_8bit.vhd \
  vhdl/src/util/byte_selector.vhd \
  vhdl/src/util/selector.vhd \
  vhdl/src/util/decoder_2x4.vhd \
  vhdl/src/util/one_hot_to_binary.vhd \
  vhdl/src/util/shift_register_3bit.vhd \
  vhdl/src/util/shift_register_7bit.vhd \
  vhdl/src/util/shift_register_19bit.vhd \
  vhdl/src/util/tag_comparator_2x1.vhd \
  vhdl/src/util/tx.vhd \
  vhdl/src/util/tx_6bit.vhd \
  vhdl/src/util/tx_8bit.vhd -work work

# Compile Cells
echo "Compiling Cells..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  vhdl/src/cells/cache_cell.vhd \
  vhdl/src/cells/cache_cell_2bit.vhd \
  vhdl/src/cells/cache_cell_8bit.vhd \
  vhdl/src/cells/valid_cell.vhd \
  vhdl/src/cells/valid_vector.vhd \
  vhdl/src/cells/tag_vector.vhd \
  vhdl/src/cells/block_cache.vhd -work work

# Compile Main Parts
echo "Compiling Main Parts..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  vhdl/src/state_machine.vhd \
  vhdl/src/timed_cache.vhd \
  vhdl/src/chip.vhd -work work

# Compile Test Benches
echo "Compiling Test Benches..."
/umbc/software/scripts/launch_cadence_xrun.sh -compile \
  vhdl/tb/chip_test_stdout.vhd \
  vhdl/tb/tb_state_machine.vhd \
  vhdl/tb/tb_timed_cache.vhd \
  vhdl/tb/tb_cache_cell.vhd \
  vhdl/tb/tb_byte_selector.vhd -work work

echo "All files compiled successfully!"

