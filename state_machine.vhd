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
        reset_in: in std_logic;
        hit_miss: in std_logic;
        R_W: in std_logic;
        cpu_addr: in std_logic_vector(5 downto 0);
        --mem_addr_ready: in std_logic;

        cache_RW: out std_logic;
        valid_WE: out std_logic;
        tag_WE: out std_logic;
        --busy_RW: out std_logic;
        decoder_enable: out std_logic;
        mem_addr_out_enable: out std_logic;
        mem_data_read_enable: out std_logic;
        data_mux_enable: out std_logic;
        busy: out std_logic; -- also use for decoder enable
        output_enable: out std_logic -- cpu data output enable
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

    component or_3x1
        port(
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;
    
    component or_4x1
        port(
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            D      : in std_logic;
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

    component shift_register_bit_2
        port(
            input: in std_logic;
            clk: in std_logic;
            output: out std_logic
        );
    end component;

    component shift_register_bit_3
        port(
            input: in std_logic;
            clk: in std_logic;
            output: out std_logic
        );
    end component;

    component shift_register_bit_19
    port(
        input: in std_logic;
        clk: in std_logic;
        output: out std_logic
    );
    end component;

    component sr_latch
        port(
            S  : in  std_logic; -- Set input
            R  : in  std_logic; -- Reset input
            Q  : inout std_logic; -- Output Q
            Qn : inout std_logic  -- Complement of Q
        );
    end component;  

    component shift_register_bit_7
        port(
            input: in std_logic;
            clk: in std_logic;
            output: out std_logic
        );
    end component;

    -- for and_2: and_2x1 use entity work.and_2x1(structural);

    -- for and3_1, and3_3, and3_2: and_3x1 use entity work.and_3x1(structural);

    -- for and4_1, and4_2: and_4x1 use entity work.and_4x1(structural);

    -- for inverter_1, inverter_2, inverter_3: inverter use entity work.inverter(structural);

    -- for mux_1: mux_2x1 use entity work.mux_2x1(structural);

    -- for or_1: or_2x1 use entity work.or_2x1(structural);

    -- for shift_reg_19: shift_register_bit_19 use entity work.shift_register_bit_19(structural);


    
    signal hit_miss_inv, RW_inv, not_busy, temp_oe_1, temp_oe_2, output_enable_temp, read_miss_count, read_hit_count, write_count: std_logic;

    signal read_miss_trigger, read_hit_trigger, set, reset, not_clk, valid_ready, busy_sig, reset_criteria, busy_sig_inv: std_logic;

    signal write_count_criteria, set_temp, set_temp_2, output_enable_temp_2, output_enable_temp_3, read_miss: std_logic;
    
    signal tag_WE_sig, valid_WE_sig: std_logic;
    
    signal mem_addr_out_enable_sig, shift_7_enable: std_logic;
    
    signal mem_addr_ready, latch_hit_miss, decoder_enable_sig, output_enable_sig, mem_data_read_enable_temp, mem_data_read_enable_sig, busy_inv: std_logic;
    
    signal read_miss_cache_read: std_logic;
    
begin
    
    cache_RW <= R_W;

    and3_1: entity work.and_3x1(structural) port map(
        valid_ready,
        hit_miss_inv,
        R_W,
        mem_addr_out_enable_sig
    );

    inverter_1: entity work.inverter(structural) port map(
        hit_miss,
        hit_miss_inv
    );

    inverter_2: entity work.inverter(structural) port map(
        clk,
        not_clk
    );

    inverter_3: entity work.inverter(structural) port map(
        R_W,
        RW_inv
    );

    and4_2: entity work.and_4x1(structural) port map(
        R_W,
        valid_ready,
        hit_miss,
        read_hit_count,
        temp_oe_1
    );

    and3_2: entity work.and_3x1(structural) port map(
        R_W,
        hit_miss_inv,
        read_miss_count,
        temp_oe_2
    );

    or_1: entity work.or_2x1(structural) port map(
        temp_oe_1,
        temp_oe_2,
        output_enable_temp
    );

    and_2: entity work.and_2x1(structural) port map(
        output_enable_temp,
        not_clk,
        output_enable_temp_2
    );
    
    shift_reg_2_4: entity work.shift_register_bit_2(structural) port map(
        output_enable_temp_2,
        not_clk,
        output_enable_temp_3
    );
    
    or_2x1_3: entity work.or_2x1(structural) port map(
        output_enable_temp_2,
        output_enable_temp_3,
        output_enable_sig
    );
    
    sr_latch_2: entity work.sr_latch(structural) port map(
        read_miss,
        busy_sig_inv,
        mem_addr_ready
    );
    
    sr_latch_3: entity work.sr_latch(structural) port map(
        start,
        reset,
        decoder_enable_sig
    );
    
    --sr_latch_3: entity work.sr_latch(structural) port map(
    --    read_miss,
    --    busy_sig_inv,
    --    tag_WE_sig
    --);

    and4_1: entity work.and_4x1(structural) port map(
        hit_miss_inv,
        R_W,
        busy_sig,
        valid_ready,
        read_miss
    );

    and_5: entity work.and_2x1(structural) port map(
        start,
        not_clk,
        set_temp
    );
    
    and_6: entity work.and_2x1(structural) port map(
        start, 
        clk,
        reset_criteria
    );

  --  or_2: entity work.or_2x1(structural) port map(
  --      output_enable_temp,
  --      timers,
  --      reset
  --  );

    or4_1: entity work.or_4x1(structural) port map(
        reset_criteria,
        read_miss_count,
        read_hit_count,
        write_count,
        reset
    );

    --shift_reg_2_1: entity work.shift_register_bit_2(structural) port map(
    --    read_hit_trigger,
    --    clk,
    --    read_hit_count
    --);
    
    and_7: entity work.and_2x1(structural) port map(
        RW_inv,
        valid_ready,
        write_count_criteria
    );
    
    shift_reg_2_0: entity work.shift_register_bit_2(structural) port map(
        write_count_criteria,
        clk,
        write_count -- will be U until propogated out (bcuz counter)
    );

    shift_reg_19: entity work.shift_register_bit_19(structural) port map(
        read_miss_trigger,
        clk,        
        read_miss_count     -- omg also needs to be propogated out, so must wait hella
    );

    and3_3: entity work.and_3x1(structural) port map(
        valid_ready,
        hit_miss_inv,
        R_W,
        read_miss_trigger
    );

    and3_4: entity work.and_3x1(structural) port map(
        valid_ready,
        hit_miss,
        R_W,
        read_hit_count
    );

    sr_latch_1: entity work.sr_latch(structural) port map(
        set,
        reset,
        busy_sig,
        busy_sig_inv
    );

    shift_reg_3_2: entity work.shift_register_bit_3(structural) port map(
        start,
        clk,
        valid_ready
    );
    
    shift_reg_3_3: entity work.shift_register_bit_3(structural) port map(
        set_temp,
        not_clk,
        set_temp_2
    );
    
    or_2x1_2: entity work.or_2x1(structural) port map(
        set_temp,
        set_temp_2,
        set
    );

    shift_reg_7: entity work.shift_register_bit_7(structural) port map(
        shift_7_enable,
        clk,
        mem_data_read_enable_temp
    );
    
    sr_latch_4: entity work.sr_latch(structural) port map(
        mem_data_read_enable_temp,
        busy_inv,
        mem_data_read_enable_sig
    );
    
    inv_5: entity work.inverter(structural) port map(
        busy_sig,
        busy_inv
    );

    or_3: entity work.or_2x1(structural) port map(
       mem_addr_out_enable_sig,
       reset_in,
       shift_7_enable
    );

    busy <= busy_sig;
    decoder_enable <= busy_sig;
    output_enable <= output_enable_sig;
    tag_WE <= mem_addr_ready;
    valid_WE <= mem_addr_ready;
    mem_addr_out_enable <= mem_addr_out_enable_sig;
    mem_data_read_enable <= mem_data_read_enable_sig;
    
end structural;