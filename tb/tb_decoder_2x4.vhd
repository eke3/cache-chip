-- tb_decoder_2x4.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
use IEEE.numeric_std.all;

entity tb_decoder_2x4 is
end tb_decoder_2x4;

architecture Test of tb_decoder_2x4 is
    -- Component declaration for the Unit Under Test (UUT)
    component decoder_2x4
        port (
            A : in  std_logic_vector(1 downto 0);
            E : in  std_logic;
            Y : out std_logic_vector(3 downto 0)
        );
    end component;

    for all: decoder_2x4 use entity work.decoder_2x4(Structural);

    -- Signals for the decoder inputs and outputs
    signal A            : std_logic_vector(1 downto 0);
    signal E            : std_logic;
    signal Y            : std_logic_vector(3 downto 0);

    -- 3-bit unsigned vector for generating inputs
    signal input_vector : unsigned(2 downto 0) := "000";

    -- Procedure to print the inputs and outputs of the decoder
    procedure print_output 
        variable out_line : line;

    begin
        -- Print the current value of the inputs
        write(out_line, string'("E: "));
        write(out_line, std_logic'image(E));
        write(out_line, string'(" A: "));
        write(out_line, std_logic'image(A(1)));
        write(out_line, std_logic'image(A(0)));

        -- Print the outputs
        write(out_line, string'(" | Y: "));
        write(out_line, std_logic'image(Y(3)));
        write(out_line, std_logic'image(Y(2)));
        write(out_line, std_logic'image(Y(1)));
        write(out_line, std_logic'image(Y(0)));

        writeline(output, out_line);
    end print_output;

begin

    -- Instantiate the decoder_2x4 entity
    DUT: decoder_2x4
    port map (
        A => A,
        E => E,
        Y => Y
    );

    -- Stimulus process
    stimulus_process: process
    begin
        -- Iterate through all 8 possible values of the input vector
        for i in 0 to 7 loop
            -- Assign the most significant bit of input_vector to E
            E            <= std_logic(input_vector(2));

            -- Assign the two least significant bits of input_vector to A
            A            <= std_logic_vector(input_vector(1 downto 0));

            -- Wait for 5 ns before the next change
            wait for 5 ns;

            -- Print the output again
            print_output;

            -- Wait for 45 ns before incrementing the input_vector
            wait for 45 ns;

            -- Increment the input_vector
            input_vector <= input_vector + 1;
        end loop;

        --        -- Return to initial state and print the output once more
        input_vector     <= "000";
        E                <= std_logic(input_vector(2));
        A                <= std_logic_vector(input_vector(1 downto 0));
        wait for 5 ns;
        print_output;

        --        -- End simulation
        assert false report "Test bench completed." severity failure;
    end process;

end Test;
