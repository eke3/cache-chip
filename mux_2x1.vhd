-- Entity: mux_2x1
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_2x1 is
    port (
        A      : in  STD_LOGIC; -- Input 0
        B      : in  STD_LOGIC; -- Input 1
        sel    : in  STD_LOGIC; -- sel signal
        output : out STD_LOGIC -- Output of the multiplexer
    );
end entity mux_2x1;

architecture Structural of mux_2x1 is
    -- Declare the and_2x1 component
    component and_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_2x1;

    -- Declare the or_2x1 component
    component or_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_2x1;

    -- Declare the inverter component
    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    -- Intermediate signals for outputs of the and_2x1 gates
    signal and_out0, and_out1 : STD_LOGIC;
    -- Intermediate signal for inverted sel bit
    signal sel_not            : STD_LOGIC;

    for sel_inverter: inverter use entity work.inverter(Structural);
    for and_gate0, and_gate1: and_2x1 use entity work.and_2x1(Structural);
    for or_gate: or_2x1 use entity work.or_2x1(Structural);

begin

    -- Instantiate the inverter to generate sel_not signal
    sel_inverter: component inverter
    port map (
        input  => sel,
        output => sel_not
    );

    -- Instantiate the and_2x1 gates to enable each data input based on sel signal
    and_gate0: component and_2x1
    port map (
        A      => A,
        B      => sel_not,
        output => and_out0
    );

    and_gate1: component and_2x1
    port map (
        A      => B,
        B      => sel,
        output => and_out1
    );

    -- Instantiate the or_2x1 gate to combine the outputs of the and gates
    or_gate: component or_2x1
    port map (
        A      => and_out0,
        B      => and_out1,
        output => output
    );

end architecture Structural;

