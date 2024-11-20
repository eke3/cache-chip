-- Entity: chip
-- Architecture: structural

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
  vdd	     : in  std_logic;
  gnd        : in  std_logic;
  busy       : out std_logic;
  mem_en     : out std_logic;
  mem_addr   : out std_logic_vector(5 downto 0));
end entity chip;
            
architecture structural of chip is 

    component state_machine
        port(
            -- Inputs
            clk: in std_logic;
            start: in std_logic;
            reset_in: in std_logic;
            hit_miss: in std_logic;
            R_W: in std_logic;
            cpu_addr: in std_logic_vector(5 downto 0);
            --mem_addr_ready: in std_logic;
            -- Outputs
            cache_RW: out std_logic;
            valid_WE: out std_logic;
            tag_WE: out std_logic;
            decoder_enable: out std_logic;
            mem_addr_out_enable: out std_logic;
            mem_data_read_enable: out std_logic;
            data_mux_enable: out std_logic;
            busy: out std_logic; -- also use for decoder enable
            output_enable: out std_logic -- cpu data output enable
        );
    end component state_machine;

    component timed_cache is
        port(
            -- Inputs
            vdd           : in  std_logic; -- power supply
            gnd           : in  std_logic; -- ground
            clk           : in  std_logic; -- system clock
            reset         : in  std_logic; -- system reset
            write_cache   : in  std_logic_vector(7 downto 0); -- from on-chip register, released by state machine
            block_offset  : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            byte_offset   : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            write_valid   : in  std_logic;
            tag     : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            valid_WE : in std_logic; -- from state machine valid_WE signal
            tag_WE   : in std_logic; -- from state machine tag_WE signal
            RW_cache      : in  std_logic; -- from state machine cache_RW signal
            decoder_enable: in  std_logic; -- from state machine BUSY signal
            mem_data      : in  std_logic_vector(7 downto 0); -- from memory
            -- Outputs
            mem_addr      : out std_logic_vector(5 downto 0); -- to on-chip output register, latched+released off chip by state machine
            read_cache    : out std_logic_vector(7 downto 0); -- to on-chip output register, latched+released off chip by state machine's OUTPUT_ENABLE signal
            hit_or_miss      : out std_logic -- status signal going to state machine
        );
    end component timed_cache;
    
    component shift_byte_mem_data
        port(
            enable: in std_logic;
            reset: in std_logic;
            mem_byte: in std_logic_vector(7 downto 0);
            clk: in std_logic;
            byte_offset: out std_logic_vector(1 downto 0);
            byte_00: out std_logic_vector(7 downto 0);
            byte_01: out std_logic_vector(7 downto 0);
            byte_10: out std_logic_vector(7 downto 0);
            byte_11: out std_logic_vector(7 downto 0)
        );
    end component;

    -- components for chip input registers
    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    component nand_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component nand_2x1;

    component or_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_2x1;

    component mux_2x1_8bit is
        port (
            A      : in  STD_LOGIC_VECTOR(7 downto 0);
            B      : in  STD_LOGIC_VECTOR(7 downto 0);
            sel    : in  STD_LOGIC;
            output : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component mux_2x1_8bit;

    component mux_2x1_2bit is
        port (
            A      : in  STD_LOGIC_VECTOR(1 downto 0);
            B      : in  STD_LOGIC_VECTOR(1 downto 0);
            sel    : in  STD_LOGIC;
            output : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component mux_2x1_2bit;
    
    component mux_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            sel    : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component mux_2x1;

    component dff_negedge is 
        port (
            d   : in  std_logic;
            clk : in  std_logic;
            q   : out std_logic;
            qbar: out std_logic
        );
    end component dff_negedge;

    component dff_negedge_2bit is 
        port (
            d   : in  STD_LOGIC_VECTOR(1 downto 0);
            clk : in  STD_LOGIC;
            q   : out STD_LOGIC_VECTOR(1 downto 0);
            qbar: out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component dff_negedge_2bit;

    component dff_negedge_6bit is
        port (
            d   : in  STD_LOGIC_VECTOR(5 downto 0);
            clk : in  STD_LOGIC;
            q   : out STD_LOGIC_VECTOR(5 downto 0);
            qbar: out STD_LOGIC_VECTOR(5 downto 0)
    );
    end component dff_negedge_6bit;

    component dff_negedge_8bit is
        port (
            d   : in  STD_LOGIC_VECTOR(7 downto 0);
            clk : in  STD_LOGIC;
            q   : out STD_LOGIC_VECTOR(7 downto 0);
            qbar: out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component dff_negedge_8bit;
    

    -- intermediate signals
    signal not_clk : std_logic;
    signal write_data_to_valid : std_logic;
    signal busy_sig : std_logic;
    signal tag_block_write_data_latching_clock : std_logic; 
    signal latched_tag : std_logic_vector(1 downto 0);
    signal latched_block_offset : std_logic_vector(1 downto 0);
    signal latched_byte_offset : std_logic_vector(1 downto 0);
    signal latched_cache_write_data : std_logic_vector(7 downto 0);
    signal mem_addr_from_cache : std_logic_vector(5 downto 0);
    signal read_data_from_cache : std_logic_vector(7 downto 0);
    signal memory_output_enable, memory_output_enable_not : std_logic;
    signal read_data_output_enable, read_data_output_enable_not : std_logic;
    signal mem_byte_offset: std_logic_vector(1 downto 0);

    signal hit_miss_sig, valid_WE_sig, tag_WE_sig, mem_read_data_enable_sig, cache_RW_sig, decoder_en_sig: std_logic;

begin
    
    -- port mapping
    clock_inverter : inverter
        port map (
            input => clk,
            output => not_clk -- this might go unused, not sure. depends on whether implementation of timing stuff for read miss needs it
        );

    busy_inverter : inverter
        port map (
            input => busy_sig, -- this comes from state machine busy signal
            output => tag_block_write_data_latching_clock -- this is the clock for latching data to the chip when state machineBUSY goes high
    );
    
    valid_write_data_mux : mux_2x1 
        port map (
            A => vdd,
            B => gnd,
            sel => reset,
            output => write_data_to_valid -- this goes to the write_valid input of the timed_cache
        );

--    cache_write_data_mux : mux_2x1_8bit
--        port map (
--            A => cpu_data,
--            B => mem_data,
--            sel => , -- *** NEED A STATE MACHINE SIGNAL THAT TELLS THE CACHE WHETHER IT IS WRITING DATA FROM THE CPU OR THE MEMORY [0 for cpu, 1 for memory] ***
--            output => write_data_to_cache -- this goes to the write_data input of the timed_cache
--        );
    
    tag_register : dff_negedge_2bit
        port map (
            d => cpu_addr(5 downto 4),
            clk => tag_block_write_data_latching_clock, 
            q => latched_tag, -- this goes to the tag input of the timed_cache
            qbar => open
    );

    block_offset_register : dff_negedge_2bit
        port map (
            d => cpu_addr(3 downto 2),
            clk => tag_block_write_data_latching_clock, 
            q => latched_block_offset, -- this goes to the block_offset input of the timed_cache
            qbar => open
    );

    byte_offset_register : mux_2x1_2bit
        port map (
            A => cpu_addr(1 downto 0),
            B => mem_byte_offset,
            sel => memory_output_enable,   -- DOUBLE CHECK THIS !!!!
            output => latched_byte_offset
    );

    cache_write_data_register : dff_negedge_8bit
        port map (
            d => cpu_data, -- comes from cpu_data input from cpu
            clk => tag_block_write_data_latching_clock, -- this comes from state machine BUSY signal
            q => latched_cache_write_data, -- this goes to the write_cache input of the timed_cache
            qbar => open
    );

    memory_output_enable_inverter : inverter
        port map (
            input => memory_output_enable, -- this comes from the mem_addr_out_enable output of the state machine
            output => memory_output_enable_not -- this goes to the clk pin of the address_to_memory_register below
        );

    read_data_output_enable_inverter : inverter
        port map (
            input => read_data_output_enable, -- this comes from the output_enable output of the state machine
            output => read_data_output_enable_not -- this goes to the clk pin of the read_data_to_cpu_register below
        );
        
    address_to_memory_register : dff_negedge_6bit
        port map (
            d => mem_addr_from_cache, -- this comes from the mem_addr output of the timed_cache
            clk => memory_output_enable_not,
            q => mem_addr, -- this goes to the mem_addr output of the chip
            qbar => open
    );

    read_data_to_cpu_register : dff_negedge_8bit
        port map (
            d => read_data_from_cache, -- this comes from the read_data output of the timed_cache
            clk => read_data_output_enable_not,
            q => cpu_data, -- this goes to the cpu_data output of the chip
            qbar => open
    );
    
    shift_mem_data: shift_byte_mem_data
        port map(
            mem_read_data_enable_sig,
            reset,
            mem_data,
            clk,
            mem_byte_offset
    );

    cache: timed_cache
        port map(
            vdd           => vdd,
            gnd           => gnd,
            clk           => clk,
            reset         => reset,
            write_cache   => latched_cache_write_data,
            block_offset  => latched_block_offset,
            byte_offset   => latched_byte_offset,
            write_valid   => write_data_to_valid,
            tag           => latched_tag,
            valid_WE      => valid_WE_sig,
            tag_WE        => tag_WE_sig,
            RW_cache      => cache_RW_sig,
            decoder_enable=> decoder_en_sig,
            mem_data      => mem_data,
            -- Outputs
            mem_addr      => mem_addr,
            read_cache    => read_data_from_cache,
            hit_or_miss   => hit_miss_sig  

    );

    state_machine_1: state_machine
        port map(
            clk             => clk,
            start           => start,
            hit_miss        => hit_miss_sig,
            R_W             => cpu_rd_wrn,
            reset_in        => reset,
            cpu_addr        => cpu_addr,
            --mem_addr_ready  => 
            -- Outputs
            cache_RW        => cache_RW_sig,
            valid_WE        => valid_WE_sig,
            tag_WE          => tag_WE_sig,
            decoder_enable  => decoder_en_sig,
            mem_addr_out_enable    => memory_output_enable,
            mem_data_read_enable   => mem_read_data_enable_sig,
            data_mux_enable        => open,
            busy            => busy_sig,
            output_enable   => read_data_output_enable
        );
       

end architecture structural;
