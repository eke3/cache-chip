-- Entity: tb_timed_cache
-- Architecture: Test
-- Note: Run for 2500 ns

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_textio.all;

entity tb_timed_cache is
end tb_timed_cache;

architecture Test of tb_timed_cache is
    component timed_cache 
        port (
            vdd                    : in  std_logic;                    -- power supply
            gnd                    : in  std_logic;                    -- ground
            clk                    : in  std_logic;                    -- system clock
            reset                  : in  std_logic;                    -- system reset
            write_cache            : in  std_logic_vector(7 downto 0); -- from on-chip register, released by state machine
            block_offset           : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            byte_offset            : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            tag                    : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            valid_tag_WE               : in  std_logic;                    -- from state machine
            output_enable          : in  std_logic;
            RW_cache               : in  std_logic;                    -- from reg
            busy                   : in  std_logic;
            decoder_enable         : in  std_logic;                    -- from state machine
            mem_addr_output_enable : in  std_logic;
            mem_addr               : out std_logic_vector(5 downto 0); -- to memory
            read_cache             : out std_logic_vector(7 downto 0); -- to on-chip register, which will be released off chip by state machine's OUTPUT_ENABLE signal
            hit_or_miss            : out std_logic
        );
    end component;

    for all: timed_cache use entity work.timed_cache(Structural);

    -- system inputs
    signal clk, reset                                                                              : STD_LOGIC;

    -- signal from cpu/memory
    signal write_cache                                                                             : STD_LOGIC_VECTOR(7 downto 0);

    -- signals from cpu
    signal tag, block_offset, byte_offset                                                          : STD_LOGIC_VECTOR(1 downto 0);
    signal START                                                                                   : STD_LOGIC;

    -- signals from state machine
    signal valid_tag_WE, output_enable, RW_cache, decoder_enable, mem_addr_output_enable, BUSY : STD_LOGIC;

    -- status signal for state machine
    signal hit_or_miss                                                                             : STD_LOGIC;

    -- output to memory
    signal mem_addr                                                                                : STD_LOGIC_VECTOR(5 downto 0);

    -- output to cpu
    signal read_cache                                                                              : STD_LOGIC_VECTOR(7 downto 0);
    signal vdd : std_logic := '1';
    signal gnd : std_logic := '0';


