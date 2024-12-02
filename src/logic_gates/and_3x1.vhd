-- Entity: and_3x1
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity and_3x1 is
    port (
        A      : in  STD_LOGIC; -- First input
        B      : in  STD_LOGIC; -- Second input
        C      : in  STD_LOGIC; -- Third input
        output : out STD_LOGIC -- Output of the 3-input AND gate
    );
end and_3x1;

architecture Structural of and_3x1 is
    -- Declare the and_2x1 component
    component and_2x1 
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;


    for and_gate1, and_gate2: and_2x1 use entity work.and_2x1(Structural);
    -- Intermediate signal to hold the result of the first and_2x1 gate
    signal intermediate : STD_LOGIC;

begin
    -- Instantiate the first and_2x1 gate to AND inputs A and B
    and_gate1: and_2x1
    port map (
        A      => A,
        B      => B,
        output => intermediate
    );

    -- Instantiate the second and_2x1 gate to AND intermediate with C
    and_gate2: and_2x1
    port map (
        A      => intermediate,
        B      => C,
        output => output
    );

end Structural;
