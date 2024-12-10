-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Fri Dec  6 13:39:18 2024


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
