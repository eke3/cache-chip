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
    signal hit_miss, hit_miss_reg : std_logic;
    signal data_reg1, data_reg2 : std_logic_vector(7 downto 0);
    signal byte_reg1, block_reg1 : std_logic_vector(1 downto 0);
    signal byte_decoder_out, block_decoder_out : std_logic_vector(3 downto 0);
    signal byte_decoder_reg, block_decoder_reg : std_logic_vector(3 downto 0);
    signal tag_reg : std_logic_vector(1 downto 0);
    signal high_wire : std_logic := '1';

    -- Throwaway signals
    signal mem_data : std_logic_vector(7 downto 0);
    signal mem_addr : std_logic_vector(7 downto 0);
    signal read_cache : std_logic_vector(7 downto 0);


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
            port map ( d => write_valid, clk => clk, q => read_valid, qbar => open );

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
            port map ( write_data => write_valid, reset => reset, chip_enable => block_decoder_out, RW => RW_valid, sel => block_reg1, read_data => read_valid );

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

        stimulus: process
        begin
            -- Initialize signals
            clk <= '1';
            reset <= '0';
            write_valid <= '1';
            write_tag <= "11";
            write_cache <= X"0F";
            block_offset <= "00";
            byte_offset <= "00";
            wait for 10 ns;
            clk <= '0';
            wait for 10 ns;

            -- system reset
            reset <= '1';
            wait for 10 ns;
            reset <= '0';
            wait for 10 ns;
            
            -- check that valid contains zeros
            -- monitor 'read_valid' signal
            decoder_enable <= '1';
            RW_valid <= '1';
                        RW_tag <= '0';

            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
            clk <= '0';
            wait for 10 ns;


            --RW_tag <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
            clk <= '0';
            wait for 10 ns;
            -- put ones in the first 2 rows of valid vector
            
            RW_tag <= '1';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
            clk <= '0';
            wait for 10 ns;
            
            RW_cache <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
            clk <= '0';
            wait for 10 ns;
            
            RW_cache <= '1';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
            clk <= '0';
            wait for 10 ns;



            -- put 11 in the first 2 rows of tag vector

            wait;
        end process;
    end architecture Test;
        




