-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 12:12:43 2024


architecture Structural of shift_register_19bit is

    component dff_negedge
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;

    component shift_register_3bit
        port (
            input  : in  std_logic;
            clk    : in  std_logic;
            output : out std_logic
        );
    end component;

    for all: shift_register_3bit use entity work.shift_register_3bit(Structural);
    for all: dff_negedge use entity work.dff_negedge(Structural);

    -- Signal declarations for intermediate stages of the shift register
    signal count_2, count_4, count_6, count_8, count_10, count_12, count_14, count_16, count_17 : std_logic;

begin

    -- Chain of shift register stages (each using shift_register_3bit)
    dff_1_2: shift_register_3bit
    port map (
        input  => input,
        clk    => clk,
        output => count_2
    );

    dff_3_4: shift_register_3bit
    port map (
        input  => count_2,
        clk    => clk,
        output => count_4
    );

    dff_5_6: shift_register_3bit
    port map (
        input  => count_4,
        clk    => clk,
        output => count_6
    );

    dff_7_8: shift_register_3bit
    port map (
        input  => count_6,
        clk    => clk,
        output => count_8
    );

    dff_9_10: shift_register_3bit
    port map (
        input  => count_8,
        clk    => clk,
        output => count_10
    );

    dff_11_12: shift_register_3bit
    port map (
        input  => count_10,
        clk    => clk,
        output => count_12
    );

    dff_13_14: shift_register_3bit
    port map (
        input  => count_12,
        clk    => clk,
        output => count_14
    );

    dff_15_16: shift_register_3bit
    port map (
        input  => count_14,
        clk    => clk,
        output => count_16
    );

    -- Final flip-flop (using dff_negedge for last stage)
    dff_17: dff_negedge
    port map (
        d    => count_16,
        clk  => clk,
        q    => count_17,
        qbar => open
    );

    -- Output assignment
    output <= count_17;

end Structural;
