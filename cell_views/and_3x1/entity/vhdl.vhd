-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity and_3x1 is
    port (
        A      : in  STD_LOGIC; -- First input
        B      : in  STD_LOGIC; -- Second input
        C      : in  STD_LOGIC; -- Third input
        output : out STD_LOGIC -- Output of the 3-input AND gate
    );
end and_3x1;
