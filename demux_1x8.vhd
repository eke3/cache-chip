-- Entity: demux_1x8
-- Architecture: structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x8 is
    port (
        data_in    : in  STD_LOGIC; -- 1-bit input data
        sel        : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit selector
        data_out_0 : out STD_LOGIC; -- Output for selection "000"
        data_out_1 : out STD_LOGIC; -- Output for selection "001"
        data_out_2 : out STD_LOGIC; -- Output for selection "010"
        data_out_3 : out STD_LOGIC; -- Output for selection "011"
        data_out_4 : out STD_LOGIC; -- Output for selection "100"
        data_out_5 : out STD_LOGIC; -- Output for selection "101"
        data_out_6 : out STD_LOGIC; -- Output for selection "110"
        data_out_7 : out STD_LOGIC -- Output for selection "111"
    );
end entity demux_1x8;

architecture Structural of demux_1x8 is
    -- Component declarations
    component and_4x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            D      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_4x1;

    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    -- Intermediate signals for the inverted select bits
    signal sel_not0, sel_not1, sel_not2 : STD_LOGIC;

    for inv0, inv1, inv2: inverter use entity work.inverter(structural);
    for and0, and1, and2, and3, and4, and5, and6, and7: and_4x1 use entity work.and_4x1(structural);

begin
    -- Instantiate inverters for each bit of the selector `sel`
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

    inv2: component inverter
    port map (
        input  => sel(2),
        output => sel_not2
    );

    -- Instantiate 8 instances of and_4x1 to control each output
    and0: component and_4x1
    port map (
        A      => data_in,
        B      => sel_not2,
        C      => sel_not1,
        D      => sel_not0,
        output => data_out_0
    );

    and1: component and_4x1
    port map (
        A      => data_in,
        B      => sel_not2,
        C      => sel_not1,
        D      => sel(0),
        output => data_out_1
    );

    and2: component and_4x1
    port map (
        A      => data_in,
        B      => sel_not2,
        C      => sel(1),
        D      => sel_not0,
        output => data_out_2
    );

    and3: component and_4x1
    port map (
        A      => data_in,
        B      => sel_not2,
        C      => sel(1),
        D      => sel(0),
        output => data_out_3
    );

    and4: component and_4x1
    port map (
        A      => data_in,
        B      => sel(2),
        C      => sel_not1,
        D      => sel_not0,
        output => data_out_4
    );

    and5: component and_4x1
    port map (
        A      => data_in,
        B      => sel(2),
        C      => sel_not1,
        D      => sel(0),
        output => data_out_5
    );

    and6: component and_4x1
    port map (
        A      => data_in,
        B      => sel(2),
        C      => sel(1),
        D      => sel_not0,
        output => data_out_6
    );

    and7: component and_4x1
    port map (
        A      => data_in,
        B      => sel(2),
        C      => sel(1),
        D      => sel(0),
        output => data_out_7
    );

end architecture Structural;
