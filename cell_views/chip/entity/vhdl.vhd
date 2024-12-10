-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 14:26:53 2024


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity chip is
    port (
        cpu_add    : in    std_logic_vector(5 downto 0);
        cpu_data   : inout std_logic_vector(7 downto 0);
        cpu_rd_wrn : in    std_logic;
        start      : in    std_logic;
        clk        : in    std_logic;
        reset      : in    std_logic;
        mem_data   : in    std_logic_vector(7 downto 0);
        vdd        : in    std_logic;
        gnd        : in    std_logic;
        busy       : out   std_logic;
        mem_en     : out   std_logic;
        mem_add    : out   std_logic_vector(5 downto 0)
    );
end chip;
