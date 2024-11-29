library IEEE;
use IEEE.std_logic_1164.all;

-- Entity for concatenator
entity concatenator is
    port (
        input_a : in  std_logic_vector(1 downto 0); -- First 2-bit input
        input_b : in  std_logic_vector(1 downto 0); -- Second 2-bit input
        output  : out std_logic_vector(3 downto 0) -- Concatenated 4-bit output
    );
end entity concatenator;

-- Architecture using Structural approach
architecture Structural of concatenator is

begin

    -- Concatenate the output bits to form the 4-bit result
    output <= (input_a(1), input_a(0), input_b(1), input_b(0));

end architecture Structural;
