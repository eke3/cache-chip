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
        read_data   : out STD_LOGIC -- Read data output for cell 3
    );
end valid_vector;

architecture Structural of valid_vector is
    -- Declare the valid_cell component
    component valid_cell 
        port (
            vdd         : in  STD_LOGIC;
            gnd         : in  STD_LOGIC;
            write_data  : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            chip_enable : in  STD_LOGIC;
            RW          : in  STD_LOGIC;
            read_data   : out STD_LOGIC
        );
    end component;

    -- Declare the demux_1x4 component
    component demux_1x4 
        port (
            data_in    : in  STD_LOGIC;                    -- 1-bit input
            sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector
            data_out_3 : out STD_LOGIC;                    -- Output for selection "11"
            data_out_2 : out STD_LOGIC;                    -- Output for selection "10"
            data_out_1 : out STD_LOGIC;                    -- Output for selection "01"
            data_out_0 : out STD_LOGIC                     -- Output for selection "00"
        );
    end component;

    component mux_4x1 
        port (
            read_data0 : in  STD_LOGIC;                    -- Input 0
            read_data1 : in  STD_LOGIC;                    -- Input 1
            read_data2 : in  STD_LOGIC;                    -- Input 2
            read_data3 : in  STD_LOGIC;                    -- Input 3
            sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit sel signal
            F          : out STD_LOGIC                     -- Output of the multiplexer
        );
    end component;

    for all: valid_cell use entity work.valid_cell(Structural);
    for all: demux_1x4 use entity work.demux_1x4(Structural);
    for all: mux_4x1 use entity work.mux_4x1(Structural);

    -- Internal signals for demux outputs
    signal demux_out      : STD_LOGIC_VECTOR(3 downto 0);
    signal read_valid_out : STD_LOGIC_VECTOR(3 downto 0);
    signal read_data_out  : std_logic;

begin

    -- Instantiate the demux_1x4 and connect the shared write_data and sel
    demux: demux_1x4
    port map (
        data_in         => write_data,                     -- Shared write data input
        sel             => sel,                            -- 2-bit selector input
        data_out_0      => demux_out(0),                   -- Output connected to cell_0's write_data
        data_out_1      => demux_out(1),                   -- Output connected to cell_1's write_data
        data_out_2      => demux_out(2),                   -- Output connected to cell_2's write_data
        data_out_3      => demux_out(3)                    -- Output connected to cell_3's write_data
    );

    -- Instantiate each valid_cell and connect signals as required
    gen_valid_cells: for i in 0 to 3 generate
        cell: valid_cell
        port map (
            vdd         => vdd,
            gnd         => gnd,
            write_data  => demux_out(i),                   -- Demux output for cell i
            reset       => reset,                          -- Shared reset signal
            chip_enable => chip_enable(i),                 -- Unique chip enable for cell i
            RW          => RW,                             -- Shared Read/Write signal
            read_data   => read_valid_out(i)               -- Unique read data output for cell i
        );
    end generate;

    -- get only the output you want
    mux: mux_4x1
    port map (
        read_data0      => read_valid_out(0),
        read_data1      => read_valid_out(1),
        read_data2      => read_valid_out(2),
        read_data3      => read_valid_out(3),
        sel             => sel,
        F               => read_data_out
    );

    read_data <= read_data_out;

end Structural;
