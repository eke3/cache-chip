-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Fri Dec  6 13:37:41 2024


library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x4 is
    port (
        data_in    : in  STD_LOGIC; -- 1-bit input
        sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector
        data_out_3 : out STD_LOGIC; -- Output for selection "11"
        data_out_2 : out STD_LOGIC; -- Output for selection "10"
        data_out_1 : out STD_LOGIC; -- Output for selection "01"
        data_out_0 : out STD_LOGIC -- Output for selection "00"
    );
end demux_1x4;
