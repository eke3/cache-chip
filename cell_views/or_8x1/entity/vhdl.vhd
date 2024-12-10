-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


library IEEE;
library STD;
use IEEE.STD_LOGIC_1164.all;

entity or_8x1 is
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        C      : in  STD_LOGIC;
        D      : in  STD_LOGIC;
        E      : in  STD_LOGIC;
        F      : in  STD_LOGIC;
        G      : in  STD_LOGIC;
        H      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
end or_8x1;
