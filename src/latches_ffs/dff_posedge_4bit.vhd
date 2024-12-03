library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dff_posedge_4bit is
    port (
        d    : in  STD_LOGIC_VECTOR(3 downto 0);
        clk  : in  STD_LOGIC;
        q    : out STD_LOGIC_VECTOR(3 downto 0);
        qbar : out STD_LOGIC_VECTOR(3 downto 0)
    );
end dff_posedge_4bit;

architecture Structural of dff_posedge_4bit is

    component dff_posedge
        port (
            d    : in  STD_LOGIC;
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC;
            qbar : out STD_LOGIC
        );
    end component;

    for all: dff_posedge use entity work.dff_posedge(Structural);

begin

    bits0: dff_posedge
    port map (
        d    => d(0),
        clk  => clk,
        q    => q(0),
        qbar => qbar(0)
    );

    bits1: dff_posedge
    port map (
        d    => d(1),
        clk  => clk,
        q    => q(1),
        qbar => qbar(1)
    );

    bits2: dff_posedge
    port map (
        d    => d(2),
        clk  => clk,
        q    => q(2),
        qbar => qbar(2)
    );

    bits3: dff_posedge
    port map (
        d    => d(3),
        clk  => clk,
        q    => q(3),
        qbar => qbar(3)
    );

end Structural;
