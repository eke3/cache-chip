-- and_2x1.vhd

library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.ALL;

entity and_2x1 is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           output : out STD_LOGIC);
end and_2x1;

architecture Structural of and_2x1 is

begin
    output <= A and B;

end Structural;
