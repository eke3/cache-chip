-- comparator_2x1.vhd
-- 2-input XNOR gate with inputs A, B and output

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity valid_comparator_2x1 is
    Port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end valid_comparator_2x1;

architecture Structural of valid_comparator_2x1 is
begin
    output <= A xnor B;
end Structural;
