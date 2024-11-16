library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use STD.TEXTIO.all;

entity cache_cell_tb is
end entity cache_cell_tb;

architecture Test of cache_cell_tb is

    -- Signals to connect to the cache_cell inputs and outputs
    signal write_data  : std_logic;
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

    -- Instantiate the cache_cell entity
    DUT: entity work.cache_cell
    port map (
        write_data  => write_data,
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data
    );

    -- Stimulus process to apply test vectors to the DUT
    stimulus_process: process
    begin
        -- Test Case 1: Try writing with chip_enable = 0 (Expect no write action)
        chip_enable <= '0';
        RW          <= '0'; -- Write mode
        write_data  <= '1';
        wait for 10 ns;
        print_output;

        -- Test Case 2: Write with chip_enable = 1, RW = 0 (Expect write_data to be stored)
        chip_enable <= '1';
        RW          <= '0'; -- Write mode
        write_data  <= '1';
        wait for 10 ns;
        print_output;

        -- Test Case 3: Read with chip_enable = 1, RW = 1 (Expect read_data to match stored value)
        RW          <= '1'; -- Read mode
        wait for 10 ns;
        print_output;

        -- Test Case 4: Overwrite with new write_data = 0
        write_data  <= '0';
        RW          <= '0'; -- Write mode
        wait for 10 ns;
        print_output;

        -- Test Case 5: Read after overwrite (Expect read_data = 0)
        RW          <= '1'; -- Read mode
        wait for 1 ns;
        write_data  <= '1';
        wait for 10 ns;
        print_output;

        -- Test Case 6: Disable chip_enable and attempt read (Expect read_data holds last value)
        chip_enable <= '0';
        wait for 10 ns;
        print_output;

        -- End simulation
        report "Test bench completed successfully.";
        wait;
    end process stimulus_process;

end architecture Test;
