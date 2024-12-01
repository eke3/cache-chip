-- Entity: block_cache
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.std_logic_1164.all;

entity block_cache is
    port (
        write_cache  : in  std_logic_vector(7 downto 0);
        hit_miss     : in  std_logic;
        R_W          : in  std_logic;
        byte_offset  : in  std_logic_vector(3 downto 0);
        block_offset : in  std_logic_vector(3 downto 0);
        read_data    : out std_logic_vector(7 downto 0)
    );
end entity block_cache;

architecture Structural of block_cache is

    component cache_cell_8bit is
        port (
            write_data  : in  std_logic_vector(7 downto 0);
            chip_enable : in  std_logic;
            RW          : in  std_logic;
            read_data   : out std_logic_vector(7 downto 0)
        );
    end component cache_cell_8bit;

    component demux_1x16_8bit is
        port (
            data_in     : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input data
            sel         : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit selector (S3, S2, S1, S0)
            data_out_0  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0000"
            data_out_1  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0001"
            data_out_2  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0010"
            data_out_3  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0011"
            data_out_4  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0100"
            data_out_5  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0101"
            data_out_6  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0110"
            data_out_7  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "0111"
            data_out_8  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1000"
            data_out_9  : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1001"
            data_out_10 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1010"
            data_out_11 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1011"
            data_out_12 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1100"
            data_out_13 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1101"
            data_out_14 : out STD_LOGIC_VECTOR(7 downto 0); -- Output for selection "1110"
            data_out_15 : out STD_LOGIC_VECTOR(7 downto 0)  -- Output for selection "1111"
        );
    end component demux_1x16_8bit;

    component mux_16x1_8bit is
        port (
            inputs   : in  STD_LOGIC_VECTOR(127 downto 0);  -- 16 inputs, each 8-bit wide
            sel      : in  STD_LOGIC_VECTOR(15 downto 0);   -- 16-bit 1-hot select signal
            sel_4bit : in  std_logic_vector(3 downto 0);
            output   : out STD_LOGIC_VECTOR(7 downto 0)     -- 8-bit output
        );
    end component mux_16x1_8bit;

    component and_3x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_3x1;

    component one_hot_to_binary is
        port (
            one_hot : in  STD_LOGIC_VECTOR(3 downto 0);     -- One-hot encoded input
            binary  : out STD_LOGIC_VECTOR(1 downto 0)      -- 2-bit binary output
        );
    end component one_hot_to_binary;

    component nand_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component nand_2x1;

    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    component tx_8bit is
        port (
            sel    : in  std_logic;                         -- Selector signal
            selnot : in  std_logic;                         -- Inverted selector signal
            input  : in  STD_LOGIC_VECTOR(7 downto 0);
            output : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component tx_8bit;

    signal CE                          : std_logic_vector(15 downto 0);
    signal demux_out                   : std_logic_vector(127 downto 0);
    signal read_array                  : std_logic_vector(127 downto 0);
    signal comb_addr                   : std_logic_vector(3 downto 0);
    signal block_off_bin, byte_off_bin : std_logic_vector(1 downto 0);
    signal cache_RW                    : std_logic;
    signal RW_not, RW_nand_out         : std_logic;
    signal read_out                    : std_logic_vector(7 downto 0);
    signal not_hit_miss                : std_logic;

begin

    hit_miss_inverter: entity work.inverter(Structural)
    port map (
        input           => hit_miss,
        output          => not_hit_miss
    );

    rw_inverter: entity work.inverter(Structural)
    port map (
        input           => R_W,
        output          => RW_not
    );

    rw_nand: entity work.nand_2x1(Structural)
    port map (
        A               => RW_not,
        B               => hit_miss,
        output          => RW_nand_out
    );

    gen_cell_1: for i in 0 to 3 generate
        and_1: entity work.and_3x1(Structural)
        port map (
            A           => block_offset(0),
            B           => byte_offset(i),
            C           => hit_miss,
            output      => CE(15 - (i * 1))
        );
    end generate;

    gen_cell_2: for i in 0 to 3 generate
        and_2: entity work.and_3x1(Structural)
        port map (
            A           => block_offset(1),
            B           => byte_offset(i),
            C           => hit_miss,
            output      => CE(11 - (i * 1))
        );
    end generate;

    gen_cell_3: for i in 0 to 3 generate
        and_3: entity work.and_3x1(Structural)
        port map (
            A           => block_offset(2),
            B           => byte_offset(i),
            C           => hit_miss,
            output      => CE(7 - (i * 1))
        );
    end generate;

    gen_cell_4: for i in 0 to 3 generate
        and_4: entity work.and_3x1(Structural)
        port map (
            A           => block_offset(3),
            B           => byte_offset(i),
            C           => hit_miss,
            output      => CE(3 - (i * 1))
        );
    end generate;

    gen_cell_5: for i in 0 to 3 generate
        block_cell_1: entity work.cache_cell_8bit(Structural)
        port map (
            write_data  => demux_out(127 - (8 * i) downto 127 - (8 * i) - 7),
            chip_enable => CE(15 - ((i) * 1)),
            RW          => RW_nand_out,
            read_data   => read_array(127 - (8 * i) downto 127 - (8 * i) - 7)
        );
    end generate;

    gen_cell_6: for i in 0 to 3 generate
        block_cell_2: entity work.cache_cell_8bit(Structural)
        port map (
            write_data  => demux_out(95 - (8 * i) downto 95 - (8 * i) - 7),
            chip_enable => CE(11 - ((i) * 1)),
            RW          => RW_nand_out,
            read_data   => read_array(95 - (8 * i) downto 95 - (8 * i) - 7)
        );
    end generate;

    gen_cell_7: for i in 0 to 3 generate
        block_cell_3: entity work.cache_cell_8bit(Structural)
        port map (
            write_data  => demux_out(63 - (8 * i) downto 63 - (8 * i) - 7),
            chip_enable => CE(7 - ((i) * 1)),
            RW          => RW_nand_out,
            read_data   => read_array(63 - (8 * i) downto 63 - (8 * i) - 7)
        );
    end generate;

    gen_cell_8: for i in 0 to 3 generate
        block_cell_4: entity work.cache_cell_8bit(Structural)
        port map (
            write_data  => demux_out(31 - (8 * i) downto 31 - (8 * i) - 7),
            chip_enable => CE(3 - ((i) * 1)),
            RW          => RW_nand_out,
            read_data   => read_array(31 - (8 * i) downto 31 - (8 * i) - 7)
        );
    end generate;

    demux: entity work.demux_1x16_8bit(Structural)
    port map (
        data_in         => write_cache,
        sel             => comb_addr,
        data_out_0      => demux_out(127 downto 120),
        data_out_1      => demux_out(119 downto 112),
        data_out_2      => demux_out(111 downto 104),
        data_out_3      => demux_out(103 downto 96),
        data_out_4      => demux_out(95 downto 88),
        data_out_5      => demux_out(87 downto 80),
        data_out_6      => demux_out(79 downto 72),
        data_out_7      => demux_out(71 downto 64),
        data_out_8      => demux_out(63 downto 56),
        data_out_9      => demux_out(55 downto 48),
        data_out_10     => demux_out(47 downto 40),
        data_out_11     => demux_out(39 downto 32),
        data_out_12     => demux_out(31 downto 24),
        data_out_13     => demux_out(23 downto 16),
        data_out_14     => demux_out(15 downto 8),
        data_out_15     => demux_out(7 downto 0)
    );

    mux: entity work.mux_16x1_8bit(Structural)
    port map (
        inputs          => read_array,
        sel             => CE,
        sel_4bit        => comb_addr,
        output          => read_out
    );

    convert_1: entity work.one_hot_to_binary(Structural)
    port map (
        one_hot         => block_offset,
        binary          => block_off_bin
    );

    convert_2: entity work.one_hot_to_binary(Structural)
    port map (
        one_hot         => byte_offset,
        binary          => byte_off_bin
    );

    output_tx: entity work.tx_8bit(Structural)
    port map (
        sel             => hit_miss,
        selnot          => not_hit_miss,
        input           => read_out,
        output          => read_data
    );

    comb_addr(3 downto 2) <= block_off_bin;
    comb_addr(1 downto 0) <= byte_off_bin;

end architecture Structural;
