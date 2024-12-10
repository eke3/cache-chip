-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


architecture Structural of or_4x1_2bit is

    component or_4x1
        port (
            A      : in  std_logic;
            B      : in  std_logic;
            C      : in  std_logic;
            D      : in  std_logic;
            output : out std_logic
        );
    end component;

    for all: or_4x1 use entity work.or_4x1(Structural);

begin

    u_or0: or_4x1
    port map (
        A(0),
        B(0),
        C(0),
        D(0),
        output(0)
    );

    u_or1: or_4x1
    port map (
        A(1),
        B(1),
        C(1),
        D(1),
        output(1)
    );

end Structural;
