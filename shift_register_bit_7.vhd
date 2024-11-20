-- Entity: shift_register_bit_7
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_bit_7 is
    port(
        input: in std_logic;
        clk: in std_logic;
        output: out std_logic
    );
end entity shift_register_bit_7;

architecture structural of shift_register_bit_7 is

    component dff
        port(
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;
    
    signal count_1, count_2, count_3, count_4, count_5, count_6: std_logic;
    
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
        output
    );

end structural;