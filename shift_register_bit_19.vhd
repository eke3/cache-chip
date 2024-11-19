-- Entity: shift_register_bit_19
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_bit_19 is
    port(
        input: in std_logic;
        clk: in std_logic;
        output: out std_logic
    );
end entity shift_register_bit_19;

architecture structural of shift_register_bit_19 is

    component dff
        port(
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;

    for dff_1, dff_2, dff_3, dff_4, dff_5, dff_6, dff_7, dff_8, dff_9, dff_10, dff_11, dff_12, dff_13, dff_14, dff_15, dff_16, dff_17, dff_18, dff_19: dff use entity work.dff(structural);

    signal count_1, count_2, count_3, count_4, count_5, count_6, count_7, count_8, count_9, count_10, count_11, count_12, count_13, count_14, count_15, count_16, count_17, count_18: std_logic;

begin

    dff_1: dff port map(
        input,
        clk,
        count_1
    );

    dff_2: dff port map(
        count_1,
        clk,
        count_2
    );

    dff_3: dff port map(
        count_2,
        clk,
        count_3
    );

    dff_4: dff port map(
        count_3,
        clk,
        count_4
    );

    dff_5: dff port map(
        count_4,
        clk,
        count_5
    );

    dff_6: dff port map(
        count_5,
        clk,
        count_6
    );

    dff_7: dff port map(
        count_6,
        clk,
        count_7
    );

    dff_8: dff port map(
        count_7,
        clk,
        count_8
    );

    dff_9: dff port map(
        count_8,
        clk,
        count_9
    );

    dff_10: dff port map(
        count_9,
        clk,
        count_10
    );

    dff_11: dff port map(
        count_10,
        clk,
        count_11
    );

    dff_12: dff port map(
        count_11,
        clk,
        count_12
    );

    dff_13: dff port map(
        count_12,
        clk,
        count_13
    );

    dff_14: dff port map(
        count_13,
        clk,
        count_14
    );

    dff_15: dff port map(
        count_14,
        clk,
        count_15
    );

    dff_16: dff port map(
        count_15,
        clk,
        count_16
    );

    dff_17: dff port map(
        count_16,
        clk,
        count_17
    );

    dff_18: dff port map(
        count_17,
        clk,
        count_18
    );

    dff_19: dff port map(
        count_18,
        clk,
        output
    );

end structural;