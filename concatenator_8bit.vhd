library IEEE;
use IEEE.std_logic_1164.all;

-- Entity for concatenator
entity concatenator_8bit is
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
end entity concatenator_8bit;

-- Architecture using Structural approach
architecture Structural of concatenator_8bit is
    -- Declare a component that acts as a simple bit buffer
    component buffer_1bit is
        port (
            in_bit : in std_logic;
            out_bit : out std_logic
        );
    end component;

    -- Intermediate signals for each individual bit of the 4-bit output
    signal bits: std_logic_vector(15 downto 0);
    
    for buffer1, buffer2, buffer3, buffer4, buffer5, buffer6, buffer7, buffer8, buffer9, buffer10, buffer11, buffer12, buffer13, buffer14, buffer15, buffer16: buffer_1bit use entity work.buffer_1bit(Structural);
    
begin
    -- Instantiate buffer components for each bit

   buffer1: component buffer_1bit
    port map (
        in0,
        out_bit => bits(0)
    );
    
    buffer2: component buffer_1bit
    port map (
        in1,
        out_bit => bits(1)
    );
    
    buffer3: component buffer_1bit
    port map (
        in2,
        out_bit => bits(2)
    );

    buffer4: component buffer_1bit
    port map (
        in3,
        out_bit => bits(3)
    );
    
    buffer5: component buffer_1bit
    port map (
        in4,
        out_bit => bits(4)
    );
    
    buffer6: component buffer_1bit
    port map (
        in5,
        out_bit => bits(5)
    );
    
    buffer7: component buffer_1bit
    port map (
        in6,
        out_bit => bits(6)
    );
    
    buffer8: component buffer_1bit
    port map (
        in7,
        out_bit => bits(7)
    );
    
    buffer9: component buffer_1bit
    port map (
        in8,
        out_bit => bits(8)
    );
    
    buffer10: component buffer_1bit
    port map (
        in9,
        out_bit => bits(9)
    );

    buffer11: component buffer_1bit
    port map (
        in10,
        out_bit => bits(10)
    );
    
    buffer12: component buffer_1bit
    port map (
        in11,
        out_bit => bits(11)
    );
    
    buffer13: component buffer_1bit
    port map (
        in12,
        out_bit => bits(12)
    );
    
    buffer14: component buffer_1bit
    port map (
        in13,
        out_bit => bits(13)
    );

    buffer15: component buffer_1bit
    port map (
        in14,
        out_bit => bits(14)
    );
    
    buffer16: component buffer_1bit
    port map (
        in15,
        out_bit => bits(15)
    );
    -- Concatenate the output bits to form the 4-bit result
    output <= bits(15) & bits(14) & bits(13) & bits(12) & bits(11) & bits(10) & bits(9) & bits(8) & bits(7) & bits(6) & bits(5) & bits(4) & bits(3) & bits(2) & bits(1) & bits(0);  -- Corrected order

end architecture Structural;