-- Entity: tx -- transmission gate
-- Architecture : Structural
-- Author:
--

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity tx is
    port (
        sel    : in  std_logic;
        selnot : in  std_logic;
        input  : in  std_logic;
        output : out std_logic
    );
end entity tx;

architecture Structural of tx is

begin

    txprocess: process (sel, selnot, input) is
    begin
        if (sel = '1' and selnot = '0') then
            output <= input;
        else
            output <= 'Z';
        end if;
    end process txprocess;

end architecture Structural;
