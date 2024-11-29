-- Entity: timed_cache
-- Architecture: Structural

library IEEE;
use IEEE.std_logic_1164.all;

entity timed_cache is
    port (
        vdd                    : in  std_logic; -- power supply
        gnd                    : in  std_logic; -- ground
        clk                    : in  std_logic; -- system clock
        reset                  : in  std_logic; -- system reset
        write_cache            : in  std_logic_vector(7 downto 0); -- from on-chip register, released by state machine
        block_offset           : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
        byte_offset            : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
        tag                    : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
        valid_WE               : in  std_logic; -- from state machine
        tag_WE                 : in  std_logic; -- from state machine
        output_enable          : in  std_logic; -- from state machine
        RW_cache               : in  std_logic; -- from state machine
        decoder_enable         : in  std_logic; -- from state machine
        busy                   : in  std_logic; -- from state machine
        mem_addr_output_enable : in  std_logic; -- from state machine
        mem_addr               : out std_logic_vector(5 downto 0); -- to memory
        read_cache             : out std_logic_vector(7 downto 0); -- to on-chip register, which will be released off chip by state machine's OUTPUT_ENABLE signal
        hit_or_miss            : out std_logic -- status signal going to state machine
    );
end entity timed_cache;

architecture Structural of timed_cache is
    -- Component declarations.
    component dff_posedge is
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component dff_posedge;

    component dff_negedge is
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component dff_negedge;

    component dff_negedge_2bit is
        port (
            d    : in  STD_LOGIC_VECTOR(1 downto 0);
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC_VECTOR(1 downto 0);
            qbar : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component dff_negedge_2bit;

    component dff_posedge_4bit is
        port (
            d    : in  STD_LOGIC_VECTOR(3 downto 0);
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC_VECTOR(3 downto 0);
            qbar : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component dff_posedge_4bit;

    component dff_posedge_8bit is
        port (
            d    : in  STD_LOGIC_VECTOR(7 downto 0);
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC_VECTOR(7 downto 0);
            qbar : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component dff_posedge_8bit;

    component dff_negedge_8bit is
        port (
            d    : in  STD_LOGIC_VECTOR(7 downto 0);
            clk  : in  STD_LOGIC;
            q    : out STD_LOGIC_VECTOR(7 downto 0);
            qbar : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component dff_negedge_8bit;

    component decoder_2x4 is
        port (
            A : in  STD_LOGIC_VECTOR(1 downto 0);
            E : in  STD_LOGIC;
            Y : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component decoder_2x4;

    component tag_comparator_2x1 is
        port (
            A      : in  STD_LOGIC_VECTOR(1 downto 0);
            B      : in  STD_LOGIC_VECTOR(1 downto 0);
            output : out STD_LOGIC
        );
    end component tag_comparator_2x1;

    component tag_vector is
        port (
            write_data  : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit shared write data
            chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
            RW          : in  STD_LOGIC;                    -- Shared Read/Write signal for all cells
            sel         : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector for demux
            read_data   : out STD_LOGIC_VECTOR(1 downto 0)  -- Read data output for cell 3
        );
    end component tag_vector;

    component valid_vector is
        port (
            vdd         : in  STD_LOGIC;                    -- Power supply
            gnd         : in  STD_LOGIC;                    -- Ground
            write_data  : in  STD_LOGIC;                    -- Shared write data for demux
            reset       : in  STD_LOGIC;                    -- Shared reset signal for all cells
            chip_enable : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit chip enable (1 bit per cell)
            RW          : in  STD_LOGIC;                    -- Shared Read/Write signal for all cells
            sel         : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector for demux, comes from decoder input
            read_data   : out STD_LOGIC                     -- Read data output for cell 3
        );
    end component valid_vector;

    component block_cache is
        port (
            write_cache  : in  std_logic_vector(7 downto 0);
            hit_miss     : in  std_logic;
            R_W          : in  std_logic;
            byte_offset  : in  std_logic_vector(3 downto 0);
            block_offset : in  std_logic_vector(3 downto 0);
            read_data    : out std_logic_vector(7 downto 0)
        );
    end component block_cache;

    component and_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_2x1;

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
            input  : in  std_logic_vector(7 downto 0);      -- 8-bit input data
            output : out std_logic_vector(7 downto 0)       -- 8-bit output data
        );
    end component tx_8bit;

    component tx_6bit is
        port (
            sel    : in  std_logic;                         -- Selector signal
            selnot : in  std_logic;                         -- Inverted selector signal
            input  : in  std_logic_vector(5 downto 0);      -- 6-bit input data
            output : out std_logic_vector(5 downto 0)       -- 6-bit output data
        );
    end component tx_6bit;

    -- Intermediate signals
    signal read_valid                                    : std_logic;
    signal read_tag                                      : std_logic_vector(1 downto 0);
    signal cmp_tag, cmp_valid                            : std_logic;
    signal hit_miss, hit_miss_reg, valid_reg             : std_logic;
    signal data_reg1, data_reg2                          : std_logic_vector(7 downto 0);
    signal byte_decoder_out, block_decoder_out           : std_logic_vector(3 downto 0);
    signal byte_decoder_reg, block_decoder_reg           : std_logic_vector(3 downto 0);
    signal RW_valid, RW_tag                              : std_logic;
    signal read_cache_data_out                           : std_logic_vector(7 downto 0);
    signal read_cache_data_tx_in, read_cache_data_tx_out : STD_LOGIC_VECTOR(7 downto 0);
    signal mem_addr_tx_in, mem_addr_tx_out               : std_logic_vector(5 downto 0);
    signal output_enable_not, mem_addr_output_enable_not : std_logic;

begin
    -- Input signal inverters
    output_enable_inv: entity work.inverter(Structural)
    port map (
        input        => output_enable,
        output       => output_enable_not
    );

    mem_addr_output_enable_inv: entity work.inverter(Structural)
    port map (
        input        => mem_addr_output_enable,
        output       => mem_addr_output_enable_not
    );

    rw_valid_inv: entity work.inverter(Structural)
    port map (
        input        => valid_WE,
        output       => RW_valid
    );

    rw_tag_inv: entity work.inverter(Structural)
    port map (
        input        => tag_WE,
        output       => RW_tag
    );

    -- First input data register.
    data_ff: entity work.dff_negedge_8bit(Structural)
    port map (
        d            => write_cache,
        clk          => clk,
        q            => data_reg1,
        qbar         => open
    );

    -- Second Input data register.
    data_ff2: entity work.dff_posedge_8bit(Structural)
    port map (
        d            => data_reg1,
        clk          => clk,
        q            => data_reg2,
        qbar         => open
    );

    -- Block offset decoder.
    block_decoder: entity work.decoder_2x4(Structural)
    port map (
        A            => block_offset,
        E            => decoder_enable,
        Y            => block_decoder_out
    );

    -- Byte offset decoder.
    byte_decoder: entity work.decoder_2x4(Structural)
    port map (
        A            => byte_offset,
        E            => decoder_enable,
        Y            => byte_decoder_out
    );

    -- Register holding decoded byte offset.
    byte_decoder_ff: entity work.dff_posedge_4bit(Structural)
    port map (
        d            => byte_decoder_out,
        clk          => clk,
        q            => byte_decoder_reg,
        qbar         => open
    );

    -- Register holding decoded block offset.
    block_decoder_ff: entity work.dff_posedge_4bit(Structural)
    port map (
        d            => block_decoder_out,
        clk          => clk,
        q            => block_decoder_reg,
        qbar         => open
    );

    -- Vertical vector of four 2-bit tag cells.
    tag_vec: entity work.tag_vector(Structural)
    port map (
        write_data   => tag,
        chip_enable  => block_decoder_out,
        RW           => RW_tag,
        sel          => block_offset,
        read_data    => read_tag
    );

    -- Vertical vector of four 1-bit valid cells.
    valid_vec: entity work.valid_vector(Structural)
    port map (
        vdd          => vdd,
        gnd          => gnd,
        write_data   => vdd,
        reset        => reset,
        chip_enable  => block_decoder_out,
        RW           => RW_valid,
        sel          => block_offset,
        read_data    => read_valid
    );

    -- 2-bit comparator for tags to check for hit/miss.
    tag_cmp: entity work.tag_comparator_2x1(Structural)
    port map (
        A            => tag,
        B            => read_tag,
        output       => cmp_tag
    );

    -- 1-bit comparator for valid bits to check for hit/miss.
    valid_cmp: entity work.and_2x1(Structural)
    port map (
        A            => vdd,
        B            => read_valid,
        output       => cmp_valid
    );

    -- 1-bit AND gate to check for hit/miss using tag and valid match results.
    hit_miss_cmp: entity work.and_2x1(Structural)
    port map (
        A            => cmp_tag,
        B            => cmp_valid,
        output       => hit_miss
    );

    -- Register holding hit/miss signal.
    hit_miss_ff: entity work.dff_posedge(Structural)
    port map (
        d            => hit_miss,
        clk          => clk,
        q            => hit_miss_reg,
        qbar         => open
    );

    -- 4x4 Cache array holding 8-bit data.
    cache: entity work.block_cache(Structural)
    port map (
        write_cache  => data_reg2,
        hit_miss     => hit_miss_reg,
        R_W          => RW_cache,
        byte_offset  => byte_decoder_reg,
        block_offset => block_decoder_reg,
        read_data    => read_cache_data_out
    );

    -- Register that loads data read from the cache into a transmission gate when BUSY goes low.
    data_out_ff: entity work.dff_negedge_8bit(Structural)
    port map (
        d            => read_cache_data_out,
        clk          => busy,
        q            => read_cache_data_tx_in,
        qbar         => open
    );

    -- Build memory address that will be sent to memory during a read miss.
    mem_addr_tx_in(5 downto 4) <= tag;
    mem_addr_tx_in(3 downto 2) <= block_offset;
    mem_addr_tx_in(1)          <= gnd;
    mem_addr_tx_in(0)          <= gnd;

    -- Transmission gate for memory address going to memory, gated by mem_addr_output_enable.
    mem_addr_tx: entity work.tx_6bit(Structural)
    port map (
        sel          => mem_addr_output_enable,
        selnot       => mem_addr_output_enable_not,
        input        => mem_addr_tx_in,
        output       => mem_addr_tx_out
    );

    -- Transmission gate for read cache data going back to the CPU, gated by output_enable.
    read_data_tx: entity work.tx_8bit(Structural)
    port map (
        sel          => output_enable,
        selnot       => output_enable_not,
        input        => read_cache_data_tx_in,
        output       => read_cache_data_tx_out
    );

    read_cache                 <= read_cache_data_tx_out;
    mem_addr                   <= mem_addr_tx_out;
    hit_or_miss                <= hit_miss_reg;             -- output for state machine, tells it whether there was a hit or miss in the current operation

end architecture Structural;
