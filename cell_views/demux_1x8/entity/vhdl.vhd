-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Fri Dec  6 13:39:18 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x8 is
    port (
        data_in    : in  STD_LOGIC; -- 1-bit input data
        sel        : in  STD_LOGIC_VECTOR(2 downto 0); -- 3-bit selector
        data_out_0 : out STD_LOGIC; -- Output for selection "000"
        data_out_1 : out STD_LOGIC; -- Output for selection "001"
        data_out_2 : out STD_LOGIC; -- Output for selection "010"
        data_out_3 : out STD_LOGIC; -- Output for selection "011"
        data_out_4 : out STD_LOGIC; -- Output for selection "100"
        data_out_5 : out STD_LOGIC; -- Output for selection "101"
        data_out_6 : out STD_LOGIC; -- Output for selection "110"
        data_out_7 : out STD_LOGIC -- Output for selection "111"
    );
end demux_1x8;
