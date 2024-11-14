-- demux_1x2_tb.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
use IEEE.numeric_std.all;

entity demux_1x2_tb is

end entity demux_1x2_tb;

architecture Test of demux_1x2_tb is

    -- Signals for the demux_1x2 inputs and outputs
    signal data_in      : std_logic;
    signal sel          : std_logic;
    signal data_out_1   : std_logic;
    signal data_out_2   : std_logic;

    -- 2-bit unsigned vector for generating inputs
    signal input_vector : unsigned(1 downto 0) := "00";

    -- Procedure to print the inputs and outputs of the demux_1x2
    procedure print_output is
        variable out_line : line;
    begin
        -- Print the current value of the inputs
        write(out_line, string'("Data In: "));
        write(out_line, std_logic'image(data_in));
        write(out_line, string'(" Sel: "));
        write(out_line, std_logic'image(sel));

        -- Print the outputs
        write(out_line, string'(" | Data Out 1: "));
        write(out_line, std_logic'image(data_out_1));
        write(out_line, string'(" Data Out 2: "));
        write(out_line, std_logic'image(data_out_2));

        writeline(output, out_line);
    end procedure print_output;

begin

    -- Instantiate the demux_1x2 entity
    DUT: entity work.demux_1x2
    port map (
        data_in    => data_in,
        sel        => sel,
        data_out_1 => data_out_1,
        data_out_2 => data_out_2
    );

    -- Stimulus process
    stimulus_process: process
    begin
        -- Iterate through all 4 possible values of the input vector
        for i in 0 to 3 loop
            -- Assign the most significant bit of input_vector to sel
            sel          <= std_logic(input_vector(1));

            -- Assign the least significant bit of input_vector to data_in
            data_in      <= std_logic(input_vector(0));

            -- Wait for 5 ns before the next change
            wait for 5 ns;

            -- Print the output again
            print_output;

            -- Wait for 45 ns before incrementing the input_vector
            wait for 45 ns;

            -- Increment the input_vector
            input_vector <= input_vector + 1;
        end loop;

        -- Return to initial state and print the output once more
        input_vector     <= "00";
        sel              <= std_logic(input_vector(1));
        data_in          <= std_logic(input_vector(0));
        wait for 5 ns;
        print_output;

        -- End simulation
        wait;
    end process stimulus_process;

end architecture Test;
