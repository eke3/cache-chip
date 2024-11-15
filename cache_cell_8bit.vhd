-- Entity: cache_cell_8bit
-- Architecture: structural
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
end entity cache_cell_8bit;

architecture structural of cache_cell_8bit is
    component cache_cell is
        port (
            write_data  : in  std_logic;
            chip_enable : in  std_logic;
            RW          : in  std_logic;
            read_data   : out std_logic
        );
    end component cache_cell;

    for cache_0, cache_1, cache_2, cache_3, cache_4, cache_5, cache_6, cache_7: cache_cell use entity work.cache_cell(structural);

begin

    cache_0: component cache_cell
    port map (
        write_data(0),
        chip_enable,
        RW,
        read_data(0)
    );
    cache_1: component cache_cell
    port map (
        write_data(1),
        chip_enable,
        RW,
        read_data(1)
    );
    cache_2: component cache_cell
    port map (
        write_data(2),
        chip_enable,
        RW,
        read_data(2)
    );
    cache_3: component cache_cell
    port map (
        write_data(3),
        chip_enable,
        RW,
        read_data(3)
    );
    cache_4: component cache_cell
    port map (
        write_data(4),
        chip_enable,
        RW,
        read_data(4)
    );
    cache_5: component cache_cell
    port map (
        write_data(5),
        chip_enable,
        RW,
        read_data(5)
    );
    cache_6: component cache_cell
    port map (
        write_data(6),
        chip_enable,
        RW,
        read_data(6)
    );
    cache_7: component cache_cell
    port map (
        write_data(7),
        chip_enable,
        RW,
        read_data(7)
    );

end architecture structural;
