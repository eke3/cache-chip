# CMPE413_project

## Compiling on Lab Computers
Navigate to project directory.

```bash
cd /afs/umbc.edu/users/e/e/eekey1/home/cadence/proj01/
```


Compile all files to the 'work' library.

```bash
./launch_cadence_xrun.sh -work work src/*/*.vhd src/*.vhd tb/*.vhd
```

## Running on Lab Computers
Run chip_test_stdout.vhd simulation for 800ns.

```bash
./launch_cadence_xrun.sh -top chip_test_stdout -gui -access rwc -duration 800ns -work work
```


