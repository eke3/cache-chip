-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 12:10:32 2024


architecture Structural of shift_register_3bit is

    component dff_negedge
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;

    for all: dff_negedge use entity work.dff_negedge(Structural);

    signal count_1 : std_logic;

begin

    dff_1: dff_negedge
    port map (
        d    => input,
        clk  => clk,
        q    => count_1,
        qbar => open
    );

    dff_2: dff_negedge
    port map (
        d    => count_1,
        clk  => clk,
        q    => output,
        qbar => open
    );

end Structural;
