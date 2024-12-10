-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 12:12:43 2024


library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_7bit is
    port (
        input       : in  std_logic;
        clk         : in  std_logic;
        output      : out std_logic;
        full_output : out std_logic_vector(7 downto 0)
    );
end shift_register_7bit;
