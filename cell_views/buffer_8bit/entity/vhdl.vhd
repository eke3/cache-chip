-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 11:15:41 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity buffer_8bit is
    port (
        input  : in  STD_LOGIC_VECTOR(7 downto 0);
        output : out STD_LOGIC_VECTOR(7 downto 0)
    );
end buffer_8bit;
