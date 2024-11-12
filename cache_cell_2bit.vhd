-- Entity: cache_cell_2bit
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cache_cell_2bit is
    port (
        write_data  : in  std_logic_vector(1 downto 0);
        reset       : in  std_logic;               -- New reset input
        chip_enable : in  std_logic;
        RW          : in  std_logic;
        read_data   : out std_logic_vector(1 downto 0)
    );
end entity cache_cell_2bit;

architecture structural of cache_cell_2bit is
    component cache_cell is
        port (
            write_data  : in  std_logic;
            reset       : in  std_logic;           -- Reset input for each cache cell instance
            chip_enable : in  std_logic;
            RW          : in  std_logic;
            read_data   : out std_logic
        );
    end component cache_cell;

    -- Instantiate two cache_cell components, one for each bit
    for cache_0, cache_1: cache_cell use entity work.cache_cell(structural);

begin
    -- Map signals to each cache cell instance
    cache_0: cache_cell port map (
        write_data  => write_data(0),
        reset       => reset,              -- Connect reset to cache_0
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(0)
    );

    cache_1: cache_cell port map (
        write_data  => write_data(1),
        reset       => reset,              -- Connect reset to cache_1
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(1)
    );

end architecture structural;

