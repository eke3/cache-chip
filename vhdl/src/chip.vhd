-- Entity: chip
-- Architecture: Structural

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity chip is
    port (
        cpu_add    : in    std_logic_vector(5 downto 0);
        cpu_data   : inout std_logic_vector(7 downto 0);
        cpu_rd_wrn : in    std_logic;
        start      : in    std_logic;
        clk        : in    std_logic;
        reset      : in    std_logic;
        mem_data   : in    std_logic_vector(7 downto 0);
        vdd        : in    std_logic;
        gnd        : in    std_logic;
        busy       : out   std_logic;
        mem_en     : out   std_logic;
        mem_add    : out   std_logic_vector(5 downto 0)
    );
end chip;

architecture Structural of chip is

    component state_machine 
        port (
            gnd                  : in  std_logic;
            clk                  : in  std_logic;
            start                : in  std_logic;
            reset_in             : in  std_logic;
            hit_miss             : in  std_logic;
            R_W                  : in  std_logic;
            cache_RW             : out std_logic;
            tag_valid_WE               : out std_logic;
            decoder_enable       : out std_logic;
            mem_addr_out_enable  : out std_logic;
            mem_data_read_enable : out std_logic;
            busy                 : out std_logic;
            output_enable        : out std_logic;                      -- cpu data output enable
            shift_reg_out        : out std_logic_vector(7 downto 0)
        );
    end component;

    component timed_cache
        port (
            vdd                    : in  std_logic;                    -- power supply
            gnd                    : in  std_logic;                    -- ground
            clk                    : in  std_logic;                    -- system clock
            reset                  : in  std_logic;                    -- system reset
            write_cache            : in  std_logic_vector(7 downto 0); -- from on-chip register, released by state machine
            block_offset           : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            byte_offset            : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            tag                    : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            valid_tag_WE               : in  std_logic;                    -- from state machine
            output_enable          : in  std_logic;                    -- from state machine
            RW_cache               : in  std_logic;                    -- from reg
            decoder_enable         : in  std_logic;                    -- from state machine
            busy                   : in  std_logic;                    -- from state machine
            mem_addr_output_enable : in  std_logic;                    -- from state machine
            mem_addr               : out std_logic_vector(5 downto 0); -- to memory
            read_cache             : out std_logic_vector(7 downto 0); -- to on-chip register, which will be released off chip by state machine's OUTPUT_ENABLE signal
            hit_or_miss            : out std_logic                     -- status signal going to state machine
        );
    end component;

    component byte_selector
        port (
            vdd                 : in  std_logic;                       -- power supply
            gnd                 : in  std_logic;
            shift_register_data : in  std_logic_vector(7 downto 0);
            byte_offset         : out std_logic_vector(1 downto 0)
        );
    end component;

    component dff_negedge_2bit
        port (
            d    : in  std_logic_vector(1 downto 0);
            clk  : in  std_logic;
            q    : out std_logic_vector(1 downto 0);
            qbar : out std_logic_vector(1 downto 0)
        );
    end component;

    component dff_negedge_8bit
        port (
            d    : in  std_logic_vector(7 downto 0);
            clk  : in  std_logic;
            q    : out std_logic_vector(7 downto 0);
            qbar : out std_logic_vector(7 downto 0)
        );
    end component;

    component mux_2x1_2bit 
        port (
            A      : in  std_logic_vector(1 downto 0);
            B      : in  std_logic_vector(1 downto 0);
            sel    : in  std_logic;
            output : out std_logic_vector(1 downto 0)
        );
    end component;

    component mux_2x1_8bit 
        port (
            A      : in  std_logic_vector(7 downto 0);
            B      : in  std_logic_vector(7 downto 0);
            sel    : in  std_logic;
            output : out std_logic_vector(7 downto 0)
        );
    end component;

    component inverter 
        port (
            input  : in  std_logic;
            output : out std_logic
        );
    end component;

    for all: state_machine use entity work.state_machine(Structural);
    for all: timed_cache use entity work.timed_cache(Structural);
    for all: byte_selector use entity work.byte_selector(Structural);
    for all: dff_negedge_2bit use entity work.dff_negedge_2bit(Structural);
    for all: dff_negedge_8bit use entity work.dff_negedge_8bit(Structural);
    for all: mux_2x1_2bit use entity work.mux_2x1_2bit(Structural);
    for all: mux_2x1_8bit use entity work.mux_2x1_8bit(Structural);
    for all: inverter use entity work.inverter(Structural);


    signal busy_out, mem_data_read_enable, tag_valid_WE, output_enable, cache_RW, mem_addr_out_enable, hit_or_miss,
        not_clk, not_busy, decoder_enable : std_logic;
    signal tag_reg_data_out, block_reg_data_out, byte_selector_out : std_logic_vector(1 downto 0);
    signal data_reg_mux_out, shift_reg_out, data_reg_out           : std_logic_vector(7 downto 0);
    signal cpu_data_reg_out, mem_data_reg_out                      : std_logic_vector(7 downto 0);
    signal cpu_byte_reg_data_out, mem_byte_reg_data_out, byte      : std_logic_vector(1 downto 0);

