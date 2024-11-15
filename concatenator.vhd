library IEEE;
use IEEE.std_logic_1164.all;

-- Entity for concatenator
entity concatenator is
    port (
        input_a : in std_logic_vector(1 downto 0);  -- First 2-bit input
        input_b : in std_logic_vector(1 downto 0);  -- Second 2-bit input
        output  : out std_logic_vector(3 downto 0)  -- Concatenated 4-bit output
    );
end entity concatenator;

-- Architecture using structural approach
architecture structural of concatenator is
    -- Declare a component that acts as a simple bit buffer
    component buffer_1bit is
        port (
            in_bit : in std_logic;
            out_bit : out std_logic
        );
    end component;

    -- Intermediate signals for each individual bit of the 4-bit output
    signal bit_0, bit_1, bit_2, bit_3 : std_logic;
    
begin
    -- Instantiate buffer components for each bit
    buffer_bit_0 : buffer_1bit
        port map (
            in_bit  => input_a(0),
            out_bit => bit_0
        );

    buffer_bit_1 : buffer_1bit
        port map (
            in_bit  => input_a(1),
            out_bit => bit_1
        );

    buffer_bit_2 : buffer_1bit
        port map (
            in_bit  => input_b(0),
            out_bit => bit_2
        );

    buffer_bit_3 : buffer_1bit
        port map (
            in_bit  => input_b(1),
            out_bit => bit_3
        );

    -- Concatenate the output bits to form the 4-bit result
    output <= bit_1 & bit_0 & bit_3 & bit_2;  -- Corrected order

end architecture structural;