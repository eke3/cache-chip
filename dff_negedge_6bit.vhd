-- Entity: dff_negedge_6bit
-- Architecture: Structural

library IEEE;
use IEEE.std_logic_1164.all;

entity dff_negedge_6bit is
    port (
        d     : in  std_logic_vector(5 downto 0);
        clk   : in  std_logic;
        q     : out std_logic_vector(5 downto 0);
        qbar  : out std_logic_vector(5 downto 0)
    );
end dff_negedge_6bit;

architecture Structural of dff_negedge_6bit is
    component dff_negedge is
        port ( d   : in  std_logic;
               clk : in  std_logic;
               q   : out std_logic;
               qbar: out std_logic);
    end component dff_negedge;
begin
    dff_negedge_0: entity work.dff_negedge(Structural)
        port map (
            d => d(0),
            clk => clk,
            q => q(0),
            qbar => qbar(0)
        );
    dff_negedge_1: entity work.dff_negedge(Structural)
        port map (
            d => d(1),
            clk => clk,
            q => q(1),
            qbar => qbar(1)
        );
    dff_negedge_2: entity work.dff_negedge(Structural)
        port map (
            d => d(2),
            clk => clk,
            q => q(2),
            qbar => qbar(2)
        );
    dff_negedge_3: entity work.dff_negedge(Structural)
        port map (
            d => d(3),
            clk => clk,
            q => q(3),
            qbar => qbar(3)
        );
    dff_negedge_4: entity work.dff_negedge(Structural)
        port map (
            d => d(4),
            clk => clk,
            q => q(4),
            qbar => qbar(4)
        );
    dff_negedge_5: entity work.dff_negedge(Structural)
        port map (
            d => d(5),
            clk => clk,
            q => q(5),
            qbar => qbar(5)
        );
end Structural;
