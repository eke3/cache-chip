-- Entity: tb_block_cache
-- Architecture: Test
-- Note: Run for 100 ns

library IEEE;
use IEEE.std_logic_1164.all;

entity tb_block_cache is
end tb_block_cache;

architecture Test of tb_block_cache is

    -- Component declaration for block_cache
    component block_cache 
        port (
            write_cache  : in  std_logic_vector(7 downto 0);
            hit_miss     : in  std_logic;
            R_W          : in  std_logic;
            byte_offset  : in  std_logic_vector(3 downto 0);
            block_offset : in  std_logic_vector(3 downto 0);
            read_data    : out std_logic_vector(7 downto 0)
        );
    end component;

    for all: block_cache use entity work.block_cache(Structural);

    -- Test signals
    signal hit_miss     : std_logic;
    signal R_W          : std_logic;
    signal byte_offset  : std_logic_vector(3 downto 0);
    signal block_offset : std_logic_vector(3 downto 0);
    signal write_cache  : std_logic_vector(7 downto 0);
    signal read_data    : std_logic_vector(7 downto 0);

begin

    DUT: block_cache
    port map (
        hit_miss     => hit_miss,
        R_W          => R_W,
        byte_offset  => byte_offset,
        block_offset => block_offset,
        write_cache  => write_cache,
        read_data    => read_data
    );

    -- Stimulus process
    stim: process
    begin
        -- Initialize inputs
        write_cache  <= "ZZZZZZZZ";
        hit_miss     <= 'Z';
        R_W          <= 'Z';
        byte_offset  <= "ZZZZ";
        block_offset <= "ZZZZ";
        wait for 10 ns;


        -- Test Case 1: Write miss
        write_cache  <= X"BC";
        hit_miss     <= '0';
        R_W          <= '0';
        byte_offset  <= "1000";
        block_offset <= "1000";
        wait for 10 ns;
        assert (read_data = "UUUUUUUU") report "Write miss test failed." severity warning;
        -- read the cell (should be unchanged)
        write_cache  <= "ZZZZZZZZ";
        hit_miss     <= '1';
        R_W          <= '1';
        byte_offset  <= "1000";
        block_offset <= "1000";
        wait for 10 ns;
        assert (read_data = "XXXXXXXX") report "Write miss test failed." severity warning;

        -- Test Case 2: Write hit
        write_cache  <= X"AB";
        hit_miss     <= '1'; -- hit
        R_W          <= '0'; -- Write operation
        byte_offset  <= "1000";
        block_offset <= "1000";
        wait for 10 ns;
        assert (read_data = "XXXXXXXX") report "Write hit test failed." severity warning;

        -- Test Case 2: Read miss
        write_cache  <= "ZZZZZZZZ";
        hit_miss     <= '0';
        R_W          <= '1';
        byte_offset  <= "1000";
        block_offset <= "1000";
        wait for 10 ns;
        assert (read_data = "UUUUUUUU") report "Read miss test failed." severity warning;

        -- Test Case 3: Read hit
        write_cache  <= "ZZZZZZZZ";
        hit_miss     <= '1';
        R_W          <= '1';
        byte_offset  <= "1000";
        block_offset <= "1000";
        wait for 10 ns;
        assert (read_data = "10101011") report "Read hit test failed." severity warning;

        assert false report "Testbench completed." severity failure;
    end process;

end Test;
