-- Entity: xnor_2x1
-- Architecture: behavioral
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity xnor_2x1 is
    port (
        A      : in  STD_LOGIC; -- Input 0
        B      : in  STD_LOGIC; -- Input 1
        output : out STD_LOGIC  -- Output of the XNOR gate
    );
end entity xnor_2x1;

architecture Behavioral of xnor_2x1 is
begin
    -- XNOR logic: output is the inverse of XOR
    output <= not (A xor B);

end architecture Behavioral;