-- Entity: cache_cell_2bit
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell_2bit is
    port (
        write_data  : in  std_logic_vector(1 downto 0);
        chip_enable : in  std_logic;
        RW          : in  std_logic;
        read_data   : out std_logic_vector(1 downto 0)
    );
end entity cache_cell_2bit;

architecture Structural of cache_cell_2bit is
    component cache_cell is
        port (
            write_data  : in  std_logic;
            chip_enable : in  std_logic;
            RW          : in  std_logic;
            read_data   : out std_logic
        );
    end component cache_cell;

begin

    gen_cache_cells: for i in 0 to 1 generate
        cache_cell_inst: entity work.cache_cell(Structural)
        port map (
            write_data(i),
            chip_enable,
            RW,
            read_data(i)
        );
    end generate;

end architecture Structural;
