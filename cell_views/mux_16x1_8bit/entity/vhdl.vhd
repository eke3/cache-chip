-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 10:52:48 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1_8bit is
    port (
        inputs   : in  STD_LOGIC_VECTOR(127 downto 0); -- 16 inputs, each 8-bit wide
        sel      : in  STD_LOGIC_VECTOR(15 downto 0); -- 16-bit 1-hot select signal
        output   : out STD_LOGIC_VECTOR(7 downto 0) -- 8-bit output
    );
end mux_16x1_8bit;
