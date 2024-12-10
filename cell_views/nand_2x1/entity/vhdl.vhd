-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Mon Dec  2 15:24:48 2024


library IEEE;
use IEEE.std_logic_1164.all;

entity nand_2x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end nand_2x1;
