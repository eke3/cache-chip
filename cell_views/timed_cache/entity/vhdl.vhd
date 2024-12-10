-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 14:27:02 2024


library IEEE;
use IEEE.std_logic_1164.all;

entity timed_cache is
    port (
        vdd                    : in  std_logic; -- power supply
        gnd                    : in  std_logic; -- ground
        clk                    : in  std_logic; -- system clock
        reset                  : in  std_logic; -- system reset
        write_cache            : in  std_logic_vector(7 downto 0); -- from on-chip register, released by state machine
        block_offset           : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
        byte_offset            : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
        tag                    : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
        valid_WE               : in  std_logic; -- from state machine
        tag_WE                 : in  std_logic; -- from state machine
        output_enable          : in  std_logic; -- from state machine
        RW_cache               : in  std_logic; -- from state machine
        decoder_enable         : in  std_logic; -- from state machine
        busy                   : in  std_logic; -- from state machine
        mem_addr_output_enable : in  std_logic; -- from state machine
        mem_addr               : out std_logic_vector(5 downto 0); -- to memory
        read_cache             : out std_logic_vector(7 downto 0); -- to on-chip register, which will be released off chip by state machine's OUTPUT_ENABLE signal
        hit_or_miss            : out std_logic -- status signal going to state machine
    );
end timed_cache;
