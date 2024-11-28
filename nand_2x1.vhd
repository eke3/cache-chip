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
end entity nand_2x1;

architecture Structural of nand_2x1 is
    -- Declare the and_2x1 component
    component and_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_2x1;

    -- Declare the inverter component
    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    -- intermediate signal
    signal and_out : STD_LOGIC;

begin
    -- Instantiate the and_2x1 gate to calculate A and B
    and_gate: entity work.and_2x1(Structural)
        port map (
            A      => A,
            B      => B,
            output => and_out
        );

    -- Instantiate the inverter to invert the output of the and_2x1 gate
    inv_gate: entity work.inverter(Structural)
        port map (
            input  => and_out,
            output => output
        );

end architecture Structural;

