-- Entity: cache_cell_8bit
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell_8bit is
    port (
        write_data  : in  std_logic_vector(7 downto 0);
        chip_enable : in  std_logic;
        RW          : in  std_logic;
        read_data   : out std_logic_vector(7 downto 0)
    );
end cache_cell_8bit;

architecture Structural of cache_cell_8bit is

    component cache_cell_2bit 
        port (
            write_data  : in  std_logic_vector(1 downto 0);
            chip_enable : in  std_logic;
            RW          : in  std_logic;
            read_data   : out std_logic_vector(1 downto 0)
        );
    end component;

    for all: cache_cell_2bit use entity work.cache_cell_2bit(Structural);

begin

    gen_cache_cells: for i in 0 to 3 generate
        cache_cell_inst: cache_cell_2bit
        port map (
            write_data  => write_data((2 * i + 1) downto 2 * i),
            chip_enable => chip_enable,
            RW          => RW,
            read_data   => read_data((2 * i + 1) downto 2 * i)
        );
    end generate;

end Structural;
