-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


architecture Structural of or_3x1 is

    component or_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for or_1, or_2: or_2x1 use entity work.or_2x1(Structural);

    signal or_2x1_out, or_3x1_out : STD_LOGIC; -- Intermediate signal for OR operation

begin

    or_1: or_2x1
    port map (
        A      => A,
        B      => B,
        output => or_2x1_out
    );

    or_2: or_2x1
    port map (
        A      => or_2x1_out,
        B      => C,
        output => or_3x1_out
    );

    output <= or_3x1_out;

end Structural;
