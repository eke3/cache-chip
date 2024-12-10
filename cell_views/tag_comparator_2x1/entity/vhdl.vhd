-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:58:21 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tag_comparator_2x1 is
    port (
        A      : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit input A
        B      : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit input B
        output : out STD_LOGIC -- 1 if A = B, 0 otherwise
    );
end tag_comparator_2x1;
