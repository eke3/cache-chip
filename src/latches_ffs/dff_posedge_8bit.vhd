library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dff_posedge_8bit is
    port (
        d    : in  STD_LOGIC_VECTOR(7 downto 0);
        clk  : in  STD_LOGIC;
        q    : out STD_LOGIC_VECTOR(7 downto 0);
        qbar : out STD_LOGIC_VECTOR(7 downto 0)
    );
end dff_posedge_8bit;

architecture Structural of dff_posedge_8bit is

    component dff_posedge_4bit 
        port (
            d    : in  STD_LOGIC_VECTOR(3 downto 0);
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC_VECTOR(3 downto 0);
            qbar : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    for all: dff_posedge_4bit use entity work.dff_posedge_4bit(Structural);

begin

    dff0: dff_posedge_4bit
    port map (
        d    => d(3 downto 0),
        clk  => clk,
        q    => q(3 downto 0),
        qbar => qbar(3 downto 0)
    );

    dff1: dff_posedge_4bit
    port map (
        d    => d(7 downto 4),
        clk  => clk,
        q    => q(7 downto 4),
        qbar => qbar(7 downto 4)
    );

end Structural;
