-- Entity: demux_1x2
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x2 is
    port (
        data_in    : in  STD_LOGIC; -- 1-bit input data
        sel        : in  STD_LOGIC; -- 1-bit selector
        data_out_1 : out STD_LOGIC; -- Output for selection "0"
        data_out_2 : out STD_LOGIC -- Output for selection "1"
    );
end demux_1x2;

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

