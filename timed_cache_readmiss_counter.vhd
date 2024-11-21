-- Entity: timed_cache_readmiss_counter
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity timed_cache_readmiss_counter is
    port(
        input: in std_logic;
        clk: in std_logic;
        output: out std_logic
    );
end entity timed_cache_readmiss_counter;

architecture structural of timed_cache_readmiss_counter is

    component dff
        port(
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;
    
    component or_8x1
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        C      : in  STD_LOGIC;
        D      : in  STD_LOGIC;
        E      : in  STD_LOGIC;
        F      : in  STD_LOGIC;
        G      : in  STD_LOGIC;
        H      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
    end component;

    for dff_1, dff_2, dff_3, dff_4, dff_5, dff_6, dff_7, dff_8: dff use entity work.dff(structural);

    signal count_1, count_2, count_3, count_4, count_5, count_6, count_7, count_8: std_logic;


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

    or8: or_8x1 port map(
        count_1,
        count_2,
        count_3,
        count_4,
        count_5,
        count_6,
        count_7,
        count_8,
        output
    );

end structural;