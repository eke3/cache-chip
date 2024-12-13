-- Entity: tb_state_machine
-- Architecture: Test
-- Note: Run for at least 2000 ns

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_state_machine is
end tb_state_machine;

architecture Test of tb_state_machine is

    -- Component declaration for state_machine
    component state_machine
        port (
            gnd                  : in  std_logic;
            clk                  : in  std_logic;
            start                : in  std_logic;
            reset_in             : in  std_logic;
            hit_miss             : in  std_logic;
            R_W                  : in  std_logic;
            cache_RW             : out std_logic;
            tag_valid_WE             : out std_logic;
            decoder_enable       : out std_logic;
            mem_addr_out_enable  : out std_logic;
            mem_data_read_enable : out std_logic;
            busy                 : out std_logic;
            output_enable        : out std_logic;
            shift_reg_out        : out std_logic_vector(7 downto 0)
        );
    end component;

    for all: state_machine use entity work.state_machine(Structural);

    -- Test bench signals
    signal tb_clk                  : std_logic                    := '0';
    signal tb_start                : std_logic                    := '0';
    signal tb_hit_miss             : std_logic                    := '0';
    signal tb_R_W                  : std_logic                    := '0';
    signal tb_cpu_addr             : std_logic_vector(5 downto 0) := (others => '0');
    signal tb_mem_addr_ready       : std_logic                    := '0';
    signal tb_cache_RW             : std_logic;
    signal tb_tag_valid_WE             : std_logic;
    signal tb_decoder_enable       : std_logic;
    signal tb_mem_addr_out_enable  : std_logic;
    signal tb_mem_data_read_enable : std_logic;
    signal tb_busy                 : std_logic;
    signal tb_output_enable        : std_logic;
    signal tb_reset_in             : std_logic;
    signal tb_shift_reg_out        : std_logic_vector(7 downto 0);
    signal gnd : std_logic := '0';

    -- Clock generation process

begin

    -- Instantiate the state_machine
    DUT: state_machine
    port map (
        gnd                  => gnd,
        clk                  => tb_clk,
        start                => tb_start,
        reset_in             => tb_reset_in,
        hit_miss             => tb_hit_miss,
        R_W                  => tb_R_W,
        cache_RW             => tb_cache_RW,
        tag_valid_WE             => tb_tag_valid_WE,
        decoder_enable       => tb_decoder_enable,
        mem_addr_out_enable  => tb_mem_addr_out_enable,
        mem_data_read_enable => tb_mem_data_read_enable,
        busy                 => tb_busy,
        output_enable        => tb_output_enable,
        shift_reg_out        => tb_shift_reg_out
    );

    clk_gen: process
    begin
        tb_clk            <= '0';
        wait for 10 ns;
        tb_clk            <= '1';
        wait for 10 ns;
    end process;
    -- Stimulus process
    stimulus_process: process
    begin
        -- Reset the system
        tb_reset_in       <= '1';
        tb_start          <= '1';
        wait for 30 ns;
        tb_reset_in       <= '0';
        tb_start          <= '0';
        wait for 440 ns;
        tb_start          <= '0';
        tb_hit_miss       <= '0';
        tb_R_W            <= '0';
        tb_cpu_addr       <= (others => '0');
        tb_mem_addr_ready <= '0';
        wait for 20 ns;

        -- read miss
        tb_start          <= '1';
        tb_R_W            <= '1';
        tb_hit_miss       <= '0';
        tb_cpu_addr       <= "001100";
        wait for 20 ns;
        tb_start          <= '0';
        tb_R_W            <= '0';
        wait for 10 ns;
        tb_mem_addr_ready <= '1';
        wait for 510 ns;

        -- Test Case 1: write hit
        tb_start          <= '1';
        tb_R_W            <= '0';
        tb_cpu_addr       <= "101010";
        tb_hit_miss       <= '1';
        wait for 20 ns;
        tb_start          <= '0';
        tb_R_W            <= '0';
        wait for 100 ns;

        -- Test Case 2: read hit
        tb_start          <= '1';
        tb_R_W            <= '1';
        tb_cpu_addr       <= "101010";
        wait for 20 ns;
        tb_start          <= '0';
        tb_R_W            <= '0';
        wait for 100 ns;

        -- test case: write miss
        tb_start          <= '1';
        tb_R_W            <= '0';
        tb_hit_miss       <= '0';
        tb_cpu_addr       <= "001100";
        wait for 20 ns;
        tb_start          <= '0';
        tb_R_W            <= '0';
        wait for 100 ns;

        tb_mem_addr_ready <= '0';

        tb_start          <= '1';
        tb_R_W            <= '0';
        tb_hit_miss       <= '0';
        tb_cpu_addr       <= "001100";
        wait for 20 ns;
        tb_start          <= '0';
        tb_R_W            <= '0';
        wait for 100 ns;

        -- read miss
        tb_start          <= '1';
        tb_R_W            <= '1';
        tb_hit_miss       <= '0';
        tb_cpu_addr       <= "001100";
        wait for 20 ns;
        tb_start          <= '0';
        tb_R_W            <= '0';
        wait for 10 ns;
        tb_mem_addr_ready <= '1';
        wait for 500 ns;

        -- End simulation
        assert false report "Simulation completed" severity warning;
	wait;
    end process;

end Test;
