-- Entity: write_tb
-- Architecture: Test

library IEEE;
use IEEE.std_logic_1164.all;

entity write_tb is
end write_tb;

architecture Test of write_tb is

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

    component nand_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component nand_2x1;

    -- System inputs
    signal clk, reset : std_logic;
    signal write_cache : std_logic_vector(7 downto 0);
    signal block_offset, byte_offset : std_logic_vector(1 downto 0);
    signal write_valid : std_logic;
    signal write_tag : std_logic_vector(1 downto 0);
    
    -- State machine signals
    signal RW_valid, RW_tag, RW_cache : std_logic;
    signal decoder_enable : std_logic;
    signal load_chip : std_logic;

    -- Intermediate signals
    signal read_valid : std_logic;
    signal read_tag : std_logic_vector(1 downto 0);
    signal cmp_tag, cmp_valid : std_logic;
    signal hit_miss, hit_miss_reg : std_logic;
    signal data_reg1, data_reg2 : std_logic_vector(7 downto 0);
    signal byte_reg1, block_reg1 : std_logic_vector(1 downto 0);
    signal byte_decoder_out, block_decoder_out : std_logic_vector(3 downto 0);
    signal byte_decoder_reg, block_decoder_reg : std_logic_vector(3 downto 0);
    signal tag_reg : std_logic_vector(1 downto 0);
    signal vdd : std_logic := '1';
    signal gnd : std_logic := '0';
    signal read_cache : std_logic_vector(7 downto 0);
    signal not_clk, chip_load_logic : std_logic;
--    signal valid_reg : std_logic;

    -- Throwaway signals
    signal mem_data : std_logic_vector(7 downto 0);
    signal mem_addr : std_logic_vector(5 downto 0);
    signal read_cache_reg : std_logic_vector(7 downto 0);
        

    begin
        clock_inv: entity work.inverter(Structural)
            port map ( input => clk, output => not_clk );

        chip_load: entity work.nand_2x1(Structural)
            port map ( A => not_clk, B => load_chip, output => chip_load_logic );

        data_ff: entity work.dff_negedge_8bit(Structural)
            port map ( d => write_cache, clk => chip_load_logic, q => data_reg1, qbar => open );

        byte_ff: entity work.dff_negedge_2bit(Structural)
            port map ( d => byte_offset, clk => chip_load_logic, q => byte_reg1, qbar => open );

        block_ff: entity work.dff_negedge_2bit(Structural)
            port map ( d => block_offset, clk => chip_load_logic, q => block_reg1, qbar => open );

        tag_ff: entity work.dff_negedge_2bit(Structural)
            port map ( d => write_tag, clk => chip_load_logic, q => tag_reg, qbar => open );
        
--        valid_ff: entity work.dff_negedge(Structural)
--            port map ( d => write_valid, clk => clk, q => valid_reg, qbar => open );

        data_ff2: entity work.dff_posedge_8bit(Structural)
            port map ( d => data_reg1, clk => clk, q => data_reg2, qbar => open );

        block_decoder: entity work.decoder_2x4(Structural)
            port map ( A => block_reg1, E => decoder_enable, Y => block_decoder_out );

        byte_decoder: entity work.decoder_2x4(Structural)
            port map ( A => byte_reg1, E => decoder_enable, Y => byte_decoder_out );
        
        byte_decoder_ff: entity work.dff_posedge_4bit(Structural)
            port map ( d => byte_decoder_out, clk => clk, q => byte_decoder_reg, qbar => open );

        block_decoder_ff: entity work.dff_posedge_4bit(Structural)
            port map ( d => block_decoder_out, clk => clk, q => block_decoder_reg, qbar => open );

        tag_vec: entity work.tag_vector(Structural)
            port map ( write_data => tag_reg, chip_enable => block_decoder_out, RW => RW_tag, sel => block_reg1, read_data => read_tag );

