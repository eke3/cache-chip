-- Entity: tag_vector
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tag_vector is
    port (
        write_data  : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit shared write data
        chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
        RW          : in  STD_LOGIC; -- Shared Read/Write signal for all cells
        sel         : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector for demux
        read_data   : out STD_LOGIC_VECTOR(1 downto 0) -- Read data output for cell 3
    );
end tag_vector;

architecture Structural of tag_vector is
    component mux_4x1_2bit 
        port (
            read_data0 : in  STD_LOGIC_VECTOR(1 downto 0);  -- Input 0
            read_data1 : in  STD_LOGIC_VECTOR(1 downto 0);  -- Input 1
            read_data2 : in  STD_LOGIC_VECTOR(1 downto 0);  -- Input 2
            read_data3 : in  STD_LOGIC_VECTOR(1 downto 0);  -- Input 3
            sel        : in  STD_LOGIC_VECTOR(1 downto 0);  -- 2-bit sel signal
            F          : out STD_LOGIC_VECTOR(1 downto 0)   -- Output of the multiplexer
        );
    end component;


    -- Declare the cache_cell_2bit component
    component cache_cell_2bit 
        port (
            write_data  : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit write data
            chip_enable : in  STD_LOGIC;                    -- 1-bit chip enable
            RW          : in  STD_LOGIC;                    -- 1-bit Read/Write
            read_data   : out STD_LOGIC_VECTOR(1 downto 0)  -- 2-bit read data
        );
    end component;

    -- Declare the demux_1x4_2bit component
    component demux_1x4_2bit 
        port (
            data_in    : in  STD_LOGIC_VECTOR(1 downto 0);  -- 2-bit input data
            sel        : in  STD_LOGIC_VECTOR(1 downto 0);  -- 2-bit selector
            data_out_3 : out STD_LOGIC_VECTOR(1 downto 0);  -- Output for selection "11"
            data_out_2 : out STD_LOGIC_VECTOR(1 downto 0);  -- Output for selection "10"
            data_out_1 : out STD_LOGIC_VECTOR(1 downto 0);  -- Output for selection "01"
            data_out_0 : out STD_LOGIC_VECTOR(1 downto 0)   -- Output for selection "00"
        );
    end component;

    for all: mux_4x1_2bit use entity work.mux_4x1_2bit(Structural);
    for all: cache_cell_2bit use entity work.cache_cell_2bit(Structural);
    for all: demux_1x4_2bit use entity work.demux_1x4_2bit(Structural);

    -- Internal signals for the demux outputs
    signal demux_out_3, demux_out_2, demux_out_1, demux_out_0 : STD_LOGIC_VECTOR(1 downto 0);
    signal read_data_3, read_data_0, read_data_1, read_data_2 : STD_LOGIC_VECTOR(1 downto 0);

begin

    mux: mux_4x1_2bit
    port map (
        read_data0  => read_data_0,
        read_data1  => read_data_1,
        read_data2  => read_data_2,
        read_data3  => read_data_3,
        sel         => sel,
        F           => read_data
    );
    -- Instantiate the demux_1x4_2bit and connect the shared write_data and sel
    demux_inst: demux_1x4_2bit
    port map (
        data_in     => write_data,                          -- Shared write data input
        sel         => sel,                                 -- 2-bit selector input
        data_out_3  => demux_out_3,                         -- Output connected to cache_cell_3's write_data
        data_out_2  => demux_out_2,                         -- Output connected to cache_cell_2's write_data
        data_out_1  => demux_out_1,                         -- Output connected to cache_cell_1's write_data
        data_out_0  => demux_out_0                          -- Output connected to cache_cell_0's write_data
    );

    -- Instantiate each cache_cell_2bit and connect signals as required
    cache_0: cache_cell_2bit
    port map (
        write_data  => demux_out_0,                         -- Demux output for cache cell 0
        chip_enable => chip_enable(0),                      -- Unique chip enable for cache cell 0
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_0                          -- Unique read data output for cache cell 0
    );

    cache_1: cache_cell_2bit
    port map (
        write_data  => demux_out_1,                         -- Demux output for cache cell 1
        chip_enable => chip_enable(1),                      -- Unique chip enable for cache cell 1
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_1                          -- Unique read data output for cache cell 1
    );

    cache_2: cache_cell_2bit
    port map (
        write_data  => demux_out_2,                         -- Demux output for cache cell 2
        chip_enable => chip_enable(2),                      -- Unique chip enable for cache cell 2
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_2                          -- Unique read data output for cache cell 2
    );

    cache_3: cache_cell_2bit
    port map (
        write_data  => demux_out_3,                         -- Demux output for cache cell 3
        chip_enable => chip_enable(3),                      -- Unique chip enable for cache cell 3
        RW          => RW,                                  -- Shared Read/Write signal
        read_data   => read_data_3                          -- Unique read data output for cache cell 3
    );

end Structural;
