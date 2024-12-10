-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


architecture Structural of dff_posedge_4bit is

    component dff_posedge
        port (
            d    : in  STD_LOGIC;
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC;
            qbar : out STD_LOGIC
        );
    end component;

    for all: dff_posedge use entity work.dff_posedge(Structural);

begin

    bits0: dff_posedge
    port map (
        d    => d(0),
        clk  => clk,
        q    => q(0),
        qbar => qbar(0)
    );

    bits1: dff_posedge
    port map (
        d    => d(1),
        clk  => clk,
        q    => q(1),
        qbar => qbar(1)
    );

    bits2: dff_posedge
    port map (
        d    => d(2),
        clk  => clk,
        q    => q(2),
        qbar => qbar(2)
    );

    bits3: dff_posedge
    port map (
        d    => d(3),
        clk  => clk,
        q    => q(3),
        qbar => qbar(3)
    );

end Structural;
