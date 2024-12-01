-- Entity: tb_valid_cell
-- Architecture: Test
-- Note: Run for 100 ns

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use STD.TEXTIO.all;

entity tb_valid_cell is
end entity tb_valid_cell;

architecture Test of tb_valid_cell is

    -- Component declaration for the valid_cell entity
    component valid_cell is
        port (
            vdd         : in  std_logic;
            gnd         : in  std_logic;
            write_data  : in  std_logic; -- Write data input
            reset       : in  std_logic; -- Reset signal
            chip_enable : in  std_logic; -- Chip enable signal
            RW          : in  std_logic; -- Read/Write signal
            read_data   : out std_logic  -- Read data output
        );
    end component valid_cell;

    -- Signals to connect to the valid_cell inputs and outputs
    signal write_data  : std_logic;
    signal reset       : std_logic;
    signal chip_enable : std_logic;
    signal RW          : std_logic;
    signal read_data   : std_logic;

    -- Procedure to print current input and output values
    procedure print_output is
        variable out_line : line;
    begin
        -- Print the input values
        write(out_line, string'("Inputs - Write Data: "));
        write(out_line, std_logic'image(write_data));
        write(out_line, string'(" Reset: "));
        write(out_line, std_logic'image(reset));
        write(out_line, string'(" Chip Enable: "));
        write(out_line, std_logic'image(chip_enable));
        write(out_line, string'(" RW: "));
        write(out_line, std_logic'image(RW));

        -- Print the output values
        write(out_line, string'(" | Output - Read Data: "));
        write(out_line, std_logic'image(read_data));

        -- Write to stdout
        writeline(output, out_line);
    end procedure print_output;

begin

    -- Instantiate the valid_cell entity
    DUT: entity work.valid_cell
    port map (
        vdd         => '1',
        gnd         => '0',
        write_data  => write_data,
        reset       => reset,
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data
    );

    -- Stimulus process to apply test vectors to the DUT
    stimulus_process: process
    begin
        -- Initialize inputs
        reset       <= 'Z';
        write_data  <= 'Z';
        chip_enable <= 'Z';
        RW          <= 'Z';
        wait for 10 ns;

        -- Test Case 1: Apply reset = 1 (Expect read_data = Z)
        reset       <= '1';
        wait for 10 ns;
        assert (read_data = 'Z') report "Test Case 1 failed." severity warning;
        print_output;
        reset       <= '0';
        wait for 10 ns;
        assert (read_data = 'Z') report "Test Case 1 failed." severity warning;
        print_output;
        -- Read the cell after reset
        RW          <= '1';
        chip_enable <= '1';
        wait for 10 ns;
        assert (read_data = '0') report "Test Case 1 failed." severity warning;
        print_output;

        -- Test Case 2: Write 1 to the cell
        write_data  <= '1';
        chip_enable <= '1';
        RW          <= '0';              -- Write mode
        wait for 10 ns;
        assert (read_data = 'Z') report "Test Case 2 failed." severity warning;
        print_output;
        -- Read the cell after writing 1
        RW          <= '1';              -- Read mode
        wait for 10 ns;
        assert (read_data = '1') report "Test Case 2 failed." severity warning;
        print_output;

        -- End simulation
        report "Testbench completed.";
        wait;
    end process stimulus_process;

end architecture Test;
