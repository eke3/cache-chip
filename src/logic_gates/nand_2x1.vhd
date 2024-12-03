-- Entity: nand_2x1
-- Architecture: Structural

library IEEE;
use IEEE.std_logic_1164.all;

entity nand_2x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end nand_2x1;

architecture Structural of nand_2x1 is
    -- Declare the and_2x1 component
    component and_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    -- Declare the inverter component
    component inverter
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    -- Intermediate signal
    signal and_out : STD_LOGIC;

    -- Use the work library components
    for and_gate: and_2x1 use entity work.and_2x1(Structural);
    for inv_gate: inverter use entity work.inverter(Structural);

begin
    -- Instantiate the and_2x1 gate to calculate A and B
    and_gate: and_2x1
    port map (
        A      => A,
        B      => B,
        output => and_out
    );

    -- Instantiate the inverter to invert the output of the and_2x1 gate
    inv_gate: inverter
    port map (
        input  => and_out,
        output => output
    );

end Structural;