--        valid_vec: entity work.valid_vector(Structural)
--            port map ( write_data => valid_reg, reset => reset, chip_enable => block_decoder_out, RW => RW_valid, sel => block_reg1, read_data => read_valid );

        valid_vec: entity work.valid_vector(Structural)
            port map ( vdd => vdd, gnd => gnd, write_data => write_valid, reset => reset, chip_enable => block_decoder_out, RW => RW_valid, sel => block_reg1, read_data => read_valid );

        tag_cmp: entity work.tag_comparator_2x1(Structural)
            port map ( A => tag_reg, B => read_tag, output => cmp_tag );

        valid_cmp: entity work.valid_comparator_2x1(Structural)
            port map ( A => vdd, B => read_valid, output => cmp_valid );

        hit_miss_cmp: entity work.and_2x1(Structural)
            port map ( A => cmp_tag, B => cmp_valid, output => hit_miss );
        
        hit_miss_ff: entity work.dff_posedge(Structural)
            port map ( d => hit_miss, clk => clk, q => hit_miss_reg, qbar => open );

        -- Now connect everything to the cache array

        cache: entity work.block_cache(Structural)
            port map (mem_data => mem_data, hit_miss => hit_miss_reg, R_W => RW_cache, byte_offset => byte_decoder_reg, block_offset => block_decoder_reg, cpu_data => data_reg2, read_data => read_cache);
           
        -- register for read data
        
        read_cache_ff: entity work.dff_negedge_8bit(Structural)
            port map ( d => read_cache, clk => clk, q => read_cache_reg, qbar => open );

        stimulus: process
        begin
            -- Initialize signals
            clk <= '1';
            reset <= '1';
--            write_valid <= '1'; -- going to make one of the rows valid
            write_tag <= "01"; -- going to make one of the rows valid
            block_offset <= "01";
            byte_offset <= "01";
            
            wait for 10 ns;
            reset <= '0'; -- unpress reset
            
            wait for 10 ns;

            clk <= '0';
            decoder_enable <= '1';
            RW_tag <= '0'; -- write to tag
            RW_valid <= '0'; -- write to valid
            write_valid <= '1'; -- going to make one of the rows valid
                        load_chip <= '1';



            wait for 10 ns;
            clk <= '1'; -- prepare clock to start program
            wait for 10 ns;
            clk <= '0';
            decoder_enable <= '0';
            RW_valid <= 'X'; -- write to valid
            write_valid <= 'X'; 
                        load_chip <= '0';


            RW_tag <= 'X';
            wait for 10 ns;
            clk <= '1';
            decoder_enable <= '1';
            write_cache <= X"0F"; -- going to write 0F to cell at (00,00)
            RW_cache <= '0'; -- writing to cache
            RW_valid <= '1'; -- need to read valid to check for hit/miss
            RW_tag <= '1'; -- need to read tag to check for hit/miss
            wait for 10 ns;
            clk <= '0'; -- on negative edge the above value write_cache get loaded into registers
            -- while on negative level, hit/miss is calculated
                        load_chip <= '1';
            wait for 10 ns;
            
            clk <= '1';
            wait for 10 ns; -- on this positive edge, hit/miss latches to hit_miss_reg
            -- on this positive level, a write happens to the cache cell 
            
            decoder_enable <= '0';
                        block_offset <= "XX";
                        byte_offset <= "XX";
            clk <= '0';
                        load_chip <= '0';
            -- disable decoder on negative edge
            wait for 10 ns;
            
            -- now lets check to see if it was successfully written
            write_cache <= "XXXXXXXX"; -- dont care about this anymore
            clk <= '1';
            wait for 10 ns;
            RW_cache<='1';
            decoder_enable <= '1'; -- enable decoder before operation
                    block_offset <= "01";
                    byte_offset <= "01";
            clk <= '0';
            -- this is the start of the operation. in the sim window, the new XXXX for write_cache latches on this negative edge
            -- BUSY would go high on this negative edge
            
                        load_chip <= '1';
            wait for 10 ns;
            clk <= '1'; -- hit/miss latches to a register on this positive edge
            -- data gets read from the cache, is not available yet. will be latched to an output register on the next negative edge
            wait for 10 ns;
            
            decoder_enable <= '0';
            RW_cache <= 'X'; -- RW_cache no longer matters once busy goes low
            clk <= '0';
            -- data from cache latches to an output register and should be available starting from this negative edge
            -- OUTPUT_ENABLE for the chip should go high here
            -- BUSY would go low on this negative edge
                        load_chip <= '0';
                        block_offset <= "XX";
                        byte_offset <= "XX";
            wait for 10 ns;
            
            clk <= '1';
            wait for 10 ns;
            
            clk <= '0';
            -- BUSY would go low on this negative edge
            wait for 10 ns;

            wait;
        end process;
    end architecture Test;
        




