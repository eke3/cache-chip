-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 12:10:32 2024


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_3bit is
    port (
        input  : in  std_logic;
        clk    : in  std_logic;
        output : out std_logic
    );
end shift_register_3bit;
