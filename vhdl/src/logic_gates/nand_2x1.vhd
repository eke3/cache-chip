-- Entity: nand_2x1
-- Architecture: Structural

library IEEE;
use IEEE.std_logic_1164.all;

entity nand_2x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end nand_2x1;

architecture Structural of nand_2x1 is

begin

    output <= A nand B;

end Structural;

