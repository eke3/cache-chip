-- Entity: demux_1x8
-- Architecture: Structural
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
end demux_1x8;

architecture Structural of demux_1x8 is
    -- Declare the components for inverter and and_4x1
    component and_4x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            D      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component inverter
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    -- Internal signal for the inverted selector bits
    signal sel_not : STD_LOGIC_VECTOR(2 downto 0);

    -- Component binding
    for all : and_4x1 use entity work.and_4x1(Structural);
    for all : inverter use entity work.inverter(Structural);

begin
    -- Instantiate inverters for each bit of the selector `sel`
    inv0: inverter
    port map (
        input  => sel(0),
        output => sel_not(0)
    );

    inv1: inverter
    port map (
        input  => sel(1),
        output => sel_not(1)
    );

    inv2: inverter
    port map (
        input  => sel(2),
        output => sel_not(2)
    );

    -- Instantiate 8 instances of and_4x1 for controlling each output
    and0: and_4x1
    port map (
        A          => data_in,
        B          => sel_not(2),
        C          => sel_not(1),
        D          => sel_not(0),
        output     => data_out_0
    );

    and1: and_4x1
    port map (
        A          => data_in,
        B          => sel_not(2),
        C          => sel_not(1),
        D          => sel(0),
        output     => data_out_1
    );

    and2: and_4x1
    port map (
        A          => data_in,
        B          => sel_not(2),
        C          => sel(1),
        D          => sel_not(0),
        output     => data_out_2
    );

    and3: and_4x1
    port map (
        A          => data_in,
        B          => sel_not(2),
        C          => sel(1),
        D          => sel(0),
        output     => data_out_3
    );

    and4: and_4x1
    port map (
        A          => data_in,
        B          => sel(2),
        C          => sel_not(1),
        D          => sel_not(0),
        output     => data_out_4
    );

    and5: and_4x1
    port map (
        A          => data_in,
        B          => sel(2),
        C          => sel_not(1),
        D          => sel(0),
        output     => data_out_5
    );

    and6: and_4x1
    port map (
        A          => data_in,
        B          => sel(2),
        C          => sel(1),
        D          => sel_not(0),
        output     => data_out_6
    );

    and7: and_4x1
    port map (
        A          => data_in,
        B          => sel(2),
        C          => sel(1),
        D          => sel(0),
        output     => data_out_7
    );

end Structural;

