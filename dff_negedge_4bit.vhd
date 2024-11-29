library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dff_negedge_4bit is
    port (
        d    : in  STD_LOGIC_VECTOR(3 downto 0);
        clk  : in  STD_LOGIC;
        q    : out STD_LOGIC_VECTOR(3 downto 0);
        qbar : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity dff_negedge_4bit;

architecture Structural of dff_negedge_4bit is
    component dff_negedge is
        port (
            d    : in  STD_LOGIC;
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC;
            qbar : out STD_LOGIC
        );
    end component dff_negedge;

begin

    gen_bit: for i in 0 to 3 generate
        bit: entity work.dff_negedge(Structural)
        port map (
            d    => d(i),
            clk  => clk,
            q    => q(i),
            qbar => qbar(i)
        );
    end generate;

end architecture Structural;
