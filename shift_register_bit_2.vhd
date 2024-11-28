-- Entity: shift_register_bit_2
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_bit_2 is
    port (
        input  : in  std_logic;
        clk    : in  std_logic;
        output : out std_logic
    );
end entity shift_register_bit_2;

architecture Structural of shift_register_bit_2 is

    component dff_negedge is
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component dff_negedge;

begin

    dff_1: entity work.dff_negedge(Structural)
    port map (
        input,
        clk,
        output
    );

end architecture Structural;
