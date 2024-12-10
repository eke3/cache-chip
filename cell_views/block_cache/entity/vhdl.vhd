-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 13:53:15 2024


library IEEE;
use IEEE.std_logic_1164.all;

entity block_cache is
    port (
        write_cache  : in  std_logic_vector(7 downto 0);
        hit_miss     : in  std_logic;
        R_W          : in  std_logic;
        byte_offset  : in  std_logic_vector(3 downto 0);
        block_offset : in  std_logic_vector(3 downto 0);
        read_data    : out std_logic_vector(7 downto 0)
    );
end block_cache;
