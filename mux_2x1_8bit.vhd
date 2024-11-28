-- Entity: mux_2x1_8bit
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_2x1_8bit is
    port (
        A      : in  STD_LOGIC_VECTOR(7 downto 0); -- Input 0 (8 bits)
        B      : in  STD_LOGIC_VECTOR(7 downto 0); -- Input 1 (8 bits)
        sel    : in  STD_LOGIC;                    -- sel signal
        output : out STD_LOGIC_VECTOR(7 downto 0)  -- Output of the multiplexer (8 bits)
    );
end entity mux_2x1_8bit;

architecture Structural of mux_2x1_8bit is
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
    signal and_out0, and_out1 : STD_LOGIC_VECTOR(7 downto 0);
    -- Intermediate signal for inverted sel bit
    signal sel_not            : STD_LOGIC;

    -- Instantiate the components
    for sel_inverter: inverter use entity work.inverter(Structural);

begin

    -- Instantiate the inverter to generate sel_not signal
    sel_inverter: component inverter
    port map (
        input  => sel,
        output => sel_not
    );

    -- Instantiate the and_2x1 gates for each bit of the 8-bit input
    gen_and_gate0: for i in 0 to 7 generate
        and_gate0: entity work.and_2x1
        port map (
            A      => A(i),
            B      => sel_not,
            output => and_out0(i)
        );
    end generate gen_and_gate0;

    gen_and_gate1: for i in 0 to 7 generate
        and_gate1: entity work.and_2x1
        port map (
            A      => B(i),
            B      => sel,
            output => and_out1(i)
        );
    end generate gen_and_gate1;

    -- Instantiate the or_2x1 gate to combine the outputs of the and gates for each bit
    gen_or_gate: for i in 0 to 7 generate
        or_gate: entity work.or_2x1
        port map (
            A      => and_out0(i),
            B      => and_out1(i),
            output => output(i)
        );
    end generate gen_or_gate;

end architecture Structural;
