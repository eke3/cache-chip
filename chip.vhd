-- Entity: chip
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity chip is 
port (
  cpu_addr   : in  std_logic_vector(5 downto 0);
  cpu_data   : inout  std_logic_vector(7 downto 0);
  cpu_rd_wrn : in  std_logic;    
  start      : in  std_logic;
  clk        : in  std_logic;
  reset      : in  std_logic;
  mem_data   : in  std_logic_vector(7 downto 0);
  Vdd	     : in  std_logic;
  Gnd        : in  std_logic;
  busy       : out std_logic;
  mem_en     : out std_logic;
  mem_addr   : out std_logic_vector(5 downto 0));
end chip;
            
architecture structural of chip is 

    component state_machine
        port(
            clk: in std_logic;
            start: in std_logic;
            hit_miss: in std_logic;
            R_W: in std_logic;
            cpu_addr: in std_logic_vector(7 downto 0);
            mem_addr_ready: in std_logic;
    
            cache_RW: out std_logic;
            valid_WE: out std_logic;
            tag_WE: out std_logic;
            decoder_enable: out std_logic;
            mem_addr_out_enable: out std_logic;
            data_mux_enable: out std_logic;
            busy: out std_logic; -- also use for decoder enable
            output_enable: out std_logic -- cpu data output enable
        );
    end component;

begin

end structural;
