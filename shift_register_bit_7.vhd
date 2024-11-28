-- Entity: shift_register_bit_7
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_bit_7 is
    port(
        input: in std_logic;
        clk: in std_logic;
        output: out std_logic;
        full_output: out std_logic_vector(7 downto 0)
    );
end entity shift_register_bit_7;

architecture Structural of shift_register_bit_7 is

    component dff_negedge is
        port(
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component dff_negedge;
    
    signal count_1, count_2, count_3, count_4, count_5, count_6, count_7: std_logic;
    
begin

    dff_1: entity work.dff_negedge(Structural) port map(
        input,
        clk,
        count_1
    );

    dff_2: entity work.dff_negedge(Structural) port map(
        count_1,
        clk,
        count_2
    );

    dff_3: entity work.dff_negedge(Structural) port map(
        count_2,
        clk,
        count_3
    );

    dff_4: entity work.dff_negedge(Structural) port map(
        count_3,
        clk,
        count_4
    );

    dff_5: entity work.dff_negedge(Structural) port map(
        count_4,
        clk,
        count_5
    );

    dff_6: entity work.dff_negedge(Structural) port map(
        count_5,
        clk,
        count_6
    );

    dff_7: entity work.dff_negedge(Structural) port map(
        count_6,
        clk,
        count_7
    );
    
    dff_8: entity work.dff_negedge(Structural) port map(
        count_7,
        clk,
        output
    );

    -- used for byte selection
    full_output(0) <= input;
    full_output(1) <= count_1;
    full_output(2) <= count_2;
    full_output(3) <= count_3;
    full_output(4) <= count_4;
    full_output(5) <= count_5;
    full_output(6) <= count_6;
    full_output(7) <= count_7;

end Structural;
