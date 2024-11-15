library IEEE;
use IEEE.std_logic_1164.all;

entity concatenator is
    port(
        input_a : in std_logic_vector(1 downto 0);  -- First 2-bit input
        input_b : in std_logic_vector(1 downto 0);  -- Second 2-bit input
        output  : out std_logic_vector(3 downto 0)  -- Concatenated 4-bit output
    );
end entity concatenator;

architecture behavioral of concatenator is
begin
    -- Concatenate input_a and input_b to form a 4-bit output
    output <= input_a & input_b;
end architecture behavioral;