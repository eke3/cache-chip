library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dff_negedge_8bit is
    port (
        d    : in  STD_LOGIC_VECTOR(7 downto 0);
        clk  : in  STD_LOGIC;
        q    : out STD_LOGIC_VECTOR(7 downto 0);
        qbar : out STD_LOGIC_VECTOR(7 downto 0)
    );
end dff_negedge_8bit;

architecture Structural of dff_negedge_8bit is

    component dff_negedge_2bit
        port (
            d    : in  STD_LOGIC_VECTOR(1 downto 0);
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC_VECTOR(1 downto 0);
            qbar : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;
    
    for all: dff_negedge_2bit use entity work.dff_negedge_2bit(Structural);

begin

    dff0: dff_negedge_2bit
    port map (
        d    => d(1 downto 0),
        clk  => clk,
        q    => q(1 downto 0),
        qbar => qbar(1 downto 0)
    );

    dff1: dff_negedge_2bit
    port map (
        d    => d(3 downto 2),
        clk  => clk,
        q    => q(3 downto 2),
        qbar => qbar(3 downto 2)
    );

    dff2: dff_negedge_2bit
    port map (
        d    => d(5 downto 4),
        clk  => clk,
        q    => q(5 downto 4),
        qbar => qbar(5 downto 4)
    );

    dff3: dff_negedge_2bit
    port map (
        d    => d(7 downto 6),
        clk  => clk,
        q    => q(7 downto 6),
        qbar => qbar(7 downto 6)
    );

end Structural;
