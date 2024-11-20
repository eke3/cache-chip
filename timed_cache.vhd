-- Entity: timed_cache
-- Architecture: Structural

library IEEE;
use IEEE.std_logic_1164.all;


entity timed_cache is
    port (
        vdd           : in  std_logic; -- power supply
        gnd           : in  std_logic; -- ground
        clk           : in  std_logic; -- system clock
        reset         : in  std_logic; -- system reset
        write_cache   : in  std_logic_vector(7 downto 0); -- from on-chip register, released by state machine
        block_offset  : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
        byte_offset   : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
        write_valid   : in  std_logic; --from on-chip register, released by state machine
        tag     : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
--        RW_valid      : in  std_logic; -- from state machine
--        RW_tag        : in  std_logic; -- from state machine
        valid_WE : in std_logic; -- from state machine
        tag_WE   : in std_logic; -- from state machine
        RW_cache      : in  std_logic; -- from state machine
        decoder_enable: in  std_logic; -- from state machine
        mem_data      : in  std_logic_vector(7 downto 0); -- from memory
        mem_addr      : out std_logic_vector(5 downto 0); -- to memory
        read_cache    : out std_logic_vector(7 downto 0); -- to on-chip register, which will be released off chip by state machine's OUTPUT_ENABLE signal
        hit_or_miss      : out std_logic
    );
end entity timed_cache;

