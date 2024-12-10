-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:58:21 2024


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity selector is
    port (
        chip_enable  : in  std_logic;
        RW           : in  std_logic;
        read_enable  : out std_logic;
        write_enable : out std_logic
    );
end selector;
