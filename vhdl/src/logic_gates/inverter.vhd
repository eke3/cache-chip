-- inverter.vhd

library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;

entity inverter is
    port (
        input  : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end inverter;

architecture Structural of inverter is

begin

    output <= not input;

end Structural;

