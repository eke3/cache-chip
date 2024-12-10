-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


library IEEE;
use IEEE.std_logic_1164.all;

entity or_4x1_2bit is
    port (
        A      : in  std_logic_vector(1 downto 0);
        B      : in  std_logic_vector(1 downto 0);
        C      : in  std_logic_vector(1 downto 0);
        D      : in  std_logic_vector(1 downto 0);
        output : out std_logic_vector(1 downto 0)
    );
end or_4x1_2bit;
