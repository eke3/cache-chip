-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:59:32 2024


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell_2bit is
    port (
        write_data  : in  std_logic_vector(1 downto 0);
        chip_enable : in  std_logic;
        RW          : in  std_logic;
        read_data   : out std_logic_vector(1 downto 0)
    );
end cache_cell_2bit;
