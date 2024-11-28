-- Entity: timed_cache_readmiss_counter
-- Architecture: Structural
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

architecture Structural of timed_cache_readmiss_counter is

    component dff_negedge is
        port(
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component dff_negedge;
    
    component or_8x1 is
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
    end component or_8x1;

    for dff_1, dff_2, dff_3, dff_4, dff_5, dff_6, dff_7, dff_8: dff_negedge use entity work.dff_negedge(Structural);

    signal count_1, count_2, count_3, count_4, count_5, count_6, count_7, count_8: std_logic;

begin

    dff_1: dff_negedge port map(
        d => input,
        clk => clk,
        q => count_1,
        qbar => open
    );

    dff_2: dff_negedge port map(
        d => count_1,
        clk => clk,
        q => count_2,
        qbar => open
    );

    dff_3: dff_negedge port map(
        d => count_2,
        clk => clk,
        q => count_3,
        qbar => open
    );

    dff_4: dff_negedge port map(
        d => count_3,
        clk => clk,
        q => count_4,
        qbar => open
    );

    dff_5: dff_negedge port map(
        d => count_4,
        clk => clk,
        q => count_5,
        qbar => open
    );

    dff_6: dff_negedge port map(
        d => count_5,
        clk => clk,
        q => count_6,
        qbar => open
    );

    dff_7: dff_negedge port map(
        d => count_6,
        clk => clk,
        q => count_7,
        qbar => open
    );

    dff_8: dff_negedge port map(
        d => count_7,
        clk => clk,
        q => count_8,
        qbar => open
    );

    or8: entity work.or_8x1(Structural) port map(
        A => count_1,
        B => count_2,
        C => count_3,
        D => count_4,
        E => count_5,
        F => count_6,
        G => count_7,
        H => count_8,
        output => output
    );

end Structural;