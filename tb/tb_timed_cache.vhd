-- Entity: tb_timed_cache
-- Architecture: Test

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_timed_cache is
end entity tb_timed_cache;

architecture Test of tb_timed_cache is
    component timed_cache is
        port (
            vdd                    : in  std_logic;                    -- power supply
            gnd                    : in  std_logic;                    -- ground
            clk                    : in  std_logic;                    -- system clock
            reset                  : in  std_logic;                    -- system reset
            write_cache            : in  std_logic_vector(7 downto 0); -- from on-chip register, released by state machine
            block_offset           : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            byte_offset            : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            tag                    : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            valid_WE               : in  std_logic;                    -- from state machine
            tag_WE                 : in  std_logic;                    -- from state machine
            output_enable          : in  std_logic;
            RW_cache               : in  std_logic;                    -- from reg
            decoder_enable         : in  std_logic;                    -- from state machine
            mem_addr_output_enable : in  std_logic;
            mem_addr               : out std_logic_vector(5 downto 0); -- to memory
            read_cache             : out std_logic_vector(7 downto 0); -- to on-chip register, which will be released off chip by state machine's OUTPUT_ENABLE signal
            hit_or_miss            : out std_logic
        );
    end component timed_cache;

    -- system inputs
    signal vdd                                                                                     : std_logic := '1';
    signal gnd                                                                                     : STD_LOGIC := '0';
    signal clk, reset                                                                              : STD_LOGIC;

    -- signal from cpu/memory
    signal write_cache                                                                             : STD_LOGIC_VECTOR(7 downto 0);

    -- signals from cpu
    signal tag, block_offset, byte_offset                                                          : STD_LOGIC_VECTOR(1 downto 0);
    signal START                                                                                   : STD_LOGIC;

    -- signals from state machine
    signal valid_WE, tag_WE, output_enable, RW_cache, decoder_enable, mem_addr_output_enable, BUSY : STD_LOGIC;

    -- status signal for state machine
    signal hit_or_miss                                                                             : STD_LOGIC;

    -- output to memory
    signal mem_addr                                                                                : STD_LOGIC_VECTOR(5 downto 0);

    -- output to cpu
    signal read_cache                                                                              : STD_LOGIC_VECTOR(7 downto 0);


