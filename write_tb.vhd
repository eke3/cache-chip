-- Entity: write_tb
-- Architecture: Test

library IEEE;
use IEEE.std_logic_1164.all;

entity write_tb is
end write_tb;

architecture test of write_tb is

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
                mem_addr    : out std_logic_vector(7 downto 0);
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

    -- System inputs
    signal clk, reset : std_logic;
    signal write_cache : std_logic_vector(7 downto 0);
    signal block_offset, byte_offset : std_logic_vector(1 downto 0);
    signal write_valid : std_logic;
    signal write_tag : std_logic_vector(1 downto 0);
    
    -- State machine signals
    signal RW_valid, RW_tag, RW_cache : std_logic;
    signal decoder_enable : std_logic;

    -- Intermediate signals
    signal read_valid : std_logic;
    signal read_tag : std_logic_vector(1 downto 0);
    signal cmp_tag, cmp_valid : std_logic;
    signal hit_miss, hit_miss_reg, valid_reg : std_logic;
    signal data_reg1, data_reg2 : std_logic_vector(7 downto 0);
    signal byte_reg1, block_reg1 : std_logic_vector(1 downto 0);
    signal byte_decoder_out, block_decoder_out : std_logic_vector(3 downto 0);
    signal byte_decoder_reg, block_decoder_reg : std_logic_vector(3 downto 0);
    signal tag_reg : std_logic_vector(1 downto 0);
    signal high_wire : std_logic := '1';

    -- Throwaway signals
    signal mem_data : std_logic_vector(7 downto 0);
    signal mem_addr : std_logic_vector(7 downto 0);
    signal read_cache, read_cache_reg : std_logic_vector(7 downto 0);








        signal valid_reset, valid_write, valid_RW, valid_read : std_logic;
        signal valid_sel : std_logic_vector(1 downto 0);
        signal valid_chip_enable : std_logic_vector(3 downto 0);
        
        
        
        
        
        

    begin
        data_ff: component dff_negedge_8bit
            port map ( d => write_cache, clk => clk, q => data_reg1, qbar => open );

        byte_ff: component dff_negedge_2bit
            port map ( d => byte_offset, clk => clk, q => byte_reg1, qbar => open );

        block_ff: component dff_negedge_2bit
            port map ( d => block_offset, clk => clk, q => block_reg1, qbar => open );

        tag_ff: component dff_negedge_2bit
            port map ( d => write_tag, clk => clk, q => tag_reg, qbar => open );

        valid_ff: component dff_negedge
            port map ( d => write_valid, clk => clk, q => valid_reg, qbar => open );

        data_ff2: component dff_posedge_8bit
            port map ( d => data_reg1, clk => clk, q => data_reg2, qbar => open );

        block_decoder: component decoder_2x4
            port map ( A => block_reg1, E => decoder_enable, Y => block_decoder_out );

        byte_decoder: component decoder_2x4
            port map ( A => byte_reg1, E => decoder_enable, Y => byte_decoder_out );
        
        byte_decoder_ff: component dff_posedge_4bit
            port map ( d => byte_decoder_out, clk => clk, q => byte_decoder_reg, qbar => open );

        block_decoder_ff: component dff_posedge_4bit
            port map ( d => block_decoder_out, clk => clk, q => block_decoder_reg, qbar => open );

        tag_vec: component tag_vector
            port map ( write_data => tag_reg, chip_enable => block_decoder_out, RW => RW_tag, sel => block_reg1, read_data => read_tag );

        valid_vec: component valid_vector
            port map ( write_data => valid_reg, reset => reset, chip_enable => block_decoder_out, RW => RW_valid, sel => block_reg1, read_data => read_valid );

        tag_cmp: component tag_comparator_2x1
            port map ( A => tag_reg, B => read_tag, output => cmp_tag );

        valid_cmp: component valid_comparator_2x1
            port map ( A => high_wire, B => read_valid, output => cmp_valid );

        hit_miss_cmp: component and_2x1
            port map ( A => cmp_tag, B => cmp_valid, output => hit_miss );
        
        hit_miss_ff: component dff_posedge
            port map ( d => hit_miss, clk => clk, q => hit_miss_reg, qbar => open );

        -- Now connect everything to the cache array

        cache: component block_cache
            port map (mem_data => mem_data, mem_addr => mem_addr, hit_miss => hit_miss_reg, R_W => RW_cache, byte_offset => byte_decoder_reg, block_offset => block_decoder_reg, cpu_data => data_reg2, read_data => read_cache);
           
        -- register for read data
        
        read_cache_ff: component dff_negedge_8bit 
            port map ( d => read_cache, clk => clk, q => read_cache_reg, qbar => open );

        stimulus: process
        begin
            -- Initialize signals
            clk <= '1';
            reset <= '1';
            write_valid <= '1'; -- going to make one of the rows valid
            RW_valid <= '0'; -- write to valid
            write_tag <= "01"; -- going to make one of the rows valid
            RW_tag <= '0'; -- write to tag
            block_offset <= "00";
            byte_offset <= "00";
            
            wait for 10 ns;
            reset <= '0'; -- unpress reset
            
            wait for 10 ns;
            clk <= '0';
            decoder_enable <= '1';
            wait for 10 ns;
            clk <= '1'; -- prepare clock to start program
            
            write_cache <= X"0F"; -- going to write 0F to cell at (00,00)
            RW_cache <= '0'; -- writing to cache
            RW_valid <= '1'; -- need to read valid to check for hit/miss
            RW_tag <= '1'; -- need to read tag to check for hit/miss
            wait for 10 ns;
            clk <= '0'; -- on negative edge the above value write_cache get loaded into registers
            -- while on negative level, hit/miss is calculated
            wait for 10 ns;
            
            clk <= '1';
            wait for 10 ns; -- on this positive edge, hit/miss latches to hit_miss_reg
            -- on this positive level, a write happens to the cache cell 
            
            decoder_enable <= '0';
            clk <= '0';
            -- disable decoder on negative edge
            wait for 10 ns;
            
            -- now lets check to see if it was successfully written
            RW_cache <= '1'; -- read from that same cache cell
            write_cache <= "XXXXXXXX"; -- dont care about this anymore
            clk <= '1';
            wait for 10 ns;
            decoder_enable <= '1'; -- enable decoder before operation

            clk <= '0';
            -- this is the start of the operation. in the sim window, the new XXXX for write_cache latches on this negative edge
            -- BUSY would go high on this negative edge
            wait for 10 ns;
--            decoder_enable <= '1';
            clk <= '1'; -- hit/miss latches to a register on this positive edge
            -- data gets read from the cache, is not available yet. will be latched to an output register on the next negative edge
            wait for 10 ns;
            
            decoder_enable <= '0';
            clk <= '0';
            -- data from cache latches to an output register and should be available starting from this negative edge
            -- BUSY would go low on this negative edge
            wait for 10 ns;
            
            clk <= '1';
            wait for 10 ns;
            
            clk <= '0';
            -- BUSY would go low on this negative edge
            wait for 10 ns;
            


            wait;
        end process;
    end architecture Test;
        




