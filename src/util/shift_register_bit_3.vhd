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

    signal count_1 : std_logic;

begin

    dff_1: entity work.dff_negedge(Structural)
    port map (
        d    => input,
        clk  => clk,
        q    => count_1,
        qbar => open
    );

    dff_2: entity work.dff_negedge(Structural)
    port map (
        d    => count_1,
        clk  => clk,
        q    => output,
        qbar => open
    );

end architecture Structural;
