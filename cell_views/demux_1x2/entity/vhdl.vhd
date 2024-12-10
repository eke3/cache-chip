-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 12:15:47 2024


library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x2 is
    port (
        data_in    : in  STD_LOGIC; -- 1-bit input data
        sel        : in  STD_LOGIC; -- 1-bit selector
        data_out_1 : out STD_LOGIC; -- Output for selection "0"
        data_out_2 : out STD_LOGIC -- Output for selection "1"
    );
end demux_1x2;
