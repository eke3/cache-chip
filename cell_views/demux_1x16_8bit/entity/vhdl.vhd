-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux_1x16_8bit is
    port (
        data_in     : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input data
        sel         : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit selector (S3, S2, S1, S0)
        data_out_0  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0000"
        data_out_1  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0001"
        data_out_2  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0010"
        data_out_3  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0011"
        data_out_4  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0100"
        data_out_5  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0101"
        data_out_6  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0110"
        data_out_7  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0111"
        data_out_8  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1000"
        data_out_9  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1001"
        data_out_10 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1010"
        data_out_11 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1011"
        data_out_12 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1100"
        data_out_13 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1101"
        data_out_14 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1110"
        data_out_15 : out STD_LOGIC_VECTOR(7 downto 0)  -- Output for selection "1111"
    );
end demux_1x16_8bit;
