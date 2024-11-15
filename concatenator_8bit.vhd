library IEEE;
use IEEE.std_logic_1164.all;

-- Entity for concatenator
entity concatenator is
    port (
        in0 : in std_logic;  -- First 2-bit input
        in1 : in std_logic;  -- Second 2-bit input
        in2 : in std_logic;  -- First 2-bit input
        in3 : in std_logic;  -- Second 2-bit input
        in4 : in std_logic;  -- First 2-bit input
        in5 : in std_logic;  -- Second 2-bit input
        in6 : in std_logic;  -- First 2-bit input
        in7 : in std_logic;  -- Second 2-bit input
        in8 : in std_logic;  -- First 2-bit input
        in9 : in std_logic;  -- Second 2-bit input
        in10 : in std_logic;  -- First 2-bit input
        in11 : in std_logic;  -- Second 2-bit input
        in12 : in std_logic;  -- First 2-bit input
        in13 : in std_logic;  -- Second 2-bit input
        in14 : in std_logic;  -- First 2-bit input
        in15 : in std_logic;  -- Second 2-bit input

        output  : out std_logic_vector(15 downto 0)  -- Concatenated 4-bit output
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
    signal bit: std_logic_vector(15 downto 0);
    
begin
    -- Instantiate buffer components for each bit

    gen_1: for i in 0 to 15 generate
        buffer_bit_0: entity work.buffer_1bit
        port map (
            in_bit  => input_a(i),
            out_bit => bit(i)
        );
    end generate;

    -- Concatenate the output bits to form the 4-bit result
    output <= bit(15) & bit(14) & bit(13) & bit(12) & bit(11) & bit(10) & bit(9) & bit(8) & bit(7) & bit(6) & bit(5) & bit(4) & bit(3) & bit(2) & bit(1) & bit(0);  -- Corrected order

end architecture structural;