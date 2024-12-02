library IEEE;
use IEEE.std_logic_1164.all;

-- Entity for concatenator
entity concatenator_8bit is
    port (
        in0    : in  std_logic;
        in1    : in  std_logic;
        in2    : in  std_logic;
        in3    : in  std_logic;
        in4    : in  std_logic;
        in5    : in  std_logic;
        in6    : in  std_logic;
        in7    : in  std_logic;
        in8    : in  std_logic;
        in9    : in  std_logic;
        in10   : in  std_logic;
        in11   : in  std_logic;
        in12   : in  std_logic;
        in13   : in  std_logic;
        in14   : in  std_logic;
        in15   : in  std_logic;
        output : out std_logic_vector(15 downto 0)
    );
end concatenator_8bit;

-- Architecture using Structural approach
architecture Structural of concatenator_8bit is

begin

    output <= (in15, in14, in13, in12, in11, in10, in9, in8, in7, in6, in5, in4, in3, in2, in1, in0);

end Structural;
