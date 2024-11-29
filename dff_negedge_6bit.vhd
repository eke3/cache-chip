-- Entity: dff_negedge_6bit
-- Architecture: Structural

library IEEE;
use IEEE.std_logic_1164.all;

entity dff_negedge_6bit is
    port (
        d    : in  std_logic_vector(5 downto 0);
        clk  : in  std_logic;
        q    : out std_logic_vector(5 downto 0);
        qbar : out std_logic_vector(5 downto 0)
    );
end entity dff_negedge_6bit;

architecture Structural of dff_negedge_6bit is
    component dff_negedge is
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component dff_negedge;

begin

    gen_bit: for i in 0 to 5 generate
        dff_negedge: entity work.dff_negedge(Structural)
        port map (
            d    => d(i),
            clk  => clk,
            q    => q(i),
            qbar => qbar(i)
        );
    end generate;

end architecture Structural;
