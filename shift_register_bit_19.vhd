-- Entity: shift_register_bit_19
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_bit_19 is
    port (
        input  : in  std_logic;
        clk    : in  std_logic;
        output : out std_logic
    );
end entity shift_register_bit_19;

architecture Structural of shift_register_bit_19 is

    component dff_negedge is
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component dff_negedge;

    for dff_1, dff_2, dff_3, dff_4, dff_5, dff_6, dff_7, dff_8, dff_9, dff_10, dff_11, dff_12, dff_13, dff_14, dff_15, dff_16, dff_17: dff_negedge use entity work.dff_negedge(Structural);

    signal count_1, count_2, count_3, count_4, count_5, count_6, count_7, count_8, count_9, count_10, count_11,
        count_12, count_13, count_14, count_15, count_16, count_17 : std_logic;

begin

    dff_1: component dff_negedge
    port map (
        d    => input,
        clk  => clk,
        q    => count_1,
        qbar => open
    );

    dff_2: component dff_negedge
    port map (
        d    => count_1,
        clk  => clk,
        q    => count_2,
        qbar => open
    );

    dff_3: component dff_negedge
    port map (
        d    => count_2,
        clk  => clk,
        q    => count_3,
        qbar => open
    );

    dff_4: component dff_negedge
    port map (
        d    => count_3,
        clk  => clk,
        q    => count_4,
        qbar => open
    );

    dff_5: component dff_negedge
    port map (
        d    => count_4,
        clk  => clk,
        q    => count_5,
        qbar => open
    );

    dff_6: component dff_negedge
    port map (
        d    => count_5,
        clk  => clk,
        q    => count_6,
        qbar => open
    );

    dff_7: component dff_negedge
    port map (
        d    => count_6,
        clk  => clk,
        q    => count_7,
        qbar => open
    );

    dff_8: component dff_negedge
    port map (
        d    => count_7,
        clk  => clk,
        q    => count_8,
        qbar => open
    );

    dff_9: component dff_negedge
    port map (
        d    => count_8,
        clk  => clk,
        q    => count_9,
        qbar => open
    );

    dff_10: component dff_negedge
    port map (
        d    => count_9,
        clk  => clk,
        q    => count_10,
        qbar => open
    );

    dff_11: component dff_negedge
    port map (
        d    => count_10,
        clk  => clk,
        q    => count_11,
        qbar => open
    );

    dff_12: component dff_negedge
    port map (
        d    => count_11,
        clk  => clk,
        q    => count_12,
        qbar => open
    );

    dff_13: component dff_negedge
    port map (
        d    => count_12,
        clk  => clk,
        q    => count_13,
        qbar => open
    );

    dff_14: component dff_negedge
    port map (
        d    => count_13,
        clk  => clk,
        q    => count_14,
        qbar => open
    );

    dff_15: component dff_negedge
    port map (
        d    => count_14,
        clk  => clk,
        q    => count_15,
        qbar => open
    );

    dff_16: component dff_negedge
    port map (
        d    => count_15,
        clk  => clk,
        q    => count_16,
        qbar => open
    );

    dff_17: component dff_negedge
    port map (
        d    => count_16,
        clk  => clk,
        q    => output,
        qbar => open
    );


end architecture Structural;
