library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1_8bit is
    port (
        inputs : in  STD_LOGIC_VECTOR(127 downto 0);  -- 16 inputs, each 8-bit wide
        sel    : in  STD_LOGIC_VECTOR(15 downto 0);   -- 16-bit 1-hot select signal
        output : out STD_LOGIC_VECTOR(7 downto 0)     -- 8-bit output
    );
end entity mux_16x1_8bit;

architecture Structural of mux_16x1_8bit is

    -- Declare the 2x1 8-bit multiplexer component
    component mux_2x1_8bit
        port (
            A      : in  STD_LOGIC_VECTOR(7 downto 0); -- Input 0 (8 bits)
            B      : in  STD_LOGIC_VECTOR(7 downto 0); -- Input 1 (8 bits)
            sel    : in  STD_LOGIC;                   -- Selector
            output : out STD_LOGIC_VECTOR(7 downto 0) -- 8-bit output
        );
    end component;

    component concatenator_8bit.vhd
        port(
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
    end component;

    signal bits: std_logic_vector(127 downto 0);

begin

   gen_1: for i in 0 to 8 generate
   buffer_bit_0: entity work.concatenator_8bit.vhd
   port map (
    in0 => inputs(i);
    in1 => inputs(i+8);
    in2 => inputs (i+16);  -- First 2-bit input
    in3 => inputs (i+24); -- Second 2-bit input
    in4 => inputs (i+32);  -- First 2-bit input
    in5 => inputs (i+40);  -- Second 2-bit input
    in6 => inputs (i+48);  -- First 2-bit input
    in7 => inputs (i+56);  -- Second 2-bit input
    in8 => inputs (i+64);  -- First 2-bit input
    in9 => inputs (i+72);  -- Second 2-bit input
    in10 => inputs (i+80);  -- First 2-bit input
    in11 => inputs (i+88);  -- Second 2-bit input
    in12 => inputs (i+96);  -- First 2-bit input
    in13 => inputs (i+104);  -- Second 2-bit input
    in14 => inputs (i+112); -- First 2-bit input
    in15 => inputs (i+120); -- Second 2-bit input

    output => bits((8*i)-1 downto (8*i)-16)  -- Concatenated 4-bit output
   );
end generate;

    

end architecture Structural;
