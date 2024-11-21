library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_negedge_2bit is
    port ( d   : in  STD_LOGIC_VECTOR(1 downto 0);
           clk : in  STD_LOGIC;
           q   : out STD_LOGIC_VECTOR(1 downto 0);
           qbar: out STD_LOGIC_VECTOR(1 downto 0)
         );
end dff_negedge_2bit;

architecture structural of dff_negedge_2bit is
    component dff_negedge is
        port ( d   : in  STD_LOGIC;
               clk : in  STD_LOGIC;
               q   : out STD_LOGIC;
               qbar: out STD_LOGIC
             );
    end component dff_negedge;

begin
    bit0: entity work.dff_negedge(structural)
        port map (
            d   => d(0),
            clk => clk,
            q   => q(0),
            qbar=> qbar(0)
        );

    bit1: entity work.dff_negedge(structural)
        port map (
            d   => d(1),
            clk => clk,
            q   => q(1),
            qbar=> qbar(1)
        );

end structural;

