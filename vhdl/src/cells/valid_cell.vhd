-- EEntity: valid_cell
-- Architecture: Structural

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity valid_cell is
    port (
        vdd         : in  std_logic;
        gnd         : in  std_logic;
        write_data  : in  std_logic; -- Write data input
        reset       : in  std_logic; -- Reset signal
        chip_enable : in  std_logic; -- Chip enable signal
        RW          : in  std_logic; -- Read/Write signal
        read_data   : out std_logic -- Read data output
    );
end valid_cell;

architecture Structural of valid_cell is
    -- Declare the cache_cell component
    component cache_cell 
        port (
            write_data  : in  std_logic;    -- 1-bit write data
            chip_enable : in  std_logic;    -- 1-bit chip enable
            RW          : in  std_logic;    -- 1-bit Read/Write signal
            read_data   : out std_logic     -- 1-bit read data
        );
    end component;

    -- Declare the mux_2x1 component for write_data, chip_enable, and RW
    component mux_2x1 
        port (
            A      : in  std_logic;         -- Input 0
            B      : in  std_logic;         -- Input 1
            sel    : in  std_logic;         -- sel signal
            output : out std_logic          -- Output of the multiplexer
        );
    end component;

    for all: cache_cell use entity work.cache_cell(Structural);
    for all: mux_2x1 use entity work.mux_2x1(Structural);

    -- Signals to wire the muxes
    signal mux_write_data_out  : std_logic; -- Output of the mux for write_data
    signal mux_chip_enable_out : std_logic; -- Output of the mux for chip_enable
    signal mux_rw_out          : std_logic; -- Output of the mux for RW
    signal outline             : std_logic;

begin

    -- Instantiate mux for write_data (pass 0 if reset = 1, otherwise pass write_data)
    mux_write_data: mux_2x1
    port map (
        A           => write_data,          -- When reset = 0, pass write_data
        B           => gnd,                 -- When reset = 1, pass 0
        sel         => reset,               -- sel is controlled by reset
        output      => mux_write_data_out   -- Output of the mux
    );

    -- Instantiate mux for chip_enable (pass 1 if reset = 1, otherwise pass chip_enable)
    mux_chip_enable: mux_2x1
    port map (
        A           => chip_enable,         -- When reset = 0, pass chip_enable
        B           => vdd,                 -- When reset = 1, pass 1
        sel         => reset,               -- sel is controlled by reset
        output      => mux_chip_enable_out  -- Output of the mux
    );

    -- Instantiate mux for RW (pass 0 if reset = 1, otherwise pass RW)
    mux_rw: mux_2x1
    port map (
        A           => RW,                  -- When reset = 0, pass RW
        B           => gnd,                 -- When reset = 1, pass 0
        sel         => reset,               -- sel is controlled by reset
        output      => mux_rw_out           -- Output of the mux
    );

    -- Instantiate the cache_cell component
    cache_cell_inst: cache_cell
    port map (
        write_data  => mux_write_data_out,  -- Connected to mux output
        chip_enable => mux_chip_enable_out, -- Connected to mux output
        RW          => mux_rw_out,          -- Connected to mux output
        read_data   => outline              -- Read data output
    );

    read_data <= outline;

end Structural;
