-- or_3x1.vhd

library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;

entity or_3x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        C      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end entity or_3x1;

architecture Structural of or_3x1 is

begin
    output <= A or B or C;

end architecture Structural;