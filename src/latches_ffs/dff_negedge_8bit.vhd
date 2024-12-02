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

    gen_dffs: for i in 0 to 3 generate
        dff: dff_negedge_2bit
        port map (
            d    => d(2 * i + 1 downto 2 * i),
            clk  => clk,
            q    => q(2 * i + 1 downto 2 * i),
            qbar => qbar(2 * i + 1 downto 2 * i)
        );
    end generate;

end Structural;
