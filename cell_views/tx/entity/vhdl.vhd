-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:58:21 2024


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
end tx;