begin
    clk_inverter: inverter
    port map (
        input                  => clk,
        output                 => not_clk
    );

    busy_inverter: inverter
    port map (
        input                  => busy_out,
        output                 => not_busy
    );

    tag_reg: dff_negedge_2bit
    port map (
        d                      => cpu_add(5 downto 4),
        clk                    => not_busy,
        q                      => tag_reg_data_out,
        qbar                   => open
    );

    block_reg: dff_negedge_2bit
    port map (
        d                      => cpu_add(3 downto 2),
        clk                    => not_busy,
        q                      => block_reg_data_out,
        qbar                   => open
    );

    byte_selector_inst: byte_selector
    port map (
        vdd                    => vdd,
        gnd                    => gnd,
        shift_register_data    => shift_reg_out,
        byte_offset            => byte_selector_out
    );

    mem_byte_reg: dff_negedge_2bit
    port map (
        d                      => byte_selector_out,
        clk                    => clk,
        q                      => mem_byte_reg_data_out,
        qbar                   => open
    );

    cpu_byte_reg: dff_negedge_2bit
    port map (
        d                      => cpu_add(1 downto 0),
        clk                    => not_busy,
        q                      => cpu_byte_reg_data_out,
        qbar                   => open
    );

    byte_mux: mux_2x1_2bit
    port map (
        A                      => cpu_byte_reg_data_out,
        B                      => mem_byte_reg_data_out,
        sel                    => mem_data_read_enable,
        output                 => byte
    );

    cpu_data_reg: dff_negedge_8bit
    port map (
        d                      => cpu_data,
        clk                    => not_busy,
        q                      => cpu_data_reg_out,
        qbar                   => open
    );

    mem_data_reg: dff_negedge_8bit
    port map (
        d                      => mem_data,
        clk                    => clk,
        q                      => mem_data_reg_out,
        qbar                   => open
    );

    data_reg_mux: mux_2x1_8bit
    port map (
        A                      => cpu_data_reg_out,
        B                      => mem_data_reg_out,
        sel                    => mem_data_read_enable,
        output                 => data_reg_out
    );

    state_machine_inst: state_machine
    port map (
        gnd                    => gnd,
        clk                    => clk,
        start                  => start,
        reset_in               => reset,
        hit_miss               => hit_or_miss,
        R_W                    => cpu_rd_wrn,
        cache_RW               => cache_RW,
        tag_valid_WE                 => tag_valid_WE,
        decoder_enable         => decoder_enable,
        mem_addr_out_enable    => mem_addr_out_enable,
        mem_data_read_enable   => mem_data_read_enable,
        busy                   => busy_out,
        output_enable          => output_enable,
        shift_reg_out          => shift_reg_out
    );

    cache: timed_cache
    port map (
        vdd                    => vdd,
        gnd                    => gnd,
        clk                    => clk,
        reset                  => reset,
        write_cache            => data_reg_out,
        block_offset           => block_reg_data_out,
        byte_offset            => byte,
        tag                    => tag_reg_data_out,
        valid_tag_WE                 => tag_valid_WE,
        output_enable          => output_enable,
        RW_cache               => cache_RW,
        decoder_enable         => decoder_enable,
        busy                   => busy_out,
        mem_addr_output_enable => mem_addr_out_enable,
        mem_addr               => mem_add,
        read_cache             => cpu_data,
        hit_or_miss            => hit_or_miss
    );

    busy   <= busy_out;
    mem_en <= mem_addr_out_enable;

end Structural;
