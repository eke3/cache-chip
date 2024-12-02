library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nor_2x1 is
    port (
        A      : in  std_logic; -- First input
        B      : in  std_logic; -- Second input
        output : out std_logic -- NOR output
    );
end nor_2x1;

architecture Structural of nor_2x1 is

    component inverter
        port (
            input  : in  std_logic;     -- Input
            output : out std_logic      -- Output
        );
    end component;

    component or_2x1
        port (
            A      : in  std_logic;     -- First input
            B      : in  std_logic;     -- Second input
            output : out std_logic      -- OR output
        );
    end component;

    signal or_out, nor_out : std_logic; -- Intermediate signals

    -- Use the work library components
    for or_gate: or_2x1 use entity work.or_2x1(Structural);
    for inverter_gate: inverter use entity work.inverter(Structural);

begin

    -- Instantiate the or_2x1 gate to calculate A or B
    or_gate: or_2x1
    port map (
        A      => A,
        B      => B,
        output => or_out
    );

    -- Instantiate the inverter to invert the output of the or_2x1 gate
    inverter_gate: inverter
    port map (
        input  => or_out,
        output => nor_out
    );

    -- The final output is the inverted OR result (NOR)
    output <= nor_out;

end Structural;

