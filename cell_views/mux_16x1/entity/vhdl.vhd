-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 10:43:35 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1 is
    port (
        inputs      : in  STD_LOGIC_VECTOR(15 downto 0); -- 16-bit input vector
        sel_one_hot : in  STD_LOGIC_VECTOR(15 downto 0); -- 1-hot encoded select signal
        output      : out STD_LOGIC -- Output of the multiplexer
    );
end mux_16x1;
