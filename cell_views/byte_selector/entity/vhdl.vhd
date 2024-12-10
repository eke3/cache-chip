-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:58:21 2024


library IEEE;
use IEEE.std_logic_1164.all;

entity byte_selector is
    port (
        vdd                 : in  std_logic;
        gnd                 : in  std_logic;
        shift_register_data : in  std_logic_vector(7 downto 0);
        byte_offset         : out std_logic_vector(1 downto 0)
    );
end byte_selector;
