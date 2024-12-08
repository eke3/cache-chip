-- Entity: tb_demux_1x8
-- Architecture: Test
-- Note: Run for 1000 ns

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
use IEEE.numeric_std.all;

entity tb_demux_1x8 is
end tb_demux_1x8;

architecture Test of tb_demux_1x8 is
    -- Component declaration for demux_1x8
    component demux_1x8
        port (
            data_in    : in  std_logic;
            sel        : in  std_logic_vector(2 downto 0);
            data_out_0 : out std_logic;
            data_out_1 : out std_logic;
            data_out_2 : out std_logic;
            data_out_3 : out std_logic;
            data_out_4 : out std_logic;
            data_out_5 : out std_logic;
            data_out_6 : out std_logic;
            data_out_7 : out std_logic
        );
    end component;

    for all: demux_1x8 use entity work.demux_1x8(Structural);

    -- Signals for the demux_1x8 inputs and outputs
    signal data_in      : std_logic;
    signal sel          : std_logic_vector(2 downto 0);
    signal data_out_0   : std_logic;
    signal data_out_1   : std_logic;
    signal data_out_2   : std_logic;
    signal data_out_3   : std_logic;
    signal data_out_4   : std_logic;
    signal data_out_5   : std_logic;
    signal data_out_6   : std_logic;
    signal data_out_7   : std_logic;

    -- 4-bit unsigned vector for generating inputs
    signal input_vector : unsigned(3 downto 0) := "0000";

    -- Procedure to print the inputs and outputs of the demux_1x8
    procedure print_output 
        variable out_line        : line;
        variable output_sequence : std_logic_vector(7 downto 0); -- to hold concatenated outputs
    begin
        -- Print the current values of the inputs
        write(out_line, string'("Data In: "));
        write(out_line, std_logic'image(data_in));
        write(out_line, string'(" Sel: "));
        for i in 2 downto 0 loop
            write(out_line, std_logic'image(sel(i)));
        end loop;

        -- Concatenate the outputs into a single 8-bit sequence, from data_out_7 to data_out_0
        output_sequence  :=
            data_out_7 & data_out_6 & data_out_5 & data_out_4 & data_out_3 & data_out_2 & data_out_1 & data_out_0;

        -- Print the output sequence
        write(out_line, string'(" | Data Out (7-0): "));
        for i in 7 downto 0 loop
            write(out_line, std_logic'image(output_sequence(i)));
        end loop;

        writeline(output, out_line);
    end print_output;

begin

    -- Instantiate the demux_1x8 entity
    DUT: demux_1x8
    port map (
        data_in    => data_in,
        sel        => sel,
        data_out_0 => data_out_0,
        data_out_1 => data_out_1,
        data_out_2 => data_out_2,
        data_out_3 => data_out_3,
        data_out_4 => data_out_4,
        data_out_5 => data_out_5,
        data_out_6 => data_out_6,
        data_out_7 => data_out_7
    );

    -- Stimulus process
    stimulus_process: process
    begin
        -- Iterate through all 16 possible values of the input vector
        for i in 0 to 15 loop
            -- Assign the most significant bit of input_vector to data_in
            data_in      <= std_logic(input_vector(3));

            -- Assign the three least significant bits of input_vector to sel
            sel          <= std_logic_vector(input_vector(2 downto 0));

            -- Wait for 5 ns before the next change
            wait for 5 ns;

            -- Print the output
            print_output;

            -- Wait for 45 ns before incrementing the input_vector
            wait for 45 ns;

            -- Increment the input_vector
            input_vector <= input_vector + 1;
        end loop;

        -- Return to initial state and print the output once more
        input_vector     <= "0000";
        data_in          <= std_logic(input_vector(3));
        sel              <= std_logic_vector(input_vector(2 downto 0));
        wait for 5 ns;
        print_output;

        -- End simulation
        assert false report "Test bench completed." severity failure;
    end process;

end Test;
