-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 12:15:47 2024


architecture Structural of demux_1x2 is
    -- Declare the components for the inverter and 2-input AND gate
    component inverter
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component and_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    -- Internal signal for the inverted selector bit
    signal sel_not : STD_LOGIC; -- NOT of sel

    -- Component binding statements
    for all : inverter use entity work.inverter(Structural);
    for all : and_2x1 use entity work.and_2x1(Structural);

begin
    -- Instantiate the inverter for sel
    inv0: inverter
    port map (
        input  => sel,
        output => sel_not
    );

    -- Instantiate the 2-input AND gates to route data_in to the outputs
    and_gate_1: and_2x1
    port map (
        A      => data_in,
        B      => sel_not,      -- AND with inverted sel for data_out_1
        output => data_out_1
    );

    and_gate_2: and_2x1
    port map (
        A      => data_in,
        B      => sel,          -- AND with sel for data_out_2
        output => data_out_2
    );

end Structural;
