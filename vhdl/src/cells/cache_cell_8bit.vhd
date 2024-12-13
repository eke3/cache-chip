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

    cache_cell_inst_0: cache_cell_2bit
    port map (
        write_data  => write_data(1 downto 0),
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(1 downto 0)
    );

    cache_cell_inst_1: cache_cell_2bit
    port map (
        write_data  => write_data(3 downto 2),
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(3 downto 2)
    );

    cache_cell_inst_2: cache_cell_2bit
    port map (
        write_data  => write_data(5 downto 4),
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(5 downto 4)
    );

    cache_cell_inst_3: cache_cell_2bit
    port map (
        write_data  => write_data(7 downto 6),
        chip_enable => chip_enable,
        RW          => RW,
        read_data   => read_data(7 downto 6)
    );

end Structural;
