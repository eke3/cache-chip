-- Entity: tb_cache_cell
-- Architecture: Test
-- Note: Run for 100 ns

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use STD.TEXTIO.all;

entity tb_cache_cell is
end tb_cache_cell;

architecture Test of tb_cache_cell is
    -- Component declaration for cache_cell
    component cache_cell
        port (
            write_data  : in  std_logic;
            chip_enable : in  std_logic;
            RW          : in  std_logic;
            read_data   : out std_logic
        );
    end component;

    for all: cache_cell use entity work.cache_cell(Structural);

    -- Signals to connect to the cache_cell inputs and outputs
    signal write_data  : std_logic;
    signal chip_enable : std_logic;
    signal RW          : std_logic;
    signal read_data   : std_logic;

begin

    -- Instantiate the cache_cell entity
    DUT: cache_cell
    port map (
        write_data  => write_data,
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data
    );

    -- Stimulus process to apply test vectors to the DUT
    stimulus_process: process
    begin
        -- Test Case 1: Try writing with chip_enable = 0 (Expect no write action)
        chip_enable <= '0';
        RW          <= '0'; -- Write mode
        write_data  <= '1';
        wait for 10 ns;
        assert (read_data = 'Z') report "Test Case 1 failed." severity warning;

        -- Test Case 2: Write with chip_enable = 1, RW = 0 (Expect write_data to be stored)
        chip_enable <= '1';
        RW          <= '0'; -- Write mode
        write_data  <= '1';
        wait for 10 ns;
        assert (read_data = 'Z') report "Test Case 2 failed." severity warning;

        -- Test Case 3: Read with chip_enable = 1, RW = 1 (Expect read_data to match stored value)
        RW          <= '1'; -- Read mode
        wait for 10 ns;
        assert (read_data = '1') report "Test Case 3 failed." severity warning;

        -- Test Case 4: Overwrite with new write_data = 0
        write_data  <= '0';
        RW          <= '0'; -- Write mode
        wait for 10 ns;
        assert (read_data = 'Z') report "Test Case 4 failed." severity warning;

        -- Test Case 5: Read after overwrite (Expect read_data = 0)
        RW          <= '1'; -- Read mode
        wait for 1 ns;
        write_data  <= '1';
        wait for 10 ns;
        assert (read_data = '0') report "Test Case 5 failed." severity warning;

        -- Test Case 6: Disable chip_enable and attempt read
        chip_enable <= '0';
        wait for 10 ns;
        assert (read_data = 'Z') report "Test Case 6 failed." severity warning;

        -- End simulation
        assert false report "Test bench completed." severity warning;
	wait;
    end process;

end Test;
