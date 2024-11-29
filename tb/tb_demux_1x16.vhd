-- tb_demux_1x16.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
use IEEE.numeric_std.all;

entity tb_demux_1x16 is
end entity tb_demux_1x16;

architecture Test of tb_demux_1x16 is

    -- Signals for the demux_1x16 inputs and outputs
    signal data_in      : std_logic;
    signal sel          : std_logic_vector(3 downto 0);
    signal data_out_0   : std_logic;
    signal data_out_1   : std_logic;
    signal data_out_2   : std_logic;
    signal data_out_3   : std_logic;
    signal data_out_4   : std_logic;
    signal data_out_5   : std_logic;
    signal data_out_6   : std_logic;
    signal data_out_7   : std_logic;
    signal data_out_8   : std_logic;
    signal data_out_9   : std_logic;
    signal data_out_10  : std_logic;
    signal data_out_11  : std_logic;
    signal data_out_12  : std_logic;
    signal data_out_13  : std_logic;
    signal data_out_14  : std_logic;
    signal data_out_15  : std_logic;

    -- 5-bit unsigned vector for generating inputs (to iterate through data_in and sel)
    signal input_vector : unsigned(4 downto 0) := "00000";

    -- Procedure to print the inputs and outputs of the demux_1x16
    procedure print_output is
        variable out_line        : line;
        variable output_sequence : std_logic_vector(15 downto 0); -- Concatenated outputs
    begin
        -- Print the current values of the inputs
        write(out_line, string'("Data In: "));
        write(out_line, std_logic'image(data_in));
        write(out_line, string'(" Sel: "));
        for i in 3 downto 0 loop
            write(out_line, std_logic'image(sel(i)));
        end loop;

        -- Concatenate the outputs into a single 16-bit sequence from data_out_15 to data_out_0
        output_sequence  :=
            data_out_15 & data_out_14 & data_out_13 & data_out_12 & data_out_11 & data_out_10 & data_out_9 & data_out_8
                & data_out_7 & data_out_6 & data_out_5 & data_out_4 & data_out_3 & data_out_2 & data_out_1 & data_out_0;

        -- Print the output sequence
        write(out_line, string'(" | Data Out (15-0): "));
        for i in 15 downto 0 loop
            write(out_line, std_logic'image(output_sequence(i)));
        end loop;

        writeline(output, out_line);
    end procedure print_output;

begin

    -- Instantiate the demux_1x16 entity
    DUT: entity work.demux_1x16
    port map (
        data_in     => data_in,
        sel         => sel,
        data_out_0  => data_out_0,
        data_out_1  => data_out_1,
        data_out_2  => data_out_2,
        data_out_3  => data_out_3,
        data_out_4  => data_out_4,
        data_out_5  => data_out_5,
        data_out_6  => data_out_6,
        data_out_7  => data_out_7,
        data_out_8  => data_out_8,
        data_out_9  => data_out_9,
        data_out_10 => data_out_10,
        data_out_11 => data_out_11,
        data_out_12 => data_out_12,
        data_out_13 => data_out_13,
        data_out_14 => data_out_14,
        data_out_15 => data_out_15
    );

    -- Stimulus process
    stimulus_process: process
    begin
        -- Iterate through all 32 possible values of the input vector
        for i in 0 to 31 loop
            -- Assign the most significant bit of input_vector to data_in
            data_in      <= std_logic(input_vector(4));

            -- Assign the four least significant bits of input_vector to sel
            sel          <= std_logic_vector(input_vector(3 downto 0));

            -- Wait for 5 ns before the next change
            wait for 5 ns;

            -- Print the output
            print_output;

            -- Wait for 45 ns before incrementing the input_vector
            wait for 15 ns;

            -- Increment the input_vector
            input_vector <= input_vector + 1;
        end loop;

        -- Return to initial state and print the output once more
        input_vector     <= "00000";
        data_in          <= std_logic(input_vector(4));
        sel              <= std_logic_vector(input_vector(3 downto 0));
        wait for 5 ns;
        print_output;

        -- End simulation
        wait;
    end process stimulus_process;

end architecture Test;
