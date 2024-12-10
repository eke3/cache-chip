-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:59:32 2024


library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity valid_vector is
    port (
        vdd         : in  STD_LOGIC; -- Power supply
        gnd         : in  STD_LOGIC; -- Ground
        write_data  : in  STD_LOGIC; -- Shared write data for demux
        reset       : in  STD_LOGIC; -- Shared reset signal for all cells
        chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
        RW          : in  STD_LOGIC; -- Shared Read/Write signal for all cells
        sel         : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector for demux, comes from decoder input
        read_data   : out STD_LOGIC -- Read data output for cell 3
    );
end valid_vector;
