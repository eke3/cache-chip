-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Sat Dec  7 15:44:19 2024


library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity state_machine is
    port (
        gnd                  : in  std_logic;
        clk                  : in  std_logic;
        start                : in  std_logic;
        reset_in             : in  std_logic;
        hit_miss             : in  std_logic;
        R_W                  : in  std_logic;
        cache_RW             : out std_logic;
        tag_valid_WE               : out std_logic;
        decoder_enable       : out std_logic;
        mem_addr_out_enable  : out std_logic;
        mem_data_read_enable : out std_logic;
        busy                 : out std_logic;
        output_enable        : out std_logic; -- cpu data output enable
        shift_reg_out        : out std_logic_vector(7 downto 0)
    );
end state_machine;
