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
end entity chip;

architecture Structural of chip is

    component state_machine is
        port (
            vdd                  : in  std_logic;
            gnd                  : in  std_logic;
            clk                  : in  std_logic;
            start                : in  std_logic;
            reset_in             : in  std_logic;
            hit_miss             : in  std_logic;
            R_W                  : in  std_logic;

            cache_RW             : out std_logic;
            valid_WE             : out std_logic;
            tag_WE               : out std_logic;
            decoder_enable       : out std_logic;
            mem_addr_out_enable  : out std_logic;
            mem_data_read_enable : out std_logic;
            busy                 : out std_logic;
            output_enable        : out std_logic;                      -- cpu data output enable
            shift_reg_out        : out std_logic_vector(7 downto 0)
        );
    end component state_machine;

    component timed_cache is
        port (
            vdd                    : in  std_logic;                    -- power supply
            gnd                    : in  std_logic;                    -- ground
            clk                    : in  std_logic;                    -- system clock
            reset                  : in  std_logic;                    -- system reset
            write_cache            : in  std_logic_vector(7 downto 0); -- from on-chip register, released by state machine
            block_offset           : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            byte_offset            : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            tag                    : in  std_logic_vector(1 downto 0); -- from on-chip register, released by state machine
            valid_WE               : in  std_logic;                    -- from state machine
            tag_WE                 : in  std_logic;                    -- from state machine
            output_enable          : in  std_logic;                    -- from state machine
            RW_cache               : in  std_logic;                    -- from reg
            decoder_enable         : in  std_logic;                    -- from state machine
            busy                   : in std_logic;                     -- from state machine
            mem_addr_output_enable : in  std_logic;                    -- from state machine
            mem_addr               : out std_logic_vector(5 downto 0); -- to memory
            read_cache             : out std_logic_vector(7 downto 0); -- to on-chip register, which will be released off chip by state machine's OUTPUT_ENABLE signal
            hit_or_miss            : out std_logic                     -- status signal going to state machine
        );
    end component timed_cache;

    component byte_selector is
        port (
            vdd                 : in  std_logic;                       -- power supply
            gnd                 : in  std_logic;
            shift_register_data : in  std_logic_vector(7 downto 0);
            byte_offset         : out std_logic_vector(1 downto 0)
        );
    end component byte_selector;

    component dff_negedge_2bit is
        port (
            d    : in  std_logic_vector(1 downto 0);
            clk  : in  std_logic;
            q    : out std_logic_vector(1 downto 0);
            qbar : out std_logic_vector(1 downto 0)
        );
    end component dff_negedge_2bit;

    component dff_negedge_8bit is
        port (
            d    : in  std_logic_vector(7 downto 0);
            clk  : in  std_logic;
            q    : out std_logic_vector(7 downto 0);
            qbar : out std_logic_vector(7 downto 0)
        );
    end component dff_negedge_8bit;

    component mux_2x1_2bit is
        port (
            A      : in  std_logic_vector(1 downto 0);
            B      : in  std_logic_vector(1 downto 0);
            sel    : in  std_logic;
            output : out std_logic_vector(1 downto 0)
        );
    end component mux_2x1_2bit;
    
    component mux_2x1_8bit is
        port (
            A      : in  std_logic_vector(7 downto 0);
            B      : in  std_logic_vector(7 downto 0);
            sel    : in  std_logic;
            output : out std_logic_vector(7 downto 0)
        );
    end component mux_2x1_8bit;

    component inverter is
        port (
            input  : in  std_logic;
            output : out std_logic
        );
    end component inverter;

    signal busy_out, mem_data_read_enable, valid_WE, tag_WE, output_enable, cache_RW, mem_addr_out_enable, hit_or_miss,
        not_clk, not_busy, decoder_enable : std_logic;
    signal tag_reg_data_out, block_reg_data_out, byte_selector_out : std_logic_vector(1 downto 0);
    signal data_reg_mux_out, shift_reg_out, data_reg_out           : std_logic_vector(7 downto 0);
    signal cpu_data_reg_out, mem_data_reg_out                      : std_logic_vector(7 downto 0);
    signal cpu_byte_reg_data_out, mem_byte_reg_data_out, byte      : std_logic_vector(1 downto 0);

begin
    clk_inverter: entity work.inverter(Structural)
    port map (
        input                  => clk,
        output                 => not_clk
    );

    busy_inverter: entity work.inverter(Structural)
    port map (
        input                  => busy_out,
        output                 => not_busy
    );

    tag_reg: entity work.dff_negedge_2bit(Structural)
    port map (
        d                      => cpu_add(5 downto 4),
        clk                    => not_busy,
        q                      => tag_reg_data_out,
        qbar                   => open
    );

    block_reg: entity work.dff_negedge_2bit(Structural)
    port map (
        d                      => cpu_add(3 downto 2),
        clk                    => not_busy,
        q                      => block_reg_data_out,
        qbar                   => open
    );

    byte_selector_inst: entity work.byte_selector(Structural)
    port map (
        vdd                    => vdd,
        gnd                    => gnd,
        shift_register_data    => shift_reg_out,
        byte_offset            => byte_selector_out
    );

    mem_byte_reg: entity work.dff_negedge_2bit(Structural)
    port map (
        d                      => byte_selector_out,
        clk                    => clk,
        q                      => mem_byte_reg_data_out,
        qbar                   => open
    );

    cpu_byte_reg: entity work.dff_negedge_2bit(Structural)
    port map (
        d                      => cpu_add(1 downto 0),
        clk                    => not_busy,
        q                      => cpu_byte_reg_data_out,
        qbar                   => open
    );

    byte_mux: entity work.mux_2x1_2bit(Structural)
    port map (
        A                      => cpu_byte_reg_data_out,
        B                      => mem_byte_reg_data_out,
        sel                    => mem_data_read_enable,
        output                 => byte
    );

    cpu_data_reg: entity work.dff_negedge_8bit(Structural)
    port map (
        d                      => cpu_data,
        clk                    => not_busy,
        q                      => cpu_data_reg_out,
        qbar                   => open
    );

    mem_data_reg: entity work.dff_negedge_8bit(Structural)
    port map (
        d                      => mem_data,
        clk                    => clk,
        q                      => mem_data_reg_out,
        qbar                   => open
    );

    data_reg_mux: entity work.mux_2x1_8bit(Structural)
    port map (
        A                      => cpu_data_reg_out,
        B                      => mem_data_reg_out,
        sel                    => mem_data_read_enable,
        output                 => data_reg_out
    );

    state_machine_inst: entity work.state_machine(Structural)
    port map (
        vdd                    => vdd,
        gnd                    => gnd,
        clk                    => clk,
        start                  => start,
        reset_in               => reset,
        hit_miss               => hit_or_miss,
        R_W                    => cpu_rd_wrn,
        cache_RW               => cache_RW,
        valid_WE               => valid_WE,
        tag_WE                 => tag_WE,
        decoder_enable         => decoder_enable,
        mem_addr_out_enable    => mem_addr_out_enable,
        mem_data_read_enable   => mem_data_read_enable,
        busy                   => busy_out,
        output_enable          => output_enable,
        shift_reg_out          => shift_reg_out
    );

    cache: entity work.timed_cache(Structural)
    port map (
        vdd                    => vdd,
        gnd                    => gnd,
        clk                    => clk,
        reset                  => reset,
        write_cache            => data_reg_out,
        block_offset           => block_reg_data_out,
        byte_offset            => byte,
        tag                    => tag_reg_data_out,
        valid_WE               => valid_WE,
        tag_WE                 => tag_WE,
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

end architecture Structural;
