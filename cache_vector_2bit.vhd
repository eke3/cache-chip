-- Entity: cache_vector_2bit
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity cache_vector_2bit is
    port (
        RW          : in  std_logic; -- 1-bit Read/Write signal (shared)
        write_data  : in  std_logic_vector(1 downto 0); -- 2-bit write data (shared)
        reset       : in  std_logic; -- Shared reset signal
        chip_enable : in  std_logic_vector(3 downto 0); -- 4-bit chip enable, one for each cache cell
        sel         : in  std_logic_vector(1 downto 0); -- 2-bit selector for demux
        read_data_3 : out std_logic_vector(1 downto 0); -- 2-bit read data output for cell 3
        read_data_2 : out std_logic_vector(1 downto 0); -- 2-bit read data output for cell 2
        read_data_1 : out std_logic_vector(1 downto 0); -- 2-bit read data output for cell 1
        read_data_0 : out std_logic_vector(1 downto 0) -- 2-bit read data output for cell 0
    );
end entity cache_vector_2bit;

architecture structural of cache_vector_2bit is
    -- Declare the cache_cell_2bit component
    component cache_cell_2bit is
        port (
            write_data  : in  std_logic_vector(1 downto 0); -- 2-bit write data
            reset       : in  std_logic;                    -- Reset input
            chip_enable : in  std_logic;                    -- 1-bit chip enable
            RW          : in  std_logic;                    -- 1-bit Read/Write
            read_data   : out std_logic_vector(1 downto 0)  -- 2-bit read data
        );
    end component cache_cell_2bit;

    -- Declare the demux_1x4_2bit component
    component demux_1x4_2bit is
        port (
            data_in    : in  std_logic_vector(1 downto 0);  -- 2-bit input data
            sel        : in  std_logic_vector(1 downto 0);  -- 2-bit selector
            data_out_3 : out std_logic_vector(1 downto 0);  -- Output for selection "11"
            data_out_2 : out std_logic_vector(1 downto 0);  -- Output for selection "10"
            data_out_1 : out std_logic_vector(1 downto 0);  -- Output for selection "01"
            data_out_0 : out std_logic_vector(1 downto 0)   -- Output for selection "00"
        );
    end component demux_1x4_2bit;

    -- Internal signals for demux outputs
    signal demux_out_0, demux_out_1, demux_out_2, demux_out_3 : std_logic_vector(1 downto 0);

    for cache_0, cache_1, cache_2, cache_3, cache_4: cache_cell_2bit use entity work.cache_cell_2bit(structural);
    for demux: demux_1x4_2bit use entity work.demux_1x4_2bit(structural);

begin
    -- Instantiate the demux_1x4_2bit to route write_data based on sel
    demux: component demux_1x4_2bit
    port map (
        data_in     => write_data,                          -- Shared 2-bit write data
        sel         => sel,                                 -- 2-bit selector input
        data_out_0  => demux_out_0,                         -- Demux output for cell 0
        data_out_1  => demux_out_1,                         -- Demux output for cell 1
        data_out_2  => demux_out_2,                         -- Demux output for cell 2
        data_out_3  => demux_out_3                          -- Demux output for cell 3
    );

    -- Instantiate each cache_cell_2bit and connect signals as required
    cache_0: component cache_cell_2bit
    port map (
        write_data  => demux_out_0,                         -- Demux output for cell 0
        reset       => reset,                               -- Shared reset signal
        chip_enable => chip_enable(0),                      -- Unique chip enable for cell 0
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_0                          -- Unique read data output for cell 0
    );

    cache_1: component cache_cell_2bit
    port map (
        write_data  => demux_out_1,                         -- Demux output for cell 1
        reset       => reset,                               -- Shared reset signal
        chip_enable => chip_enable(1),                      -- Unique chip enable for cell 1
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_1                          -- Unique read data output for cell 1
    );

    cache_2: component cache_cell_2bit
    port map (
        write_data  => demux_out_2,                         -- Demux output for cell 2
        reset       => reset,                               -- Shared reset signal
        chip_enable => chip_enable(2),                      -- Unique chip enable for cell 2
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_2                          -- Unique read data output for cell 2
    );

    cache_3: component cache_cell_2bit
    port map (
        write_data  => demux_out_3,                         -- Demux output for cell 3
        reset       => reset,                               -- Shared reset signal
        chip_enable => chip_enable(3),                      -- Unique chip enable for cell 3
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_3                          -- Unique read data output for cell 3
    );

end architecture structural;
