-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;

entity or_3x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        C      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end or_3x1;
