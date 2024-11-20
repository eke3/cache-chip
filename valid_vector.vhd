-- Entity: valid_vector
-- Architecture: Structural

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity valid_vector is
    port (
        vdd         : in  STD_LOGIC; -- Power supply
        gnd         : in  STD_LOGIC; -- Ground
        write_data  : in  STD_LOGIC; -- Shared write data for demux
        reset       : in  STD_LOGIC; -- Shared reset signal for all cells
        chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
        RW          : in  STD_LOGIC; -- Shared Read/Write signal for all cells
        sel         : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector for demux, comes from decoder input
        read_data : out STD_LOGIC -- Read data output for cell 3
    );
end entity valid_vector;

architecture Structural of valid_vector is
    -- Declare the valid_cell component
    component valid_cell is
        port (
            vdd         : in  STD_LOGIC;
            gnd         : in  STD_LOGIC;
            write_data  : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            chip_enable : in  STD_LOGIC;
            RW          : in  STD_LOGIC;
            read_data   : out STD_LOGIC
        );
    end component valid_cell;

    -- Declare the demux_1x4 component
    component demux_1x4 is
        port (
            data_in    : in  STD_LOGIC;                    -- 1-bit input
            sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector
            data_out_3 : out STD_LOGIC;                    -- Output for selection "11"
            data_out_2 : out STD_LOGIC;                    -- Output for selection "10"
            data_out_1 : out STD_LOGIC;                    -- Output for selection "01"
            data_out_0 : out STD_LOGIC                     -- Output for selection "00"
        );
    end component demux_1x4;

    component mux_4x1 is
        port (
            read_data0 : in  STD_LOGIC; -- Input 0
            read_data1 : in  STD_LOGIC; -- Input 1
            read_data2 : in  STD_LOGIC; -- Input 2
            read_data3 : in  STD_LOGIC; -- Input 3
            sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit sel signal
            F          : out STD_LOGIC -- Output of the multiplexer
        );
    end component mux_4x1;

    -- Internal signals for demux outputs
    signal demux_out_0, demux_out_1, demux_out_2, demux_out_3 : STD_LOGIC;
    signal read_data_0, read_data_1, read_data_2, read_data_3 : STD_LOGIC;
    signal outline : std_logic; 

    for demux: demux_1x4 use entity work.demux_1x4(structural);
    for cell_0, cell_1, cell_2, cell_3: valid_cell use entity work.valid_cell(structural);
    for mux: mux_4x1 use entity work.mux_4x1(structural);

begin
    -- get only the output you want
    mux: component mux_4x1
     port map(
        read_data0 => read_data_0,
        read_data1 => read_data_1,
        read_data2 => read_data_2,
        read_data3 => read_data_3,
        sel => sel,
        F => outline
    );

    -- Instantiate the demux_1x4 and connect the shared write_data and sel
    demux: component demux_1x4
    port map (
        data_in     => write_data,                         -- Shared write data input
        sel         => sel,                                -- 2-bit selector input
        data_out_0  => demux_out_0,                        -- Output connected to cell_0's write_data
        data_out_1  => demux_out_1,                        -- Output connected to cell_1's write_data
        data_out_2  => demux_out_2,                        -- Output connected to cell_2's write_data
        data_out_3  => demux_out_3                         -- Output connected to cell_3's write_data
    );

    -- Instantiate each valid_cell and connect signals as required
    cell_0: component valid_cell
    port map (
        vdd => vdd,
        gnd => gnd,
        write_data  => demux_out_0,                        -- Demux output for cell 0
        reset       => reset,                              -- Shared reset signal
        chip_enable => chip_enable(0),                     -- Unique chip enable for cell 0
        RW          => RW,                                 -- Shared Read/Write signal
        read_data   => read_data_0                         -- Unique read data output for cell 0
    );

    cell_1: component valid_cell
    port map (
        vdd => vdd,
        gnd => gnd,
        write_data  => demux_out_1,                        -- Demux output for cell 1
        reset       => reset,                              -- Shared reset signal
        chip_enable => chip_enable(1),                     -- Unique chip enable for cell 1
        RW          => RW,                                 -- Shared Read/Write signal
        read_data   => read_data_1                         -- Unique read data output for cell 1
    );

    cell_2: component valid_cell
    port map (
        vdd => vdd,
        gnd => gnd,
        write_data  => demux_out_2,                        -- Demux output for cell 2
        reset       => reset,                              -- Shared reset signal
        chip_enable => chip_enable(2),                     -- Unique chip enable for cell 2
        RW          => RW,                                 -- Shared Read/Write signal
        read_data   => read_data_2                         -- Unique read data output for cell 2
    );

    cell_3: component valid_cell
    port map (
        vdd => vdd,
        gnd => gnd,
        write_data  => demux_out_3,                        -- Demux output for cell 3
        reset       => reset,                              -- Shared reset signal
        chip_enable => chip_enable(3),                     -- Unique chip enable for cell 3
        RW          => RW,                                 -- Shared Read/Write signal
        read_data   => read_data_3                         -- Unique read data output for cell 3
    );
    
    read_data <= outline;
end architecture Structural;