architecture Structural of timed_cache is
        -- Component declarations for the Unit Under Test (UUT)
        component dff_posedge is
            port ( d   : in  std_logic;
                   clk : in  std_logic;
                   q   : out std_logic;
                   qbar: out std_logic);
        end component dff_posedge;
    
        component dff_negedge is
            port ( d   : in  std_logic;
                   clk : in  std_logic;
                   q   : out std_logic;
                   qbar: out std_logic);
        end component dff_negedge;
    
        component dff_posedge_2bit is
            port ( d   : in  STD_LOGIC_VECTOR(1 downto 0);
                   clk : in  STD_LOGIC;
                   q   : out STD_LOGIC_VECTOR(1 downto 0);
                   qbar: out STD_LOGIC_VECTOR(1 downto 0)
                 );
        end component dff_posedge_2bit;
    
        component dff_negedge_2bit is
            port ( d   : in  STD_LOGIC_VECTOR(1 downto 0);
                   clk : in  STD_LOGIC;
                   q   : out STD_LOGIC_VECTOR(1 downto 0);
                   qbar: out STD_LOGIC_VECTOR(1 downto 0)
                 );
        end component dff_negedge_2bit;
    
        component dff_posedge_4bit is
            port ( d   : in  STD_LOGIC_VECTOR(3 downto 0);
                   clk : in  STD_LOGIC;
                   q   : out STD_LOGIC_VECTOR(3 downto 0);
                   qbar: out STD_LOGIC_VECTOR(3 downto 0)
                 );
        end component dff_posedge_4bit;
    
        component dff_negedge_4bit is
            port ( d   : in  STD_LOGIC_VECTOR(3 downto 0);
                   clk : in  STD_LOGIC;
                   q   : out STD_LOGIC_VECTOR(3 downto 0);
                   qbar: out STD_LOGIC_VECTOR(3 downto 0)
                 );
        end component dff_negedge_4bit;
    
        component dff_posedge_8bit is
            port ( d   : in  STD_LOGIC_VECTOR(7 downto 0);
                   clk : in  STD_LOGIC;
                   q   : out STD_LOGIC_VECTOR(7 downto 0);
                   qbar: out STD_LOGIC_VECTOR(7 downto 0)
                 );
        end component dff_posedge_8bit;
    
        component dff_negedge_8bit is
            port ( d   : in  STD_LOGIC_VECTOR(7 downto 0);
                   clk : in  STD_LOGIC;
                   q   : out STD_LOGIC_VECTOR(7 downto 0);
                   qbar: out STD_LOGIC_VECTOR(7 downto 0)
                 );
        end component dff_negedge_8bit;
    
        component decoder_2x4 is
            port (
                A : in  STD_LOGIC_VECTOR(1 downto 0);
                E : in  STD_LOGIC;
                Y : out STD_LOGIC_VECTOR(3 downto 0)
            );        
        end component decoder_2x4;
    
        component tag_comparator_2x1 is
            port (
                A : in  STD_LOGIC_VECTOR(1 downto 0);
                B : in  STD_LOGIC_VECTOR(1 downto 0);
                output : out STD_LOGIC
            );
        end component tag_comparator_2x1;
    
        component valid_comparator_2x1 is    
            port (
                A : in  STD_LOGIC;
                B : in  STD_LOGIC;
                output : out STD_LOGIC
            );
        end component valid_comparator_2x1;
        
        component tag_vector is
            port (
                write_data  : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit shared write data
                chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
                RW          : in  STD_LOGIC; -- Shared Read/Write signal for all cells
                sel         : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector for demux
                read_data : out STD_LOGIC_VECTOR(1 downto 0) -- Read data output for cell 3
            );
        end component tag_vector;
    
        component valid_vector is
            port (
                vdd         : in  STD_LOGIC; -- Power supply
                gnd         : in  STD_LOGIC; -- Ground
                write_data  : in  STD_LOGIC; -- Shared write data for demux
                reset       : in  STD_LOGIC; -- Shared reset signal for all cells
                chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
                RW          : in  STD_LOGIC; -- Shared Read/Write signal for all cells
                sel         : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector for demux, comes from decoder input
                read_data : out STD_LOGIC -- Read data output for cell 3
            );
        end component valid_vector;
    
        component block_cache is
            port(   mem_data    : in std_logic_vector(7 downto 0);
                    mem_addr    : out std_logic_vector(5 downto 0);
                    hit_miss    : in std_logic;
                    R_W         : in std_logic;
                    byte_offset : in std_logic_vector(3 downto 0);
                    block_offset: in std_logic_vector(3 downto 0);
                    cpu_data    : in std_logic_vector(7 downto 0);
                    read_data   : out std_logic_vector(7 downto 0));
        end component block_cache;
    
        component and_2x1 is
            port (
                A : in  STD_LOGIC;
                B : in  STD_LOGIC;
                output : out STD_LOGIC
            );
        end component and_2x1;

        component inverter is
            port (
                input  : in  STD_LOGIC;
                output : out STD_LOGIC
            );
        end component inverter;
    
    
        -- Intermediate signals
        signal read_valid : std_logic;
        signal read_tag : std_logic_vector(1 downto 0);
        signal cmp_tag, cmp_valid : std_logic;
        signal hit_miss, hit_miss_reg, valid_reg : std_logic;
        signal data_reg : std_logic_vector(7 downto 0);
        signal byte_decoder_out, block_decoder_out : std_logic_vector(3 downto 0);
        signal byte_decoder_reg, block_decoder_reg : std_logic_vector(3 downto 0);
        signal RW_valid : std_logic;
        signal RW_tag : std_logic;
            
        begin
            rw_valid_inv : component inverter
                port map ( input => valid_WE, output => RW_valid );
    
            rw_tag_inv : component inverter
                port map ( input => tag_WE, output => RW_tag );

            data_ff: component dff_negedge_8bit
                port map ( d => write_cache, clk => clk, q => data_reg, qbar => open );
    
            -- byte_ff: component dff_negedge_2bit
            --     port map ( d => byte_offset, clk => clk, q => byte_reg1, qbar => open );
    
            -- block_ff: component dff_negedge_2bit
            --     port map ( d => block_offset, clk => clk, q => block_reg1, qbar => open );
    
            -- tag_ff: component dff_negedge_2bit
            --     port map ( d => tag, clk => clk, q => tag_reg, qbar => open );
    
            -- valid_ff: component dff_negedge
            --     port map ( d => write_valid, clk => clk, q => valid_reg, qbar => open );
    
            -- data_ff2: component dff_posedge_8bit
            --     port map ( d => data_reg1, clk => clk, q => data_reg2, qbar => open );
    
            block_decoder: component decoder_2x4
                port map ( A => block_offset, E => decoder_enable, Y => block_decoder_out );
    
            byte_decoder: component decoder_2x4
                port map ( A => byte_offset, E => decoder_enable, Y => byte_decoder_out );
            
            byte_decoder_ff: component dff_posedge_4bit
                port map ( d => byte_decoder_out, clk => clk, q => byte_decoder_reg, qbar => open );
    
            block_decoder_ff: component dff_posedge_4bit
                port map ( d => block_decoder_out, clk => clk, q => block_decoder_reg, qbar => open );
    
            tag_vec: component tag_vector
                port map ( write_data => tag, chip_enable => block_decoder_out, RW => RW_tag, sel => block_offset, read_data => read_tag );
    
            valid_vec: component valid_vector
                port map ( vdd => vdd, gnd => gnd, write_data => write_valid, reset => reset, chip_enable => block_decoder_out, RW => RW_valid, sel => block_offset, read_data => read_valid );
    
            tag_cmp: component tag_comparator_2x1
                port map ( A => tag, B => read_tag, output => cmp_tag );
    
            valid_cmp: component valid_comparator_2x1
                port map ( A => vdd, B => read_valid, output => cmp_valid );
    
            hit_miss_cmp: component and_2x1
                port map ( A => cmp_tag, B => cmp_valid, output => hit_miss );
            
            hit_miss_ff: component dff_posedge
                port map ( d => hit_miss, clk => clk, q => hit_miss_reg, qbar => open );
    
            -- Now connect everything to the cache array
    
            cache: component block_cache
                port map (mem_data => mem_data, mem_addr => mem_addr, hit_miss => hit_miss_reg, R_W => RW_cache, byte_offset => byte_decoder_reg, block_offset => block_decoder_reg, cpu_data => data_reg, read_data => read_cache);
            
            -- register for read data
            
            -- read_cache_ff: component dff_negedge_8bit 
            --     port map ( d => read_cache, clk => clk, q => read_cache_reg, qbar => open );

            hit_or_miss <= hit_miss_reg; -- output for state machine, tells it whether there was a hit or miss in the current operation
            mem_addr(5 downto 4) <= tag;
            mem_addr(3 downto 2) <= block_offset;
            mem_addr(1) <= gnd;
            mem_addr(0) <= gnd;
end architecture structural;