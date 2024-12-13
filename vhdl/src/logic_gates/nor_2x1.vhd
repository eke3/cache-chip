library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nor_2x1 is
    port (
        A      : in  std_logic; -- First input
        B      : in  std_logic; -- Second input
        output : out std_logic -- NOR output
    );
end nor_2x1;

architecture Structural of nor_2x1 is

begin

    output <= A nor B;

end Structural;

