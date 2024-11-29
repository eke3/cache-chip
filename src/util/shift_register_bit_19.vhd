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

    component shift_register_bit_3 is
        port (
            input  : in  std_logic;
            clk    : in  std_logic;
            output : out std_logic
        );
    end component shift_register_bit_3;

    signal count_2, count_4, count_6, count_8, count_10, count_12, count_14, count_16, count_17 : std_logic;

begin

    dff_1_2: entity work.shift_register_bit_3(Structural)
    port map (
        input  => input,
        clk    => clk,
        output => count_2
    );

    dff_3_4: entity work.shift_register_bit_3(Structural)
    port map (
        input  => count_2,
        clk    => clk,
        output => count_4
    );

    dff_5_6: entity work.shift_register_bit_3(Structural)
    port map (
        input  => count_4,
        clk    => clk,
        output => count_6
    );

    dff_7_8: entity work.shift_register_bit_3(Structural)
    port map (
        input  => count_6,
        clk    => clk,
        output => count_8
    );

    dff_9_10: entity work.shift_register_bit_3(Structural)
    port map (
        input  => count_8,
        clk    => clk,
        output => count_10
    );

    dff_11_12: entity work.shift_register_bit_3(Structural)
    port map (
        input  => count_10,
        clk    => clk,
        output => count_12
    );

    dff_13_14: entity work.shift_register_bit_3(Structural)
    port map (
        input  => count_12,
        clk    => clk,
        output => count_14
    );

    dff_15_16: entity work.shift_register_bit_3(Structural)
    port map (
        input  => count_14,
        clk    => clk,
        output => count_16
    );

    dff_17: entity work.dff_negedge(Structural)
    port map (
        d      => count_16,
        clk    => clk,
        q      => count_17,
        qbar   => open
    );

    output <= count_17;

end architecture Structural;
