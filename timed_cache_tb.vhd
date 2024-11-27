-- Entity: timed_cache_tb
-- Architecture: Test

library IEEE;
use IEEE.std_logic_1164.all;

entity timed_cache_tb is
end entity timed_cache_tb;

architecture Test of timed_cache_tb is
    component timed_cache is
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
            output_enable: in std_logic;
            RW_cache      : in  std_logic; -- from reg
            RW_cache_SM : in std_logic; -- from SM
            --RW_busy       : in std_logic;
            decoder_enable: in  std_logic; -- from state machine
            mem_data      : in  std_logic_vector(7 downto 0); -- from memory
            mem_addr      : out std_logic_vector(5 downto 0); -- to memory
            read_cache    : out std_logic_vector(7 downto 0); -- to on-chip register, which will be released off chip by state machine's OUTPUT_ENABLE signal
            hit_or_miss      : out std_logic
        );
    end component timed_cache;

    -- system inputs
    signal vdd : std_logic := '1';
    signal gnd : STD_LOGIC := '0';
    signal clk, reset : STD_LOGIC;

    -- signals from cpu
    signal write_cache : STD_LOGIC_VECTOR(7 downto 0);
    signal tag, block_offset, byte_offset : STD_LOGIC_VECTOR(1 downto 0);
    signal write_valid : STD_LOGIC;

    -- signals from state machine
    signal valid_WE, tag_WE, output_enable, RW_cache, decoder_enable, RW_cache_SM : STD_LOGIC;

    -- status signal for state machine
    signal hit_or_miss : STD_LOGIC;

    -- signal from memory
    signal mem_data : STD_LOGIC_VECTOR(7 downto 0);

    -- output to memory
    signal mem_addr : STD_LOGIC_VECTOR(5 downto 0);

    -- output to cpu
    signal read_cache : STD_LOGIC_VECTOR(7 downto 0);


begin

    cache: entity work.timed_cache(structural) port map (
        vdd           => vdd,
        gnd           => gnd,
        clk           => clk,
        reset         => reset,
        write_cache   => write_cache,
        block_offset  => block_offset,
        byte_offset   => byte_offset,
        write_valid   => write_valid,
        tag     => tag,
--        RW_valid      : in  std_logic; -- from state machine
--        RW_tag        : in  std_logic; -- from state machine
        valid_WE => valid_WE,
        tag_WE   => tag_WE,
        output_enable => output_enable,
        RW_cache      => RW_cache,
        RW_cache_SM => RW_cache_SM,
        --RW_busy       : in std_logic;
        decoder_enable => decoder_enable,
        mem_data      => mem_data,
        mem_addr      => mem_addr,
        read_cache    => read_cache,
        hit_or_miss => hit_or_miss
    );

    -- clock process
    clk_gen: process
    begin
        clk <= '1'; 
        wait for 10 ns;
        clk <= '0'; 
        wait for 10 ns;        
    end process clk_gen;

    -- stimulus process
    stim: process 
    begin
        -- initialize values
        write_cache  <= X"AD";
        block_offset <= "XX";
        byte_offset <= "XX";
        write_valid <= '1'; -- always 1
        tag <= "XX";
        valid_WE <= 'X';
        tag_WE <= 'X';
        output_enable <= 'X';
        RW_cache <= 'X';
        decoder_enable <= 'X';
        mem_data <= "XXXXXXXX";
        -- hold reset for 2 cycles

        reset <= '1';
        wait for 40 ns;
        
        reset <= '0';
        -- in 30 (and 10) ns a negative edge comes
        wait for 10 ns;
        -- on this positive edge start will go high, we start our operation on the subsequent negative edge
        tag <= "01"; block_offset <= "01"; byte_offset <= "01";
        valid_WE <= '0'; tag_WE <= '0';
        decoder_enable <= '1'; -- BUSY signal goes high on the negative clock edge
        output_enable <= '0';
--        RW_cache <= '1'; -- try to read the cache 
        RW_cache_SM <= '1';
        wait for 160 ns;

        -- briefly enable writing to valid and tag
        valid_WE <= '1'; tag_WE <= '1';
        wait for 20 ns;
        valid_WE <= '0'; tag_WE <= '0';
        -- start transmitting data to write
        mem_data <= X"AB";
--        RW_cache <= '0';
        byte_offset <= "00";
        wait for 40 ns;
        mem_data <= X"CD";
        byte_offset <= "01";
        wait for 40 ns;
        mem_data <= X"EF";
        byte_offset <= "10";
        wait for 40 ns;
        mem_data <= X"01";
        byte_offset <= "11";
        wait for 40 ns;
        -- now we have finished writing, we will now check to see if the write was successful

--        RW_cache <= '1';
        decoder_enable <= '1';
        mem_data <= "XXXXXXXX";
        wait for 100 ns;

--        RW_cache <= '1';
        byte_offset <= "01";
        decoder_enable <= '1';
        output_enable <= '1';
        wait for 20 ns;

        output_enable <= '0';
        decoder_enable <= '0';
        RW_cache <= 'X';


        wait;
    end process stim;
end architecture Test;