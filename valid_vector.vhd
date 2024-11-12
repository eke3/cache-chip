library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity valid_vector is
    port (
        write_data  : in  STD_LOGIC; -- Shared write data for all cells
        reset       : in  STD_LOGIC; -- Shared reset signal for all cells
        chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
        RW          : in  STD_LOGIC; -- Shared Read/Write signal for all cells
        read_data_3 : out STD_LOGIC; -- Read data output for cell 3
        read_data_2 : out STD_LOGIC; -- Read data output for cell 2
        read_data_1 : out STD_LOGIC; -- Read data output for cell 1
        read_data_0 : out STD_LOGIC -- Read data output for cell 0
    );
end entity valid_vector;

architecture Structural of valid_vector is
    -- Declare the valid_cell component
    component valid_cell is
        port (
            write_data  : in  STD_LOGIC;
            reset       : in  STD_LOGIC;
            chip_enable : in  STD_LOGIC;
            RW          : in  STD_LOGIC;
            read_data   : out STD_LOGIC
        );
    end component valid_cell;

    for cell_0, cell_1, cell_2, cell_3: valid_cell use entity work.valid_cell(structural);

begin
    -- Instantiate each valid_cell and connect signals as required
    cell_0: component valid_cell
    port map (
        write_data  => write_data,     -- Shared write data
        reset       => reset,          -- Shared reset signal
        chip_enable => chip_enable(0), -- Unique chip enable for cell 0
        RW          => RW,             -- Shared Read/Write signal
        read_data   => read_data_0     -- Unique read data output for cell 0
    );

    cell_1: component valid_cell
    port map (
        write_data  => write_data,     -- Shared write data
        reset       => reset,          -- Shared reset signal
        chip_enable => chip_enable(1), -- Unique chip enable for cell 1
        RW          => RW,             -- Shared Read/Write signal
        read_data   => read_data_1     -- Unique read data output for cell 1
    );

    cell_2: component valid_cell
    port map (
        write_data  => write_data,     -- Shared write data
        reset       => reset,          -- Shared reset signal
        chip_enable => chip_enable(2), -- Unique chip enable for cell 2
        RW          => RW,             -- Shared Read/Write signal
        read_data   => read_data_2     -- Unique read data output for cell 2
    );

    cell_3: component valid_cell
    port map (
        write_data  => write_data,     -- Shared write data
        reset       => reset,          -- Shared reset signal
        chip_enable => chip_enable(3), -- Unique chip enable for cell 3
        RW          => RW,             -- Shared Read/Write signal
        read_data   => read_data_3     -- Unique read data output for cell 3
    );

end architecture Structural;
