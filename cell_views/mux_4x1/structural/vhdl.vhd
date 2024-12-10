-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Fri Dec  6 13:52:19 2024


architecture Structural of mux_4x1 is
    -- Component declarations
    component and_3x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component or_4x1
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

    for all: inverter use entity work.inverter(Structural);
    for all: and_3x1 use entity work.and_3x1(Structural);
    for all: or_4x1 use entity work.or_4x1(Structural);

    -- Internal signals
    signal and_out : STD_LOGIC_VECTOR(3 downto 0);
    signal sel_not : STD_LOGIC_VECTOR(1 downto 0);
    signal mux_out : STD_LOGIC;

begin

    -- Instantiate inverters for sel signal
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

    -- Instantiate and_3x1 gates for each read_data input
    and_gate0: and_3x1
    port map (
        A          => read_data0,
        B          => sel_not(1),
        C          => sel_not(0),
        output     => and_out(0)
    );

    and_gate1: and_3x1
    port map (
        A          => read_data1,
        B          => sel_not(1),
        C          => sel(0),
        output     => and_out(1)
    );

    and_gate2: and_3x1
    port map (
        A          => read_data2,
        B          => sel(1),
        C          => sel_not(0),
        output     => and_out(2)
    );

    and_gate3: and_3x1
    port map (
        A          => read_data3,
        B          => sel(1),
        C          => sel(0),
        output     => and_out(3)
    );

    -- Instantiate or_4x1 gate to combine outputs from and gates
    or_gate: or_4x1
    port map (
        A          => and_out(0),
        B          => and_out(1),
        C          => and_out(2),
        D          => and_out(3),
        output     => mux_out
    );

    -- Assign mux output to F
    F <= mux_out;

end Structural;
