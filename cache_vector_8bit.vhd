-- Entity: cache_vector_8bit
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_vector_8bit is
    port (
        RW          : in  std_logic;                        -- 1-bit Read/Write signal (shared)
        write_data  : in  std_logic_vector(7 downto 0);     -- 8-bit write data (shared)
        reset       : in  std_logic;                        -- Reset signal
        chip_enable : in  std_logic_vector(3 downto 0);     -- 4-bit chip enable, one for each cache cell
        read_data_3 : out std_logic_vector(7 downto 0);     -- 8-bit read data output for cell 3
        read_data_2 : out std_logic_vector(7 downto 0);     -- 8-bit read data output for cell 2
        read_data_1 : out std_logic_vector(7 downto 0);     -- 8-bit read data output for cell 1
        read_data_0 : out std_logic_vector(7 downto 0)      -- 8-bit read data output for cell 0
    );
end entity cache_vector_8bit;

architecture structural of cache_vector_8bit is
    component cache_cell_8bit is
        port (
            write_data  : in  std_logic_vector(7 downto 0);   -- 8-bit write data
            reset       : in  std_logic;                       -- Reset input for each cache cell
            chip_enable : in  std_logic;                       -- 1-bit chip enable
            RW          : in  std_logic;                       -- 1-bit Read/Write
            read_data   : out std_logic_vector(7 downto 0)     -- 8-bit read data
        );
    end component cache_cell_8bit;

    -- Instantiate four cache_cell_8bit components with unique chip_enable and read_data
    for cache_0, cache_1, cache_2, cache_3: cache_cell_8bit use entity work.cache_cell_8bit(structural);

begin
    -- Map each cache cell to its respective chip enable, read data output, and reset signal
    cache_0: cache_cell_8bit
    port map (
        write_data  => write_data,                          -- Shared write data
        reset       => reset,                               -- Shared reset signal
        chip_enable => chip_enable(0),                      -- Unique chip enable for cache cell 0
        RW          => RW,                                  -- Shared Read/Write
        read_data   => read_data_0                          -- Unique read data output for cache cell 0
    );

    cache_1: cache_cell_8bit
    port map (
        write_data  => write_data,                          -- Shared write data
        reset       => reset,                               -- Shared reset signal
        chip_enable => chip_enable(1),                      -- Unique chip enable for cache cell 1
        RW          => RW,                                  -- Shared Read/Write
        read_data   => read_data_1                          -- Unique read data output for cache cell 1
    );

    cache_2: cache_cell_8bit
    port map (
        write_data  => write_data,                          -- Shared write data
        reset       => reset,                               -- Shared reset signal
        chip_enable => chip_enable(2),                      -- Unique chip enable for cache cell 2
        RW          => RW,                                  -- Shared Read/Write
        read_data   => read_data_2                          -- Unique read data output for cache cell 2
    );

    cache_3: cache_cell_8bit
    port map (
        write_data  => write_data,                          -- Shared write data
        reset       => reset,                               -- Shared reset signal
        chip_enable => chip_enable(3),                      -- Unique chip enable for cache cell 3
        RW          => RW,                                  -- Shared Read/Write
        read_data   => read_data_3                          -- Unique read data output for cache cell 3
    );

end architecture structural;

