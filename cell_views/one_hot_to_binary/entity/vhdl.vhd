-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 10:43:35 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Entity declaration for One-Hot to 2-Bit Converter
entity one_hot_to_binary is
    port (
        one_hot : in  STD_LOGIC_VECTOR(2 downto 0); -- One-hot encoded input
        binary  : out STD_LOGIC_VECTOR(1 downto 0) -- 2-bit binary output
    );
end one_hot_to_binary;
