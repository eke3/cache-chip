library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use STD.TEXTIO.all;

entity valid_cell_tb is
end entity valid_cell_tb;

architecture Test of valid_cell_tb is

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
        write_data  => write_data,
        reset       => reset,
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data
    );

    -- Stimulus process to apply test vectors to the DUT
    stimulus_process: process
    begin
        -- Test Case 1: Apply reset = 1 (Expect read_data = 0)
        reset       <= '0';
        write_data  <= 'X';
        chip_enable <= '0';
        RW          <= 'X';
        wait for 10 ns;
        reset <= '1';
        wait for 10 ns;
        print_output;
        
        reset <= '0';
        wait for 10 ns;
        print_output;
        
        RW <= '1';
        chip_enable <= '1';
        wait for 10 ns;
        print_output;

        -- Test Case 2: Release reset and write 1 to the cell
        reset       <= '0';
        write_data  <= '1';
        chip_enable <= '1';
        RW          <= '0'; -- Write mode
        wait for 10 ns;
        print_output;

        -- Test Case 3: Read the stored value (Expect read_data = 1)
        RW          <= '1'; -- Read mode
        wait for 10 ns;
        print_output;

        -- Test Case 4: Set reset to 1 to clear the data
        reset       <= '1';
        wait for 10 ns;
        print_output;

        -- Test Case 5: Release reset and attempt to write 0
        reset       <= '0';
        write_data  <= '0';
        RW          <= '0'; -- Write mode
        wait for 10 ns;
        print_output;

        -- Test Case 6: Read the cleared value (Expect read_data = 0)
        RW          <= '1'; -- Read mode
        wait for 10 ns;
        print_output;

        -- Test Case 7: Disable chip_enable and attempt to write 1 (Expect no write)
        chip_enable <= '0';
        write_data  <= '1';
        RW          <= '0'; -- Write mode
        wait for 10 ns;
        print_output;

        -- Test Case 8: Enable chip and read to check no write occurred
        chip_enable <= '1';
        RW          <= '1'; -- Read mode
        wait for 10 ns;
        print_output;

        -- End simulation
        report "Test bench completed successfully.";
        wait;
    end process stimulus_process;

end architecture Test;
