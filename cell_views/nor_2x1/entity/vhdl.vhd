-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:55:04 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity nor_2x1 is
    port (
        A      : in  std_logic; -- First input
        B      : in  std_logic; -- Second input
        output : out std_logic -- NOR output
    );
end nor_2x1;
