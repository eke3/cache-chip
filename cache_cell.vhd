-- Entity: cache_cell
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity cache_cell is
    port (
        write_data  : in  std_logic;
        chip_enable : in  std_logic;
        RW          : in  std_logic;
        read_data   : out std_logic
    );

end entity cache_cell;

architecture structural of cache_cell is
    component Dlatch is
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component Dlatch;

    component selector is
        port (
            chip_enable  : in  std_logic;
            RW           : in  std_logic;
            read_enable  : out std_logic;
            write_enable : out std_logic
        );
    end component selector;

    component tx is
        port (
            sel    : in  std_logic;
            selnot : in  std_logic;
            input  : in  std_logic;
            output : out std_logic
        );
    end component tx;

    for d_latch: Dlatch use entity work.Dlatch(structural);
    for selector_inst: selector use entity work.selector(structural);
    for tx_inst: tx use entity work.tx(structural);

    signal q               : std_logic;
    signal write_enable, read_enable : std_logic;
    signal q_inv                     : std_logic;

begin
    selector_inst: component selector
    port map (
        chip_enable,
        RW,
        read_enable,
        write_enable
    );
    d_latch: component Dlatch
    port map (
        write_data,
        write_enable,
        q, 
        q_inv
    );
    tx_inst: component tx
    port map (
        read_enable,
        write_enable,
        q,
        read_data
    );

end architecture structural;