begin

    cache: timed_cache
    port map (
        vdd                    => vdd,
        gnd                    => gnd,
        clk                    => clk,
        reset                  => reset,
        write_cache            => write_cache,
        block_offset           => block_offset,
        byte_offset            => byte_offset,
        tag                    => tag,
        valid_tag_WE               => valid_tag_WE,
        output_enable          => output_enable,
        RW_cache               => RW_cache,
        busy                   => BUSY,
        decoder_enable         => decoder_enable,
        mem_addr_output_enable => mem_addr_output_enable,
        mem_addr               => mem_addr,
        read_cache             => read_cache,
        hit_or_miss            => hit_or_miss
    );

    -- clock process
    clk_gen: process
    begin
        clk                        <= '1';
        wait for 10 ns;
        clk                        <= '0';
        wait for 10 ns;
    end process clk_gen;

    -- Stimulus process
    stim: process
        -- write miss procedure
        procedure write_miss_test is
        begin
            wait for 60 ns;
            START                  <= '1';
            wait for 10 ns;
            -- on this positive edge start will go high, we start our operation on the subsequent negative edge
            BUSY                   <= '1';
            write_cache            <= "11111111";
            tag                    <= "01";
            block_offset           <= "01";
            byte_offset            <= "01";
            valid_tag_WE               <= '0';
            decoder_enable         <= '1';                             -- signal goes high on the negative clock edge
            output_enable          <= '0';
            mem_addr_output_enable <= '0';
            RW_cache               <= '0';                             -- try to write to the cache
            wait for 10 ns;
            START                  <= '0';
            wait for 30 ns;
            BUSY                   <= '0';
            wait for 20 ns;
        end write_miss_test;

        -- write hit procedure
        procedure write_hit_test is
        begin
            wait for 70 ns;
            START                  <= '1';
            wait for 10 ns;
            -- on this positive edge start will go high, we start our operation on the subsequent negative edge
            BUSY                   <= '1';
            write_cache            <= "11111111";
            tag                    <= "01";
            block_offset           <= "01";
            byte_offset            <= "01";
            valid_tag_WE               <= '0';
            decoder_enable         <= '1';                             -- signal goes high on the negative clock edge
            output_enable          <= '0';
            mem_addr_output_enable <= '0';
            RW_cache               <= '0';                             -- try to write to the cache
            wait for 10 ns;
            START                  <= '0';
            wait for 30 ns;
            BUSY                   <= '0';
            wait for 20 ns;
        end write_hit_test;

        -- read miss procedure
        procedure read_miss_test is
        begin
            wait for 60 ns;
            START                  <= '1';
            wait for 10 ns;
            -- on this positive edge start will go high, we start our operation on the subsequent negative edge
            BUSY                   <= '1';
            tag                    <= "01";
            block_offset           <= "01";
            byte_offset            <= "01";
            valid_tag_WE               <= '0';
            decoder_enable         <= '1';                             -- signal goes high on the negative clock edge
            output_enable          <= '0';
            mem_addr_output_enable <= '0';
            RW_cache               <= '1';                             -- try to read the cache
            wait for 10 ns;
            START                  <= '0';
            wait for 10 ns;
            mem_addr_output_enable <= '1';
            -- on first negative edge all values from cpu will latch to chip
            wait for 20 ns;
            mem_addr_output_enable <= '0';
            wait for 20 ns;
            -- briefly enable writing to valid and tag
            valid_tag_WE               <= '1';
            wait for 20 ns;
            valid_tag_WE               <= '0';
            wait for 100 ns;

            -- start transmitting data to write

            -- *** cpu_data and mem_data have been consolidated into write_cache. needs external logic to choose which to write from (a mux select from state machine)***
            write_cache            <= "10101011";                           -- mem_data
            RW_cache               <= '0';
            byte_offset            <= "00";
            wait for 40 ns;
            write_cache            <= "11001101";
            byte_offset            <= "01";
            wait for 40 ns;
            write_cache            <= "11101111";
            byte_offset            <= "10";
            wait for 40 ns;
            write_cache            <= "00000001";
            byte_offset            <= "11";
            wait for 40 ns;
            -- now finished writing, reads back the original request

            RW_cache               <= '1';
            decoder_enable         <= '1';
            byte_offset            <= "00";
            write_cache            <= "ZZZZZZZZ";
            wait for 20 ns;

            BUSY                   <= '0';
            decoder_enable         <= '1';
            output_enable          <= '1';
            -- data becomes available on a positive edge. on the subsequent negative edge, OUTPUT_ENABLE goes high for 1 cycle and it gets transmitted to the cpu
            wait for 20 ns;
            assert (read_cache = "10101011") report "Read miss failed." severity warning;
            output_enable          <= 'Z';

        end read_miss_test;

        -- read hit procedure
        procedure read_hit_test is
        begin
            wait for 10 ns;
            -- initialize values
            START                  <= '0';
            BUSY                   <= '0';
            write_cache            <= "ZZZZZZZZ";                      -- cpu data
            block_offset           <= "ZZ";
            byte_offset            <= "ZZ";
            tag                    <= "ZZ";
            valid_tag_WE               <= 'Z';
            output_enable          <= 'Z';
            RW_cache               <= 'Z';
            decoder_enable         <= 'Z';
            mem_addr_output_enable <= 'Z';
            wait for 40 ns;

            START                  <= '1';
            wait for 10 ns;
            -- on this positive edge start will go high, we start our operation on the subsequent negative edge
            BUSY                   <= '1';
            tag                    <= "01";
            block_offset           <= "01";
            byte_offset            <= "01";
            valid_tag_WE               <= '0';
            decoder_enable         <= '1';                             -- signal goes high on the negative clock edge
            output_enable          <= '0';
            mem_addr_output_enable <= '0';
            RW_cache               <= '1';                             -- try to read the cache
            wait for 10 ns;
            START                  <= '0';
            wait for 10 ns;
            BUSY                   <= '0';
            output_enable          <= '1';
            wait for 20 ns;
            output_enable          <= '0';
        end read_hit_test;

        procedure system_reset is
        begin

            -- initialize values
            START                  <= 'Z';
            BUSY                   <= 'Z';
            write_cache            <= "ZZZZZZZZ";                      -- cpu data
            block_offset           <= "ZZ";
            byte_offset            <= "ZZ";
            tag                    <= "ZZ";
            valid_tag_WE               <= 'Z';
            output_enable          <= 'Z';
            RW_cache               <= 'Z';
            decoder_enable         <= 'Z';
            mem_addr_output_enable <= 'Z';
            reset                  <= 'Z';
            wait for 200 ns;
            -- hold reset for 2 cycles
            reset                  <= '1';
            wait for 40 ns;
            reset                  <= '0';
        end system_reset;


    begin
        -- ***To do all these tests in the same run, set simulation time to at least 2500 ns***

        -- THIS BLOCK TESTS WRITE MISS
        system_reset;
        write_miss_test;
        -- write miss is over, now try to read it
        -- "ZZZZZZZZ" should be read from the cache, because nothing was written
        read_hit_test;
        assert (read_cache = "ZZZZZZZZ") report "Write miss test failed." severity warning;

        -- THIS BLOCK TESTS READ MISS AND READ HIT
        system_reset;
        wait for 10 ns;
        read_miss_test;
        -- read miss is over, now try to read one of the values written by the read miss
        -- "CD" should be read from the cache
        read_hit_test;
        assert (read_cache = "11001101") report "Read hit/miss test failed." severity warning;

        -- THIS BLOCK TESTS WRITE HIT
        system_reset;
        wait for 10 ns;
        read_miss_test;
        write_hit_test;
        -- should write to one of the cells written and validated by the read miss
        -- "FF" should be read from the cache
        read_hit_test;
        assert (read_cache = "11111111") report "Write hit test failed." severity warning;

        wait for 10 ns;
        system_reset;

        assert false report "Testbench completed." severity warning;
	wait;
    end process;

end Test;
