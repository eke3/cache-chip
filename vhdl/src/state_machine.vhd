-- Entity: state_machine
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity state_machine is
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
        output_enable        : out std_logic; -- cpu data output enable
        shift_reg_out        : out std_logic_vector(7 downto 0)
    );
end state_machine;

architecture Structural of state_machine is
    component and_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component and_3x1
        port (
            A      : in  STD_LOGIC;    -- First input
            B      : in  STD_LOGIC;    -- Second input
            C      : in  STD_LOGIC;    -- Third input
            output : out STD_LOGIC     -- Output of the 3-input AND gate
        );
    end component;

    component and_4x1 
        port (
            A      : in  STD_LOGIC;    -- First input
            B      : in  STD_LOGIC;    -- Second input
            C      : in  STD_LOGIC;    -- Third input
            D      : in  STD_LOGIC;    -- Fourth input
            output : out STD_LOGIC     -- Output of the 4-input AND gate
        );
    end component;

    component inverter 
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component or_2x1 
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component or_4x1 
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            D      : in  std_logic;
            output : out STD_LOGIC
        );
    end component;

    component mux_2x1 
        port (
            A      : in  STD_LOGIC;    -- Input 0
            B      : in  STD_LOGIC;    -- Input 1
            sel    : in  STD_LOGIC;    -- sel signal
            output : out STD_LOGIC     -- Output of the multiplexer
        );
    end component;

    component dff_negedge 
        port (
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;

    component shift_register_3bit 
        port (
            input  : in  std_logic;
            clk    : in  std_logic;
            output : out std_logic
        );
    end component;

    component shift_register_19bit 
        port (
            input  : in  std_logic;
            clk    : in  std_logic;
            output : out std_logic
        );
    end component;

    component sr_latch 
        port (
            S  : in    std_logic;      -- Set input
            R  : in    std_logic;      -- Reset input
            Q  : inout std_logic;      -- Output Q
            Qn : inout std_logic       -- Complement of Q
        );
    end component;

    component shift_register_7bit
        port (
            input       : in  std_logic;
            clk         : in  std_logic;
            output      : out std_logic;
            full_output : out std_logic_vector(7 downto 0)
        );
    end component;

    for all: and_2x1 use entity work.and_2x1(Structural);
    for all: and_3x1 use entity work.and_3x1(Structural);
    for all: and_4x1 use entity work.and_4x1(Structural);
    for all: inverter use entity work.inverter(Structural);
    for all: or_2x1 use entity work.or_2x1(Structural);
    for all: or_4x1 use entity work.or_4x1(Structural);
    for all: mux_2x1 use entity work.mux_2x1(Structural);
    for all: dff_negedge use entity work.dff_negedge(Structural);
    for all: shift_register_3bit use entity work.shift_register_3bit(Structural);
    for all: shift_register_19bit use entity work.shift_register_19bit(Structural);
    for all: sr_latch use entity work.sr_latch(Structural);
    for all: shift_register_7bit use entity work.shift_register_7bit(Structural);
    

    signal hit_miss_inv, RW_inv, not_busy, temp_oe_1, temp_oe_2, output_enable_temp, read_miss_count, read_hit_count,
        write_count : std_logic;

    signal read_miss_trigger, read_hit_trigger, set, reset, not_clk, valid_ready, busy_sig, reset_criteria, busy_sig_inv
                                                                                               : std_logic;

    signal write_count_criteria, set_temp, set_temp_2, output_enable_temp_2, output_enable_temp_3, read_miss
                                                                                               : std_logic;

    signal tag_valid_WEn, tag_valid_ready                                                       : std_logic;

    signal mem_addr_out_enable_sig, shift_7_enable                                             : std_logic;

    signal mem_addr_ready, latch_hit_miss, decoder_enable_sig, output_enable_sig, mem_data_read_enable_temp,
        mem_data_read_enable_sig, busy_inv : std_logic;

    signal read_miss_cache_read, RW_temp_1, RW_temp_2, R_W_sig, R_W_inv, mem_data_read_disable : std_logic;

begin

    -- Drives cache_RW low when writing bytes from memory.
    rw_mux: mux_2x1
    port map (
        A           => R_W_sig,
        B           => gnd,
        sel         => mem_data_read_enable_sig,
        output      => cache_RW
    );

    -- and gate for setting the R_W sr latch
    and_for_RW: and_2x1
    port map (
        A           => start,
        B           => R_W,
        output      => RW_temp_1
    );

    -- and gate for resetting the R_W sr latch
    and_for_RW_2: and_2x1
    port map (
        A           => start,
        B           => R_W_inv,
        output      => RW_temp_2
    );

    -- SR latch for hold chip R_W signal
    hold_RW_SR_latch: sr_latch
    port map (
        S           => RW_temp_1,
        R           => RW_temp_2,
        Q           => R_W_sig
    );

    -- and gate for enabling the send of the memory address
    and3_1: and_3x1
    port map (
        A           => valid_ready,
        B           => hit_miss_inv,
        C           => R_W_sig,
        output      => mem_addr_out_enable_sig
    );

    -- inverts hit_miss signal for logical uses
    inverter_1: inverter
    port map (
        input       => hit_miss,
        output      => hit_miss_inv
    );

    -- inverts clk signal for logical uses
    inverter_2: inverter
    port map (
        input       => clk,
        output      => not_clk
    );

    --inverter for chip RW (used in SR latch for hold chip RW signal)
    inverter_RW_in: inverter
    port map (
        input       => R_W,
        output      => R_W_inv
    );

    -- inverter for latched RW
    inverter_3: inverter
    port map (
        input       => R_W_sig,
        output      => RW_inv
    );

    -- checks for read_hit and if timer expired to determine if
    -- output enable should go high

    -- the following nonsense with the output enables just makes sure
    -- it holds for the proper amount of time, feel free to make it better
    or_1: or_2x1
    port map (
        A           => read_hit_count,
        B           => read_miss_count,
        output      => output_enable_temp
    );

    -- checks for a read miss to trigger write enables for valid and tag
    --  sr_latch_2: sr_latch port map(
    --      S => read_miss,
    --      R => busy_sig_inv,
    --      Q => mem_addr_ready
    --  );

    -- sr latch to trigger and hold decoder enable, triggered by high start bit
    sr_latch_3: sr_latch
    port map (
        S           => start,
        R           => reset,
        Q           => decoder_enable_sig,
        Qn          => open
    );

    -- and gate checks for a valid read miss
    and4_1: and_4x1
    port map (
        A           => hit_miss_inv,
        B           => R_W_sig,
        C           => busy_sig,
        D           => valid_ready,
        output      => read_miss
    );

    -- sets up temp logic for set of busy signal SR latch
    and_5: and_2x1
    port map (
        A           => start,
        B           => not_clk,
        output      => set_temp
    );

    -- sets up temp logic for reset of busy signal SR latch
    and_6: and_2x1
    port map (
        A           => start,
        B           => clk,
        output      => reset_criteria
    );

    -- or gate to determine if the function has completed (according to necessary
    -- timing) and sets reset high for busy signal SR_latch
    or4_1: or_4x1
    port map (
        A           => reset_criteria,
        B           => read_miss_count,
        C           => read_hit_count,
        D           => write_count,
        output      => reset
    );

    -- criteria needed to trigger timer for a write operation
    and_7: and_2x1
    port map (
        A           => RW_inv,
        B           => valid_ready,
        output      => write_count_criteria
    );

    -- shift register timer for a write operation. Used to hold busy signal high
    -- for the correct amount of clock signals
    shift_reg_2_0: dff_negedge
    port map (
        d           => write_count_criteria,
        clk         => clk,
        q           => write_count,    -- will be U until propogated out (bcuz counter)
        qbar        => open
    );

    -- shift register timer for a read miss operation. Used to hold busy signal high
    -- for the correct amount of clock signals
    shift_reg_19: shift_register_19bit
    port map (
        input       => read_miss_trigger,
        clk         => clk,
        output      => read_miss_count -- omg also needs to be propogated out, so must wait hella
    );

    -- logical crieteria to getermine if the read miss timer should be started.
    -- checls for a valid miss and a read
    and3_3: and_3x1
    port map (
        A           => valid_ready,
        B           => hit_miss_inv,
        C           => R_W_sig,
        output      => read_miss_trigger
    );

    -- read hit only needs to go high for one clock cycle, so instead of using
    -- a shift register, a simple and gate checks if a read hit has occured and
    -- sends a high signal for only one clock cycle
    and3_4: and_3x1
    port map (
        A           => valid_ready,
        B           => hit_miss,
        C           => R_W_sig,
        output      => read_hit_count
    );

    -- SR latch for busy signal to stay high during operations
    sr_latch_1: sr_latch
    port map (
        S           => set,
        R           => reset,
        Q           => busy_sig,
        Qn          => busy_sig_inv
    );

    -- start and high clock indicates incoming signals are ready to use
    shift_reg_3_2: shift_register_3bit
    port map (
        input       => start,
        clk         => clk,
        output      => valid_ready
    );

    -- set_temp logic all just used to determine when to send busy signal high
    shift_reg_3_3: shift_register_3bit
    port map (
        input       => set_temp,
        clk         => not_clk,
        output      => set_temp_2
    );

    or_2x1_2: or_2x1
    port map (
        A           => set_temp,
        B           => set_temp_2,
        output      => set
    );

    -- shift register to trigger memory data read enable after 8 clk cycles from
    -- mem_addr send enable
    shift_reg_7: shift_register_7bit
    port map (
        input       => shift_7_enable,
        clk         => clk,
        output      => mem_data_read_enable_temp,
        full_output => open
    );

    -- latch to hold mem data read high for the correct timing
    sr_latch_4: sr_latch
    port map (
        S           => mem_data_read_enable_temp,
        R           => mem_data_read_disable,
        Q           => mem_data_read_enable_sig,
        Qn          => open
    );

    -- inverts busy signal for logical use
    inv_5: inverter
    port map (
        input       => busy_sig,
        output      => busy_inv
    );

    -- shift register to disable memory read enable signal after 8 clock cycles
    shift_reg_7_2: shift_register_7bit
    port map (
        input       => mem_data_read_enable_temp,
        clk         => clk,
        output      => mem_data_read_disable,
        full_output => shift_reg_out
    );

    -- triggers shift register to count out 8 cycles after memory address out
    -- enable goes high
    or_3: or_2x1
    port map (
        A           => mem_addr_out_enable_sig,
        B           => reset_in,
        output      => shift_7_enable
    );

    shift_tag_valid: shift_register_3bit
    port map (
        input       => mem_addr_out_enable_sig,
        clk         => clk,
        output      => tag_valid_WEn
    );

    decoder_enable_logic: or_2x1
    port map (
        A           => busy_sig,
        B           => output_enable_temp,
        output      => decoder_enable
    );

    busy                 <= busy_sig;
    output_enable        <= output_enable_temp;
    tag_valid_WE               <= tag_valid_WEn;
    mem_addr_out_enable  <= mem_addr_out_enable_sig;
    mem_data_read_enable <= mem_data_read_enable_sig;

end Structural;
