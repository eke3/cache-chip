-- Entity: cache_cell
-- Architecture: Structural
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

end cache_cell;

architecture Structural of cache_cell is
    component d_latch
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;

    component selector
        port (
            chip_enable  : in  std_logic;
            RW           : in  std_logic;
            read_enable  : out std_logic;
            write_enable : out std_logic
        );
    end component;

    component tx
        port (
            sel    : in  std_logic;
            selnot : in  std_logic;
            input  : in  std_logic;
            output : out std_logic
        );
    end component;

    for all: d_latch use entity work.d_latch(Structural);
    for all: selector use entity work.selector(Structural);
    for all: tx use entity work.tx(Structural);

    signal q                         : std_logic;
    signal write_enable, read_enable : std_logic;
    signal q_inv                     : std_logic;

begin

    selector_inst: selector
    port map (
        chip_enable  => chip_enable,
        RW           => RW,
        read_enable  => read_enable,
        write_enable => write_enable
    );
    d_latch_inst: d_latch
    port map (
        d            => write_data,
        clk          => write_enable,
        q            => q,
        qbar         => q_inv
    );
    tx_inst: tx
    port map (
        sel          => read_enable,
        selnot       => write_enable,
        input        => q,
        output       => read_data
    );

end Structural;
