# CMPE413_project

## Compiling on Lab Computers
Navigate to project directory.

```bash
cd /afs/umbc.edu/users/e/e/eekey1/home/cadence/proj01/
```


Compile all files to the 'work' library.

```bash
./launch_cadence_xrun.sh -top <TESTBENCH NAME> src/*/*.vhd src/*.vhd tb/<TESTBENCH NAME>.vhd -work work
```

## Running on Lab Computers
Run chip_test_stdout.vhd simulation.

```bash
./launch_cadence_xrun.sh -top chip_test_stdout -gui -access rwc -work work
```


