-- Entity: block_cache
-- Architecture: structural
-- Author:

library IEEE;
use IEEE.std_logic_1164.all;

entity block_cache is
    port(   mem_data    : in std_logic_vector(7 downto 0);
            mem_addr    : out std_logic_vector(7 downto 0);
            hit_miss    : in std_logic;
            R_W         : in std_logic;
            byte_offset : in std_logic_vector(3 downto 0);
            block_offset: in std_logic_vector(3 downto 0);
            cpu_data    : in std_logic_vector(7 downto 0);
            read_data   : out std_logic_vector(7 downto 0));
end block_cache;

architecture structural of block_cache is
    component cache_cell_8bit
        port(
            write_data      : in std_logic_vector(7 downto 0);
            chip_enable    : in std_logic;
            RW              : in std_logic;
            read_data       : out std_logic(7 downto 0));
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
        data_out_15 : out STD_LOGIC_VECTOR(7 downto 0) -- Output for selection "1111"
    );
    end component;

    component data_input_selector
        port(
            cpu_data: in std_logic_vector(7 downto 0);
            mem_data: in std_logic_vector(7 downto 0);
            hit_miss: in std_logic;
            R_W:      in std_logic;
            out_data: out std_logic_vector(7 downto 0);
        );
    end component;

    component mux_16x1_8bit
        port (
            inputs : in  STD_LOGIC_VECTOR(127 downto 0);  -- 16 inputs, each 8-bit wide
            sel    : in  STD_LOGIC_VECTOR(15 downto 0);    -- 4-bit select signal
            output : out STD_LOGIC_VECTOR(7 downto 0)     -- 8-bit output
        );
    end component;

    component concatenator
        port(
            input_a : in std_logic_vector(1 downto 0);  -- First 2-bit input
            input_b : in std_logic_vector(1 downto 0);  -- Second 2-bit input
            output  : out std_logic_vector(3 downto 0)  -- Concatenated 4-bit output
        );
    end component;
    

    --for block_0000, block_0001, block_0010, block_0011, block_0100, block_0101, block_0110, block_0111, block_1000, block_1001, 
    --block_1010, block_1011, block_1100, block_1101, block_1110, block_1111: cache_cell_8bit use entity work.cache_cell_8bit(structural);

    for and_1, and_2, and_3, and_4: and_2x1 use entity work.and_2x1(structural);

    for block_cell_1, block_cell_2, block_cell_3, block_cell_4: cache_cell_8bit use entity work.cache_cell_8bit(structural);

    for demux: demux_1x16_8bit use entity work.demux_1x16_8bit(structural);

    for data_input_selector: data_input_selector use entity work.data_input_selector(structural);

    for mux: mux_2x1_8bit use entity work.mux_2x1_8bit(structural);

    for concatenator: concatenator use entity work.concatenator(structural);

    --signal block_off_0, block_off_1, byte_off_0, byte_off_1, sel_0, sel_1, sel_2, sel_3, sel_4, sel_5, sel_6, sel_7, sel_8, 
    --sel_9, sel_10, sel_11, sel_12, sel_13, sel_14, sel_15 : std_logic;

    signal out_data: std_logic_vector(7 downto 0);

    signal CE: std_logic_vector (15 downto 0);

    signal demux_out: std_logic_vector(15 downto 0);

    --type logic_array is array (0 to 4) of std_logic_vector(7 downto 0);
    signal read_array(127 downto 0);

    signal comb_add(3 downto 0);

begin

    gen_cell_1: for i in 0 to 3 generate
            and_1: component and_2x1
                port map (
                    block_offset(0),
                    byte_offset(i),
                    CE(15-(i*1))
                );
    end generate gen_cell_1;

    gen_cell_2: for i in 0 to 3 generate
            and_2: component and_2x1
                port map (
                    block_offset(1),
                    byte_offset(i),
                    CE(11-(i*1))
                );
    end generate gen_cell_2;

    gen_cell_3: for i in 0 to 3 generate
            and_3: component and_2x1
                port map (
                    block_offset(2),
                    byte_offset(i),
                    CE(7-(i*1))
                );
    end generate gen_cell_3;

    gen_cell_4: for i in 0 to 3 generate
            and_4: component and_2x1
                port map (
                    block_offset(3),
                    byte_offset(i),
                    CE(3-(i*1))
                );
    end generate gen_cell_4;

    gen_cell_5: for i in 1 to 4 generate
        block_cell_1: component cache_cell_8bit
            port map (
                demux_out(i),
                CE(15-((i-1)*1)),
                R_W,
                read_array(127 downto 127-(8*i))
            );
    end generate gen_cell_5;

    gen_cell_6: for i in 1 to 4 generate
        block_cell_2: component cache_cell_8bit
            port map (
                demux_out(i),
                CE(11-((i-1)*1)),
                R_W,
                read_array(95 downto 95-(8*i))
            );
    end generate gen_cell_6;

    gen_cell_7: for i in 1 to 4 generate
        block_cell_3: component cache_cell_8bit
            port map (
                demux_out(i),
                CE(7-((i-1)*1)),
                R_W,
                read_array(63 downto 63-(8*i))
            );
    end generate gen_cell_7;

    gen_cell_8: for i in 1 to 4 generate
        block_cell_4: component cache_cell_8bit
            port map (
                demux_out(i),
                CE(3-((i-1)*1)),
                R_W,
                read_array(31 downto 0)
            );
    end generate gen_cell_8;

    demux: demux_1x16_8bit port map(
        out_data,
        comb_addr(3:0),
        demux_out(0),
        demux_out(1),
        demux_out(2),
        demux_out(3),
        demux_out(4),
        demux_out(5),
        demux_out(6),
        demux_out(7),
        demux_out(8),
        demux_out(9),
        demux_out(10),
        demux_out(11),
        demux_out(12),
        demux_out(13),
        demux_out(14),
        demux_out(15)
    );

    data_input_selector: data_input_selector port map(
        cpu_data,
        mem_data,
        hit_miss,
        R_W,
        out_data
    );

    mux: mux_16x1_8bit port map(
        inputs <=  read_array; -- 16 inputs, each 8-bit wide
        sel    <= CE;    -- 4-bit select signal
        output <= read_data;     -- 8-bit output
    );

    concatenator: concatenator port map(
        block_offset,
        byte_offset,
        comb_addr
    )

end block_cache;