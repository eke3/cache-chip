-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Mon Dec  2 15:24:48 2024


library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;

entity inverter is
    port (
        input  : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end inverter;
