-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


architecture Structural of mux_2x1_2bit is
    -- Declare the mux_2x1 component
    component mux_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            sel    : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for all: mux_2x1 use entity work.mux_2x1(Structural);

    signal mux_out : STD_LOGIC_VECTOR(1 downto 0);

begin

    -- Instantiate the mux_2x1 for each bit
    mux_2x1_inst0: mux_2x1
    port map (
        A      => A(0),
        B      => B(0),
        sel    => sel,
        output => mux_out(0)
    );

    mux_2x1_inst1: mux_2x1
    port map (
        A      => A(1),
        B      => B(1),
        sel    => sel,
        output => mux_out(1)
    );

    output <= mux_out;

end Structural;
