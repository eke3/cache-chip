-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:59:32 2024


library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tag_vector is
    port (
        write_data  : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit shared write data
        chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
        RW          : in  STD_LOGIC; -- Shared Read/Write signal for all cells
        sel         : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector for demux
        read_data   : out STD_LOGIC_VECTOR(1 downto 0) -- Read data output for cell 3
    );
end tag_vector;
