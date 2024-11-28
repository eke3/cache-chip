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
        vdd : in std_logic;
        gnd : in std_logic;
        clk: in std_logic;
        start: in std_logic;
        reset_in: in std_logic;
        hit_miss: in std_logic;
        R_W: in std_logic;

        cache_RW: out std_logic;
        valid_WE: out std_logic;
        tag_WE: out std_logic;
        decoder_enable: out std_logic;
        mem_addr_out_enable: out std_logic;
        mem_data_read_enable: out std_logic;
        -- data_mux_enable: out std_logic;
        busy: out std_logic;
        output_enable: out std_logic; -- cpu data output enable


        shift_reg_out : out std_logic_vector(7 downto 0)
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
    
    signal tag_valid_WE, tag_valid_ready: std_logic;
    
    signal mem_addr_out_enable_sig, shift_7_enable: std_logic;
    
    signal mem_addr_ready, latch_hit_miss, decoder_enable_sig, output_enable_sig, mem_data_read_enable_temp, mem_data_read_enable_sig, busy_inv: std_logic;
    
    signal read_miss_cache_read, RW_temp_1, RW_temp_2, R_W_sig, R_W_inv, mem_data_read_disable: std_logic;
    
begin

    -- Drives cache_RW low when writing bytes from memory.
    rw_mux: entity work.mux_2x1(structural) port map(
        A => R_W_sig,
        B => gnd,
        sel => mem_data_read_enable_sig,
        output => cache_RW
    );

    -- cache_RW <= R_W_sig;
    
    -- and gate for setting the R_W sr latch
    and_for_RW: entity work.and_2x1(structural) port map(
        start,
        R_W,
        RW_temp_1
    );
    
    -- and gate for resetting the R_W sr latch
    and_for_RW_2: entity work.and_2x1(structural) port map(
        start,
        R_W_inv,
        RW_temp_2
    );
    
    -- SR latch for hold chip R_W signal
    hold_RW_SR_latch: entity work.sr_latch(structural) port map(
        RW_temp_1,
        RW_temp_2,
        R_W_sig
    );
    
    -- and gate for enabling the send of the memory address
    and3_1: entity work.and_3x1(structural) port map(
        valid_ready,
        hit_miss_inv,
        R_W_sig,
        mem_addr_out_enable_sig
    );

    -- inverts hit_miss signal for logical uses
    inverter_1: entity work.inverter(structural) port map(
        hit_miss,
        hit_miss_inv
    );

    -- inverts clk signal for logical uses
    inverter_2: entity work.inverter(structural) port map(
        clk,
        not_clk
    );
    
    --inverter for chip RW (used in SR latch for hold chip RW signal)
    inverter_RW_in: entity work.inverter(structural) port map(
        R_W,
        R_W_inv
    );

    -- inverter for latched RW
    inverter_3: entity work.inverter(structural) port map(
        R_W_sig,
        RW_inv
    );
    
    -- checks for read_hit and if timer expired to determine if
    -- output enable should go high
    and4_2: entity work.and_4x1(structural) port map(
        R_W_sig,
        valid_ready,
        hit_miss,
        read_hit_count,
        temp_oe_1
    );

    -- checks for read_miss and if timer expired to determine if
    -- output enable should go high
    and3_2: entity work.and_3x1(structural) port map(
        R_W_sig,
        hit_miss_inv,
        read_miss_count,
        temp_oe_2
    );
    
    -- the following nonsense with the output enables just makes sure
    -- it holds for the proper amount of time, feel free to make it better
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
    
    -- checks for a read miss to trigger write enables for valid and tag
  --  sr_latch_2: entity work.sr_latch(structural) port map(
  --      read_miss,
  --      busy_sig_inv,
  --      mem_addr_ready
  --  );
    
    -- sr latch to trigger and hold decoder enable, triggered by high start bit
    sr_latch_3: entity work.sr_latch(structural) port map(
        start,
        reset,
        decoder_enable_sig
    );

    -- and gate checks for a valid read miss
    and4_1: entity work.and_4x1(structural) port map(
        hit_miss_inv,
        R_W_sig,
        busy_sig,
        valid_ready,
        read_miss
    );

    -- sets up temp logic for set of busy signal SR latch
    and_5: entity work.and_2x1(structural) port map(
        start,
        not_clk,
        set_temp
    );
    
    -- sets up temp logic for reset of busy signal SR latch
    and_6: entity work.and_2x1(structural) port map(
        start, 
        clk,
        reset_criteria
    );
    
    -- or gate to determine if the function has completed (according to necessary
    -- timing) and sets reset high for busy signal SR_latch
    or4_1: entity work.or_4x1(structural) port map(
        reset_criteria,
        read_miss_count,
        read_hit_count,
        write_count,
        reset
    );

    -- criteria needed to trigger timer for a write operation
    and_7: entity work.and_2x1(structural) port map(
        RW_inv,
        valid_ready,
        write_count_criteria
    );
    
    -- shift register timer for a write operation. Used to hold busy signal high
    -- for the correct amount of clock signals
    shift_reg_2_0: entity work.shift_register_bit_2(structural) port map(
        write_count_criteria,
        clk,
        write_count -- will be U until propogated out (bcuz counter)
    );

    -- shift register timer for a read miss operation. Used to hold busy signal high
    -- for the correct amount of clock signals
    shift_reg_19: entity work.shift_register_bit_19(structural) port map(
        read_miss_trigger,
        clk,        
        read_miss_count     -- omg also needs to be propogated out, so must wait hella
    );

    -- logical crieteria to getermine if the read miss timer should be started.
    -- checls for a valid miss and a read
    and3_3: entity work.and_3x1(structural) port map(
        valid_ready,
        hit_miss_inv,
        R_W_sig,
        read_miss_trigger
    );
    
    -- read hit only needs to go high for one clock cycle, so instead of using
    -- a shift register, a simple and gate checks if a read hit has occured and 
    -- sends a high signal for only one clock cycle
    and3_4: entity work.and_3x1(structural) port map(
        valid_ready,
        hit_miss,
        R_W_sig,
        read_hit_count
    );

    -- SR latch for busy signal to stay high during operations
    sr_latch_1: entity work.sr_latch(structural) port map(
        set,
        reset,
        busy_sig,
        busy_sig_inv
    );

    -- start and high clock indicates incoming signals are ready to use
    shift_reg_3_2: entity work.shift_register_bit_3(structural) port map(
        start,
        clk,
        valid_ready
    );
    
    -- set_temp logic all just used to determine when to send busy signal high
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

    -- shift register to trigger memory data read enable after 8 clk cycles from 
    -- mem_addr send enable
    shift_reg_7: entity work.shift_register_bit_7(structural) port map(
        shift_7_enable,
        clk,
        mem_data_read_enable_temp,
        open
    );
    
    -- latch to hold mem data read high for the correct timing
    sr_latch_4: entity work.sr_latch(structural) port map(
        mem_data_read_enable_temp,
        mem_data_read_disable,
        mem_data_read_enable_sig
    );
    
    -- inverts busy signal for logical use
    inv_5: entity work.inverter(structural) port map(
        busy_sig,
        busy_inv
    );
    
    -- shift register to disable memory read enable signal after 8 clock cycles
    shift_reg_7_2: entity work.shift_register_bit_7(structural) port map(
        mem_data_read_enable_temp,
        clk,
        mem_data_read_disable,
        shift_reg_out
    );

    -- triggers shift register to count out 8 cycles after memory address out 
    -- enable goes high
    or_3: entity work.or_2x1(structural) port map(
       mem_addr_out_enable_sig,
       reset_in,
       shift_7_enable
    );
    
    shift_tag_valid: entity work.shift_register_bit_3 port map(
        mem_addr_out_enable_sig,
        clk,
        tag_valid_WE
    );

    decoder_enable_logic : entity work.or_2x1(structural) port map(
        A => busy_sig,
        B => output_enable_sig,
        output => decoder_enable
    );

    busy <= busy_sig;
    -- decoder_enable <= busy_sig;
    output_enable <= output_enable_sig;
    tag_WE <= tag_valid_WE;
    valid_WE <= tag_valid_WE;
    mem_addr_out_enable <= mem_addr_out_enable_sig;
    mem_data_read_enable <= mem_data_read_enable_sig;
    
end structural;