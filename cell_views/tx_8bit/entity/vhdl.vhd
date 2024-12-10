-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:58:21 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tx_8bit is
    port (
        sel    : in  std_logic; -- Selector signal
        selnot : in  std_logic; -- Inverted selector signal
        input  : in  std_logic_vector(7 downto 0); -- 8-bit input data
        output : out std_logic_vector(7 downto 0) -- 8-bit output data
    );
end tx_8bit;
