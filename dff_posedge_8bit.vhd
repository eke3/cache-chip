library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dff_posedge_8bit is
    port (
        d    : in  STD_LOGIC_VECTOR(7 downto 0);
        clk  : in  STD_LOGIC;
        q    : out STD_LOGIC_VECTOR(7 downto 0);
        qbar : out STD_LOGIC_VECTOR(7 downto 0)
    );
end entity dff_posedge_8bit;

architecture Structural of dff_posedge_8bit is
    component dff_posedge is
        port (
            d    : in  STD_LOGIC;
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC;
            qbar : out STD_LOGIC
        );
    end component dff_posedge;

begin

    gen_bit: for i in 0 to 7 generate
        bit: entity work.dff_posedge(Structural)
        port map (
            d    => d(i),
            clk  => clk,
            q    => q(i),
            qbar => qbar(i)
        );
    end generate;

end architecture Structural;
