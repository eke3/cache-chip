-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 12:15:47 2024


architecture Structural of mux_2x1 is
    -- Declare the and_2x1 component
    component and_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    -- Declare the or_2x1 component
    component or_2x1
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

    for all: inverter use entity work.inverter(Structural);
    for all: and_2x1 use entity work.and_2x1(Structural);
    for all: or_2x1 use entity work.or_2x1(Structural);

    -- Intermediate signals for outputs of the and_2x1 gates
    signal and_out0, and_out1 : STD_LOGIC;
    -- Intermediate signal for inverted sel bit
    signal sel_not            : STD_LOGIC;
    signal mux_out            : STD_LOGIC;

begin

    -- Instantiate the inverter to generate sel_not signal
    sel_inverter: inverter
    port map (
        input  => sel,
        output => sel_not
    );

    -- Instantiate the and_2x1 gates to enable each data input based on sel signal
    and_gate0: and_2x1
    port map (
        A      => A,
        B      => sel_not,
        output => and_out0
    );

    and_gate1: and_2x1
    port map (
        A      => B,
        B      => sel,
        output => and_out1
    );

    -- Instantiate the or_2x1 gate to combine the outputs of the and gates
    or_gate: or_2x1
    port map (
        A      => and_out0,
        B      => and_out1,
        output => mux_out
    );

    -- Assign the output of the multiplexer to the output port
    output <= mux_out;

end Structural;
