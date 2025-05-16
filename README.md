# Cache Chip Design Using VHDL and Layouts

## Compiling on Lab Computers

Make compilation script executable.
```bash
chmod +x compile_vhdl.sh
```


Run VHDL compilation script
```bash
./compile_vhdl.sh
```


## Running test benches

A successful test will report "Test bench completed" at the end of their runtime. Inputs and outputs can be viewed in stdout window and in waveform window.



Cache cell test bench
```bash
/umbc/software/scripts/launch_cadence_xrun.sh -top tb_cache_cell vhdl/tb/tb_cache_cell.vhd -gui -access rwc -work work

# Open the waveform window and run this for 100ns.
```


Byte selector test bench 
```bash
/umbc/software/scripts/launch_cadence_xrun.sh -top tb_byte_selector vhdl/tb/tb_byte_selector.vhd -gui -access rwc -work work

# Open the waveform window and run this for 100ns.
```


State machine test bench
```bash
/umbc/software/scripts/launch_cadence_xrun.sh -top tb_state_machine vhdl/tb/tb_state_machine.vhd -gui -access rwc -work work

# Open the waveform window and run this for 2100ns
```


Cache test bench
```bash
/umbc/software/scripts/launch_cadence_xrun.sh -top tb_timed_cache vhdl/tb/tb_timed_cache.vhd -gui -access rwc -work work

# Open the waveform window and run this for 2500ns.
```


Chip test bench
```bash
/umbc/software/scripts/launch_cadence_xrun.sh -top chip_test_stdout vhdl/tb/chip_test_stdout.vhd -gui -access rwc -work work

# Open the waveform window and run this for 1000ns.
```
