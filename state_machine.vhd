-- Entity: state_machine
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

-- decoder enable
-- start bit input
-- memory address output enable
-- hit_miss input
-- busy bit input
-- R/W register enable
-- R/W darta bit
-- mux send enable
entity state_machine is
    port(
        clk: in std_logic;
        start: in std_logic;
        hit_miss: in std_logic;
        valid_ready: in std_logic;
        R_W: in std_logic;
        cpu_addr: in std_logic_vector(7 downto 0);
        cpu_addr_ready: in std_logic;
        mem_addr_ready: in std_logic;
        write_done: in std_logic;

        -- add output cpu_address to send to system
        -- add 
        cache_RW: out std_logic;
        valid_RW: out std_logic;
        tag_RW: out std_logic;
        decoder_enable: out std_logic;
        mem_addr: out std_logic_vector(7 downto 0)
        mem_addr_out_enable: out std_logic;
        data_mux_enable: out std_logic;
        busy: out std_logic;
    );
end state_machine;

architecture structural of state_machine is
    component and_2x1
    port (
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
    end component;

    component and_3x1
    port(
        A      : in  STD_LOGIC; -- First input
        B      : in  STD_LOGIC; -- Second input
        C      : in  STD_LOGIC; -- Third input
        output : out STD_LOGIC -- Output of the 3-input AND gate
    );
    end component;

    component and_4x1
    port(
        A      : in  STD_LOGIC; -- First input
        B      : in  STD_LOGIC; -- Second input
        C      : in  STD_LOGIC; -- Third input
        D      : in  STD_LOGIC; -- Fourth input
        output : out STD_LOGIC -- Output of the 4-input AND gate
    );
    end component;

    component inverter
    port(
        input  : in  STD_LOGIC;
        output : out STD_LOGIC
    );
    end component;

    component or_2x1
    port(
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        output : out STD_LOGIC
    );
    end component;

    component mux_2x1
    port(
        A      : in  STD_LOGIC; -- Input 0
        B      : in  STD_LOGIC; -- Input 1
        sel    : in  STD_LOGIC; -- sel signal
        output : out STD_LOGIC -- Output of the multiplexer
    );
    end component;

    component buffer_1bit
        port(
            in_bit  : in  std_logic;  -- Input bit
            out_bit : out std_logic   -- Output bit
        );
    end component;

    for and_1, and_2, and_3: and_2x1 use entity work.and_2x1(structural);

    for and3_1, and3_2, and3_3: and_2x1 use entity work.and_3x1(structural);

    for and4_1, and4_2, and4_3: and_2x1 use entity work.and_4x1(structural);

    for interter_1, inverter_2, inverter_3: inverter use entity work.inverter(structural);

    for mux_1, mux_2: mux_2x1 use entity work.mux_2x1(structural);

    for or_1: or_2x1 use entity work.or_2x1(structural);

    for buffer_1: buffer_1bit use entity work.buffer_1bit(structural);
    
    signal hit_miss_inv, not_busy, temp_oe_1, temp_oe_2, output_enable_temp: std_logic;

begin
    and_1: and_2x1 port map(
        start,
        not_clk
        decoder_enable
    );

    mux_1: mux_2x1 port map(
        R_W,
        "0"
        start,
        cache_RW
    );

    and3_2: and_3x1 port map(
        valid_ready,
        hit_miss_inv,
        R_W,
        mem_addr_out_enable
    );

    inverter_1: inverter port map(
        hit_miss,
        hit_miss_inv
    );

    inverter_2: inverter port map(
        clk,
        not_clk
    );

    and_2: and_2x1 port map(
        valid_ready_
        output_enable
    );

    and3_2: and_3x1 port map(
        R_W,
        valid_ready,
        hit_miss,
        temp_oe_1
    );

    and4_1: and_4x1 port map(
        R_W,
        valid_ready,
        hit_miss_inv,
        mem_addr_ready,
        temp_oe_2
    );

    or_1: or_2x1 port map(
        temp_oe_1,
        temp_oe_2,
        output_enable_temp
    );

    and_3: and_2x1 port map(
        output_enable_temp,
        not_clk,
        output_enable
    );

    and_4: and_3x1 port map(
        valid_ready,
        not_clk,
        data_mux_enable
    );

    and4_2: and_4x1 port map(
        valid_ready,
        hit_miss_inv,
        R_W,
        not_clk,
        valid_RW
    );

    and4_3: and_4x1 port map(
        valid_ready,
        hit_miss_inv,
        R_W,
        not_clk,
        tag_RW
    );




end structural;