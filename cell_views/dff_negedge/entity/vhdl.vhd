-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Mon Dec  2 15:24:48 2024


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity dff_negedge is
    port (
        d    : in  std_logic;
        clk  : in  std_logic;
        q    : out std_logic;
        qbar : out std_logic
    );
end dff_negedge;
