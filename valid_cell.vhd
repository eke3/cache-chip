-- Entity: valid_cell
-- cells for valid vector

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity valid_cell is
    port (
        write_data  : in  STD_LOGIC;
        reset       : in  STD_LOGIC;
        chip_enable : in  STD_LOGIC;
        RW          : in  STD_LOGIC;
        read_data   : out STD_LOGIC
    );
end entity valid_cell;

architecture Structural of valid_cell is
    component cache_cell is
        port (
            write_data  : in  std_logic; -- 1-bit write data
            reset : in std_logic;
            chip_enable : in  std_logic; -- 1-bit chip enable
            RW          : in  std_logic; -- 1-bit Read/Write signal
            read_data   : out std_logic  -- 1-bit read data
        );
    end component cache_cell;

    -- Declare the mux_2x1 component
    component mux_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            sel    : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component mux_2x1;

    -- Declare the inverter component
    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    signal sel_not, reset_not, write_data_mux_out, rw_mux_out : STD_LOGIC;

    for sel_inverter, reset_inverter: inverter use entity work.inverter(structural);
    for write_data_mux, rw_mux: mux_2x1 use entity work.mux_2x1(structural);
    for cache_cell_inst: cache_cell use entity work.cache_cell(structural);

begin

    -- Instantiate the inverter to generate sel_not signal
    sel_inverter: component inverter
    port map (
        input       => sel,
        output      => sel_not
    );

    -- Instantiate the inverter to generate reset_not signal
    reset_inverter: component inverter
    port map (
        input       => reset,
        output      => reset_not
    );

    write_data_mux: component mux_2x1
    port map (
        A           => write_data,
        B           => reset_not,
        sel         => reset,
        output      => write_data_mux_out
    );

    rw_mux: component mux_2x1
    port map (
        A           => RW,
        B           => reset_not,
        sel         => reset,
        output      => rw_mux_out
    );

    cache_cell_inst: component cache_cell
    port map (
        write_data  => write_data_mux_out,
        chip_enable => chip_enable,
        RW          => rw_mux_out,
        reset => reset,
        read_data   => read_data
    );

end architecture Structural;
