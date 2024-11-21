library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dff_negedge_4bit is
    port ( d   : in  STD_LOGIC_VECTOR(3 downto 0);
           clk : in  STD_LOGIC;
           q   : out STD_LOGIC_VECTOR(3 downto 0);
           qbar: out STD_LOGIC_VECTOR(3 downto 0)
         );
end dff_negedge_4bit;

architecture structural of dff_negedge_4bit is
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

    bit2: entity work.dff_negedge(structural)
        port map (
            d   => d(2),
            clk => clk,
            q   => q(2),
            qbar=> qbar(2)
        );

    bit3: entity work.dff_negedge(structural)
        port map (
            d   => d(3),
            clk => clk,
            q   => q(3),
            qbar=> qbar(3)
        );

end architecture structural;

