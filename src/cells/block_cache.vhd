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
end block_cache;

architecture Structural of block_cache is

    component cache_cell_8bit
        port (
            write_data  : in  std_logic_vector(7 downto 0);
            chip_enable : in  std_logic;
            RW          : in  std_logic;
            read_data   : out std_logic_vector(7 downto 0)
        );
    end component;

    component demux_1x16_8bit
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
    end component;

    component mux_16x1_8bit
        port (
            inputs   : in  STD_LOGIC_VECTOR(127 downto 0);  -- 16 inputs, each 8-bit wide
            sel      : in  STD_LOGIC_VECTOR(15 downto 0);   -- 16-bit 1-hot select signal
            output   : out STD_LOGIC_VECTOR(7 downto 0)     -- 8-bit output
        );
    end component;

    component and_3x1 
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component one_hot_to_binary 
        port (
            one_hot : in  STD_LOGIC_VECTOR(2 downto 0);     -- One-hot encoded input
            binary  : out STD_LOGIC_VECTOR(1 downto 0)      -- 2-bit binary output
        );
    end component;

    component nand_2x1 
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component inverter 
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component tx_8bit 
        port (
            sel    : in  std_logic;                         -- Selector signal
            selnot : in  std_logic;                         -- Inverted selector signal
            input  : in  STD_LOGIC_VECTOR(7 downto 0);
            output : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    for all: cache_cell_8bit use entity work.cache_cell_8bit(Structural);
    for all: demux_1x16_8bit use entity work.demux_1x16_8bit(Structural);
    for all: mux_16x1_8bit use entity work.mux_16x1_8bit(Structural);
    for all: and_3x1 use entity work.and_3x1(Structural);
    for all: one_hot_to_binary use entity work.one_hot_to_binary(Structural);
    for all: nand_2x1 use entity work.nand_2x1(Structural);
    for all: inverter use entity work.inverter(Structural);
    for all: tx_8bit use entity work.tx_8bit(Structural);

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

    hit_miss_inverter: inverter
    port map (
        input           => hit_miss,
        output          => not_hit_miss
    );

    rw_inverter: inverter
    port map (
        input           => R_W,
        output          => RW_not
    );

    rw_nand: nand_2x1
    port map (
        A               => RW_not,
        B               => hit_miss,
        output          => RW_nand_out
    );

    and_1: and_3x1
    port map (
        A           => block_offset(0),
        B           => byte_offset(0),
        C           => hit_miss,
        output      => CE(15)
    );

    and_2: and_3x1
    port map (
        A           => block_offset(0),
        B           => byte_offset(1),
        C           => hit_miss,
        output      => CE(14)
    );

    and_3: and_3x1
    port map (
        A           => block_offset(0),
        B           => byte_offset(2),
        C           => hit_miss,
        output      => CE(13)
    );

    and_4: and_3x1
    port map (
        A           => block_offset(0),
        B           => byte_offset(3),
        C           => hit_miss,
        output      => CE(12)
    );

    and_2_0: and_3x1
    port map (
        A           => block_offset(1),
        B           => byte_offset(0),
        C           => hit_miss,
        output      => CE(11)
    );

    and_2_1: and_3x1
    port map (
        A           => block_offset(1),
        B           => byte_offset(1),
        C           => hit_miss,
        output      => CE(10)
    );

    and_2_2: and_3x1
    port map (
        A           => block_offset(1),
        B           => byte_offset(2),
        C           => hit_miss,
        output      => CE(9)
    );

    and_2_3: and_3x1
    port map (
        A           => block_offset(1),
        B           => byte_offset(3),
        C           => hit_miss,
        output      => CE(8)
    );

    and_3_0: and_3x1
    port map (
        A           => block_offset(2),
        B           => byte_offset(0),
        C           => hit_miss,
        output      => CE(7)
    );

    and_3_1: and_3x1
    port map (
        A           => block_offset(2),
        B           => byte_offset(1),
        C           => hit_miss,
        output      => CE(6)
    );

    and_3_2: and_3x1
    port map (
        A           => block_offset(2),
        B           => byte_offset(2),
        C           => hit_miss,
        output      => CE(5)
    );

    and_3_3: and_3x1
    port map (
        A           => block_offset(2),
        B           => byte_offset(3),
        C           => hit_miss,
        output      => CE(4)
    );

    and_4_0: and_3x1
    port map (
        A           => block_offset(3),
        B           => byte_offset(0),
        C           => hit_miss,
        output      => CE(3)
    );

    and_4_1: and_3x1
    port map (
        A           => block_offset(3),
        B           => byte_offset(1),
        C           => hit_miss,
        output      => CE(2)
    );

    and_4_2: and_3x1
    port map (
        A           => block_offset(3),
        B           => byte_offset(2),
        C           => hit_miss,
        output      => CE(1)
    );

    and_4_3: and_3x1
    port map (
        A           => block_offset(3),
        B           => byte_offset(3),
        C           => hit_miss,
        output      => CE(0)
    );

    block_cell_1_0: cache_cell_8bit
    port map (
        write_data  => demux_out(127 downto 120),
        chip_enable => CE(15),
        RW          => RW_nand_out,
        read_data   => read_array(127 downto 120)
    );

    block_cell_1_1: cache_cell_8bit
    port map (
        write_data  => demux_out(119 downto 112),
        chip_enable => CE(14),
        RW          => RW_nand_out,
        read_data   => read_array(119 downto 112)
    );

    block_cell_1_2: cache_cell_8bit
    port map (
        write_data  => demux_out(111 downto 104),
        chip_enable => CE(13),
        RW          => RW_nand_out,
        read_data   => read_array(111 downto 104)
    );

    block_cell_1_3: cache_cell_8bit
    port map (
        write_data  => demux_out(103 downto 96),
        chip_enable => CE(12),
        RW          => RW_nand_out,
        read_data   => read_array(103 downto 96)
    );

    block_cell_2_0: cache_cell_8bit
    port map (
        write_data  => demux_out(95 downto 88),
        chip_enable => CE(11),
        RW          => RW_nand_out,
        read_data   => read_array(95 downto 88)
    );

    block_cell_2_1: cache_cell_8bit
    port map (
        write_data  => demux_out(87 downto 80),
        chip_enable => CE(10),
        RW          => RW_nand_out,
        read_data   => read_array(87 downto 80)
    );

    block_cell_2_2: cache_cell_8bit
    port map (
        write_data  => demux_out(79 downto 72),
        chip_enable => CE(9),
        RW          => RW_nand_out,
        read_data   => read_array(79 downto 72)
    );

    block_cell_2_3: cache_cell_8bit
    port map (
        write_data  => demux_out(71 downto 64),
        chip_enable => CE(8),
        RW          => RW_nand_out,
        read_data   => read_array(71 downto 64)
    );

    block_cell_3_0: cache_cell_8bit
    port map (
        write_data  => demux_out(63 downto 56),
        chip_enable => CE(7),
        RW          => RW_nand_out,
        read_data   => read_array(63 downto 56)
    );

    block_cell_3_1: cache_cell_8bit
    port map (
        write_data  => demux_out(55 downto 48),
        chip_enable => CE(6),
        RW          => RW_nand_out,
        read_data   => read_array(55 downto 48)
    );

    block_cell_3_2: cache_cell_8bit
    port map (
        write_data  => demux_out(47 downto 40),
        chip_enable => CE(5),
        RW          => RW_nand_out,
        read_data   => read_array(47 downto 40)
    );

    block_cell_3_3: cache_cell_8bit
    port map (
        write_data  => demux_out(39 downto 32),
        chip_enable => CE(4),
        RW          => RW_nand_out,
        read_data   => read_array(39 downto 32)
    );

    block_cell_4_0: cache_cell_8bit
    port map (
        write_data  => demux_out(31 downto 24),
        chip_enable => CE(3),
        RW          => RW_nand_out,
        read_data   => read_array(31 downto 24)
    );

    block_cell_4_1: cache_cell_8bit
    port map (
        write_data  => demux_out(23 downto 16),
        chip_enable => CE(2),
        RW          => RW_nand_out,
        read_data   => read_array(23 downto 16)
    );

    block_cell_4_2: cache_cell_8bit
    port map (
        write_data  => demux_out(15 downto 8),
        chip_enable => CE(1),
        RW          => RW_nand_out,
        read_data   => read_array(15 downto 8)
    );

    block_cell_4_3: cache_cell_8bit
    port map (
        write_data  => demux_out(7 downto 0),
        chip_enable => CE(0),
        RW          => RW_nand_out,
        read_data   => read_array(7 downto 0)
    );

    demux: demux_1x16_8bit
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

    mux: mux_16x1_8bit
    port map (
        inputs          => read_array,
        sel             => CE,
        output          => read_out
    );

    convert_1: one_hot_to_binary
    port map (
        one_hot         => block_offset(3 downto 1),
        binary          => block_off_bin
    );

    convert_2: one_hot_to_binary
    port map (
        one_hot         => byte_offset(3 downto 1),
        binary          => byte_off_bin
    );

    output_tx: tx_8bit
    port map (
        sel             => hit_miss,
        selnot          => not_hit_miss,
        input           => read_out,
        output          => read_data
    );

    comb_addr(3 downto 2) <= block_off_bin;
    comb_addr(1 downto 0) <= byte_off_bin;

end Structural;
