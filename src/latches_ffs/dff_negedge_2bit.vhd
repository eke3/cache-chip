library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dff_negedge_2bit is
    port (
        d    : in  STD_LOGIC_VECTOR(1 downto 0);
        clk  : in  STD_LOGIC;
        q    : out STD_LOGIC_VECTOR(1 downto 0);
        qbar : out STD_LOGIC_VECTOR(1 downto 0)
    );
end dff_negedge_2bit;

architecture Structural of dff_negedge_2bit is

    component dff_negedge 
        port (
            d    : in  STD_LOGIC;
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC;
            qbar : out STD_LOGIC
        );
    end component;

    for bits: dff_negedge use entity work.dff_negedge(Structural);

begin

    gen_bit: for i in 0 to 1 generate
        bits: dff_negedge
        port map (
            d    => d(i),
            clk  => clk,
            q    => q(i),
            qbar => qbar(i)
        );
    end generate;

end Structural;
