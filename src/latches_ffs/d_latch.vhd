-- Entity: positive level triggered D latch
-- Architecture : Structural
-- Author:
--


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity d_latch is
    port (
        d    : in  std_logic;
        clk  : in  std_logic;
        q    : out std_logic;
        qbar : out std_logic
    );
end d_latch;

architecture Structural of d_latch is

begin

    output: process (d, clk)

    begin
        if clk = '1' then
            q    <= d;
            qbar <= not d;
        end if;
    end process output;

end Structural;
