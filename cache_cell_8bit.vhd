-- Entity: cache_cell_8bit
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cache_cell_8bit is
    port (
        write_data  : in  std_logic_vector(7 downto 0);
        reset       : in  std_logic;                -- New reset input
        chip_enable : in  std_logic;
        RW          : in  std_logic;
        read_data   : out std_logic_vector(7 downto 0)
    );
end entity cache_cell_8bit;

architecture structural of cache_cell_8bit is
    component cache_cell is
        port (
            write_data  : in  std_logic;
            reset       : in  std_logic;           -- Reset input for each cache cell instance
            chip_enable : in  std_logic;
            RW          : in  std_logic;
            read_data   : out std_logic
        );
    end component cache_cell;

    -- Instantiate eight cache_cell components, one for each bit
    for cache_0, cache_1, cache_2, cache_3, cache_4, cache_5, cache_6, cache_7: cache_cell use entity work.cache_cell(structural);

begin
    -- Map signals to each cache cell instance
    cache_0: cache_cell port map (
        write_data  => write_data(0),
        reset       => reset,               -- Connect reset to cache_0
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(0)
    );

    cache_1: cache_cell port map (
        write_data  => write_data(1),
        reset       => reset,               -- Connect reset to cache_1
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(1)
    );

    cache_2: cache_cell port map (
        write_data  => write_data(2),
        reset       => reset,               -- Connect reset to cache_2
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(2)
    );

    cache_3: cache_cell port map (
        write_data  => write_data(3),
        reset       => reset,               -- Connect reset to cache_3
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(3)
    );

    cache_4: cache_cell port map (
        write_data  => write_data(4),
        reset       => reset,               -- Connect reset to cache_4
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(4)
    );

    cache_5: cache_cell port map (
        write_data  => write_data(5),
        reset       => reset,               -- Connect reset to cache_5
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(5)
    );

    cache_6: cache_cell port map (
        write_data  => write_data(6),
        reset       => reset,               -- Connect reset to cache_6
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(6)
    );

    cache_7: cache_cell port map (
        write_data  => write_data(7),
        reset       => reset,               -- Connect reset to cache_7
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(7)
    );

end architecture structural;

