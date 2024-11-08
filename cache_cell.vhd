-- Entity: cache_cell
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell is
    port(   write_data      : in std_logic;
            chip_enable    : in std_logic;
            RW              : in std_logic;
            read_data       : out std_logic);

end cache_cell;

architecture structural of cache_cell is
    component Dlatch
        port(   d   : in std_logic;
                clk : in std_logic;
                q   : out std_logic;
                qbar: out std_logic);
     end component;

    component selector
        port(   chip_enable : in std_logic;
                RW          : in std_logic;
                read_enable : out std_logic;
                write_enable: out std_logic);
    end component;

    component tx
        port(   sel   : in std_logic;
                selnot: in std_logic;
                input : in std_logic;
                output:out std_logic);
    end component;

    for Dlatch: Dlatch use entity work.Dlatch(structural);
    for selector: selector use entity work.selector(structural);
    for tx: tx use entity work.tx(structural);

    signal tx_data_in : std_logic;
    signal write_enable, read_enable : std_logic;

begin
    selector: selector port map (chip_enable, RW, read_enable, write_enable);
    Dlatch: Dlatch port map (write_data, write_enable, tx_data_in, tx_selnot_in);
    tx: tx port map (read_enable, write_enable, tx_data_in, read_data);    

end structural;