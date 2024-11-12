-- Entity: cache_cell_2bit
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell_2bit is
    port(   write_data      : in std_logic_vector(1 downto 0);
            chip_enable     : in std_logic;
            RW              : in std_logic;
            read_data       : out std_logic_vector(1 downto 0));
end cache_cell_2bit;

architecture structural of cache_cell_2bit is
    component cache_cell
        port(   write_data      : in std_logic;
                chip_enable     : in std_logic;
                RW              : in std_logic;
                read_data       : out std_logic);
    end component;

    -- Instantiate two cache_cell components, one for each bit
    for cache_0, cache_1: cache_cell use entity work.cache_cell(structural);

begin
    
    cache_0: cache_cell port map (write_data(0), chip_enable, RW, read_data(0));
    cache_1: cache_cell port map (write_data(1), chip_enable, RW, read_data(1));

end structural;