begin

    cache: entity work.timed_cache(Structural)
    port map (
        vdd                    => vdd,
        gnd                    => gnd,
        clk                    => clk,
        reset                  => reset,
        write_cache            => write_cache,
        block_offset           => block_offset,
        byte_offset            => byte_offset,
        tag                    => tag,
        valid_WE               => valid_WE,
        tag_WE                 => tag_WE,
        output_enable          => output_enable,
        RW_cache               => RW_cache,
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


    stim: process

        -- write miss procedure
        procedure write_miss_test is
        begin
            wait for 60 ns;
            START                  <= '1';
            wait for 10 ns;
            -- on this positive edge start will go high, we start our operation on the subsequent negative edge
            BUSY                   <= '1';
            write_cache            <= X"FF";
            tag                    <= "01";
            block_offset           <= "01";
            byte_offset            <= "01";
            valid_WE               <= '0';
            tag_WE                 <= '0';
            decoder_enable         <= '1';                             -- signal goes high on the negative clock edge
            output_enable          <= '0';
            mem_addr_output_enable <= '0';
            RW_cache               <= '0';                             -- try to write to the cache
            wait for 10 ns;
            START                  <= '0';
            wait for 30 ns;
            BUSY                   <= '0';
            wait for 20 ns;
        end procedure write_miss_test;

        -- write hit procedure
        procedure write_hit_test is
        begin
            wait for 70 ns;
            START                  <= '1';
            wait for 10 ns;
            -- on this positive edge start will go high, we start our operation on the subsequent negative edge
            BUSY                   <= '1';
            write_cache            <= X"FF";
            tag                    <= "01";
            block_offset           <= "01";
            byte_offset            <= "01";
            valid_WE               <= '0';
            tag_WE                 <= '0';
            decoder_enable         <= '1';                             -- signal goes high on the negative clock edge
            output_enable          <= '0';
            mem_addr_output_enable <= '0';
            RW_cache               <= '0';                             -- try to write to the cache
            wait for 10 ns;
            START                  <= '0';
            wait for 30 ns;
            BUSY                   <= '0';
            wait for 20 ns;
        end procedure write_hit_test;

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
            valid_WE               <= '0';
            tag_WE                 <= '0';
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
            valid_WE               <= '1';
            tag_WE                 <= '1';
            wait for 20 ns;
            valid_WE               <= '0';
            tag_WE                 <= '0';
            wait for 100 ns;

            -- start transmitting data to write

            -- *** cpu_data and mem_data have been consolidated into write_cache. needs external logic to choose which to write from (a mux select from state machine)***
            write_cache            <= X"AB";                           -- mem_data
            RW_cache               <= '0';
            byte_offset            <= "00";
            wait for 40 ns;
            write_cache            <= X"CD";
            byte_offset            <= "01";
            wait for 40 ns;
            write_cache            <= X"EF";
            byte_offset            <= "10";
            wait for 40 ns;
            write_cache            <= X"01";
            byte_offset            <= "11";
            wait for 40 ns;
            -- now finished writing, reads back the original request

            RW_cache               <= '1';
            decoder_enable         <= '1';
            byte_offset            <= "01";                            -- ***re-selecting original byte might not be automated yet? if not, needs implementation outside the timed_cache block***
            write_cache            <= "XXXXXXXX";
            wait for 20 ns;

            -- ***decoder_enable and RW switching during this operation should be controlled by state machine***
            -- ***decoder_enable needs to stay high through the end of read miss operation (so it cant just track BUSY)***
            BUSY                   <= '0';
            decoder_enable         <= '1';
            output_enable          <= '1';
            -- data becomes available on a positive edge. on the subsequent negative edge, OUTPUT_ENABLE goes high for 1 cycle and it gets transmitted to the cpu
            wait for 20 ns;

            output_enable          <= '0';
            decoder_enable         <= '0';
            RW_cache               <= 'X';
            byte_offset            <= "XX";

        end procedure read_miss_test;

        -- read hit procedure
        procedure read_hit_test is
        begin
            wait for 10 ns;
            -- initialize values
            START                  <= '0';
            BUSY                   <= '0';
            write_cache            <= "XXXXXXXX";                      -- cpu data
            block_offset           <= "XX";
            byte_offset            <= "XX";
            tag                    <= "XX";
            valid_WE               <= 'X';
            tag_WE                 <= 'X';
            output_enable          <= 'X';
            RW_cache               <= 'X';
            decoder_enable         <= 'X';
            mem_addr_output_enable <= 'X';
            wait for 40 ns;

            START                  <= '1';
            wait for 10 ns;
            -- on this positive edge start will go high, we start our operation on the subsequent negative edge
            BUSY                   <= '1';
            tag                    <= "01";
            block_offset           <= "01";
            byte_offset            <= "01";                            -- trying to read the "CD" written during the read miss
            valid_WE               <= '0';
            tag_WE                 <= '0';
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
        end procedure read_hit_test;

        procedure system_reset is
        begin
            -- hold reset for 2 cycles
            reset                  <= '1';
            wait for 40 ns;
            -- initialize values
            START                  <= '0';
            BUSY                   <= '0';
            write_cache            <= "XXXXXXXX";                      -- cpu data
            block_offset           <= "XX";
            byte_offset            <= "XX";
            tag                    <= "XX";
            valid_WE               <= 'X';
            tag_WE                 <= 'X';
            output_enable          <= 'X';
            RW_cache               <= 'X';
            decoder_enable         <= 'X';
            mem_addr_output_enable <= 'X';
            reset                  <= '0';
            wait for 20 ns;


        end procedure system_reset;


    begin
        -- ***To do all these tests in the same run, set simulation time to at least 1700 ns***

        -- THIS BLOCK TESTS WRITE MISS
        system_reset;
        write_miss_test;
        -- write miss is over, now try to read it
        -- "UU" should be read from the cache, because nothing was written
        read_hit_test;


        -- THIS BLOCK TESTS READ MISS AND READ HIT
        system_reset;
        wait for 10 ns;
        read_miss_test;
        -- read miss is over, now try to read one of the values written by the read miss
        -- "CD" should be read from the cache
        read_hit_test;


        -- THIS BLOCK TESTS WRITE HIT
        system_reset;
        read_miss_test;
        write_hit_test;
        -- should write to one of the cells written and validated by the read miss
        -- "FF" should be read from the cache
        read_hit_test;

        wait;
    end process stim;

end architecture Test;
