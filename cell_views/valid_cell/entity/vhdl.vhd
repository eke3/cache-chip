-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:59:32 2024


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity valid_cell is
    port (
        vdd         : in  std_logic;
        gnd         : in  std_logic;
        write_data  : in  std_logic; -- Write data input
        reset       : in  std_logic; -- Reset signal
        chip_enable : in  std_logic; -- Chip enable signal
        RW          : in  std_logic; -- Read/Write signal
        read_data   : out std_logic -- Read data output
    );
end valid_cell;
