-- Entity: demux_1x4
-- Architecture: Structural

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x4 is
    port (
        data_in    : in  STD_LOGIC; -- 1-bit input
        sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector
        data_out_3 : out STD_LOGIC; -- Output for selection "11"
        data_out_2 : out STD_LOGIC; -- Output for selection "10"
        data_out_1 : out STD_LOGIC; -- Output for selection "01"
        data_out_0 : out STD_LOGIC -- Output for selection "00"
    );
end entity demux_1x4;

architecture Structural of demux_1x4 is
    -- Declare the components for inverter and 3-input AND gate
    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    component and_3x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_3x1;

    -- Internal signals
    signal sel_not0 : STD_LOGIC; -- NOT of sel(0)
    signal sel_not1 : STD_LOGIC; -- NOT of sel(1)

    for inv0, inv1: inverter use entity work.inverter(Structural);
    for and_gate_0, and_gate_1, and_gate_2, and_gate_3: and_3x1 use entity work.and_3x1(Structural);

begin
    -- Instantiate the two inverters for sel(0) and sel(1)
    inv0: component inverter
    port map (
        input  => sel(0),
        output => sel_not0
    );

    inv1: component inverter
    port map (
        input  => sel(1),
        output => sel_not1
    );

    -- Instantiate the three 3-input AND gates for outputs
    and_gate_0: component and_3x1
    port map (
        A      => data_in,
        B      => sel_not1,
        C      => sel_not0,
        output => data_out_0
    );

    and_gate_1: component and_3x1
    port map (
        A      => data_in,
        B      => sel_not1,
        C      => sel(0),
        output => data_out_1
    );

    and_gate_2: component and_3x1
    port map (
        A      => data_in,
        B      => sel(1),
        C      => sel_not0,
        output => data_out_2
    );

    and_gate_3: component and_3x1
    port map (
        A      => data_in,
        B      => sel(1),
        C      => sel(0),
        output => data_out_3
    );

end architecture Structural;
