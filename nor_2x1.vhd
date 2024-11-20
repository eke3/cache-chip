library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nor_2x1 is
    port(
        A      : in  std_logic; -- First input
        B      : in  std_logic; -- Second input
        output : out std_logic  -- NOR output
    );
end entity nor_2x1;

architecture behavioral of nor_2x1 is
begin
    -- Assign the NOR operation to the output
    output <= not (A or B);
end architecture behavioral;
