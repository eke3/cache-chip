-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Entity declaration for XOR gate
entity xor_2x1 is
    port (
        A      : in  STD_LOGIC; -- Input 0
        B      : in  STD_LOGIC; -- Input 1
        output : out STD_LOGIC -- Output of the XOR gate
    );
end xor_2x1;
