-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


architecture Structural of dff_negedge_2bit is

    component dff_negedge 
        port (
            d    : in  STD_LOGIC;
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC;
            qbar : out STD_LOGIC
        );
    end component;

    for all: dff_negedge use entity work.dff_negedge(Structural);

begin

    bits0: dff_negedge
    port map (
        d    => d(0),
        clk  => clk,
        q    => q(0),
        qbar => qbar(0)
    );

    bits1: dff_negedge
    port map (
        d    => d(1),
        clk  => clk,
        q    => q(1),
        qbar => qbar(1)
    );

end Structural;
