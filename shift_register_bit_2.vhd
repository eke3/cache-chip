-- Entity: shift_register_bit_2
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_bit_2 is
    port(
        input: in std_logic;
        clk: in std_logic;
        output: out std_logic
    );
end entity shift_register_bit_2;

architecture structural of shift_register_bit_2 is

    component dff
        port(
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;

    for dff_1, dff_2: dff use entity work.dff(structural);

    signal count_1: std_logic;

begin

    dff_1: dff port map(
        input,
        clk,
        count_1
    );

    dff_2: dff port map(
        count_1,
        clk,
        output
    );
    
end structural;