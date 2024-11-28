-- Entity: shift_register_bit_3
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_bit_3 is
    port (
        input  : in  std_logic;
        clk    : in  std_logic;
        output : out std_logic
    );
end entity shift_register_bit_3;

architecture Structural of shift_register_bit_3 is

    component dff_negedge is
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component dff_negedge;

    for dff_1, dff_2: dff_negedge use entity work.dff_negedge(Structural);

    signal count_1 : std_logic;

begin

    dff_1: component dff_negedge
    port map (
        input,
        clk,
        count_1
    );

    dff_2: component dff_negedge
    port map (
        count_1,
        clk,
        output
    );

end architecture Structural;
