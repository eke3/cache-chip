-- Entity: buffer_8bit
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity buffer_8bit is
    port (
        input  : in  STD_LOGIC_VECTOR(7 downto 0);
        output : out STD_LOGIC_VECTOR(7 downto 0)
    );
end buffer_8bit;

architecture Structural of buffer_8bit is

    component inverter
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for all: inverter use entity work.inverter(Structural);

    signal intermediate : STD_LOGIC_VECTOR(7 downto 0);

begin

    inv: inverter port map(input(0), intermediate(0));
    inv1: inverter port map(input(1), intermediate(1)); 
    inv2: inverter port map(input(2), intermediate(2)); 
    inv3: inverter port map(input(3), intermediate(3)); 
    inv4: inverter port map(input(4), intermediate(4)); 
    inv5: inverter port map(input(5), intermediate(5)); 
    inv6: inverter port map(input(6), intermediate(6)); 
    inv7: inverter port map(input(7), intermediate(7));

    inv8: inverter port map(intermediate(0), output(0));
    inv9: inverter port map(intermediate(1), output(1)); 
    inv10: inverter port map(intermediate(2), output(2)); 
    inv11: inverter port map(intermediate(3), output(3)); 
    inv12: inverter port map(intermediate(4), output(4)); 
    inv13: inverter port map(intermediate(5), output(5)); 
    inv14: inverter port map(intermediate(6), output(6)); 
    inv15: inverter port map(intermediate(7), output(7));
end Structural;