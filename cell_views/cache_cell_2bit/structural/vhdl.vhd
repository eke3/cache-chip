-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:59:32 2024


architecture Structural of cache_cell_2bit is

    component cache_cell 
        port (
            write_data  : in  std_logic;
            chip_enable : in  std_logic;
            RW          : in  std_logic;
            read_data   : out std_logic
        );
    end component;

    for all: cache_cell use entity work.cache_cell(Structural);

begin

    cache_cell_inst_0: cache_cell
    port map (
        write_data(0),
        chip_enable,
        RW,
        read_data(0)
    );

    cache_cell_inst_1: cache_cell
    port map (
        write_data(1),
        chip_enable,
        RW,
        read_data(1)
    );

end Structural;
