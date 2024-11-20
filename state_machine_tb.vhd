library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_state_machine is
end entity tb_state_machine;

architecture behavior of tb_state_machine is

    -- Component declaration for state_machine
    component state_machine is
        port(
            clk: in std_logic;
            start: in std_logic;
            hit_miss: in std_logic;
            R_W: in std_logic;
            cpu_addr: in std_logic_vector(7 downto 0);
            mem_addr_ready: in std_logic;
            cache_RW: out std_logic;
            valid_WE: out std_logic;
            tag_WE: out std_logic;
            decoder_enable: out std_logic;
            mem_addr_out_enable: out std_logic;
            data_mux_enable: out std_logic;
            busy: out std_logic;
            output_enable: out std_logic
        );
    end component;

    -- Test bench signals
    signal tb_clk               : std_logic := '0';
    signal tb_start             : std_logic := '0';
    signal tb_hit_miss          : std_logic := '0';
    signal tb_R_W               : std_logic := '0';
    signal tb_cpu_addr          : std_logic_vector(7 downto 0) := (others => '0');
    signal tb_mem_addr_ready    : std_logic := '0';
    signal tb_cache_RW          : std_logic;
    signal tb_valid_RW          : std_logic;
    signal tb_tag_RW            : std_logic;
    signal tb_decoder_enable    : std_logic;
    signal tb_mem_addr_out_enable : std_logic;
    signal tb_data_mux_enable   : std_logic;
    signal tb_busy              : std_logic;
    signal tb_output_enable     : std_logic;

    -- Clock generation process

begin

    -- Instantiate the state_machine
    uut: state_machine port map (
            clk => tb_clk,
            start => tb_start,
            hit_miss => tb_hit_miss,
            R_W => tb_R_W,
            cpu_addr => tb_cpu_addr,
            mem_addr_ready => tb_mem_addr_ready,
            cache_RW => tb_cache_RW,
            valid_WE => tb_valid_RW,
            tag_WE => tb_tag_RW,
            decoder_enable => tb_decoder_enable,
            mem_addr_out_enable => tb_mem_addr_out_enable,
            data_mux_enable => tb_data_mux_enable,
            busy => tb_busy,
            output_enable => tb_output_enable
     );

    clk_gen: process
    begin
        tb_clk <= '0';
        wait for 10 ns;
        tb_clk <= '1';
        wait for 10 ns;
    end process;
    -- Stimulus process
    stimulus_process: process
    begin
        -- Reset the system
        wait for 480 ns;
        tb_start <= '0';
        tb_hit_miss <= '0';
        tb_R_W <= '0';
        tb_cpu_addr <= (others => '0');
        tb_mem_addr_ready <= '0';
        wait for 10 ns;

        -- Test Case 1: write hit
        tb_start <= '1';
        tb_R_W <= '0';
        tb_cpu_addr <= "10101010";
        tb_hit_miss <= '1';
        wait for 20 ns; tb_start <='0';
        wait for 100 ns;

        -- Test Case 2: read hit
        tb_start <= '1';
        tb_R_W <= '1';
        tb_cpu_addr <= "10101010";
        wait for 20 ns; tb_start <='0';
        wait for 100 ns;

        -- test case: write miss
        tb_start <= '1';
        tb_R_W <= '0';
        tb_hit_miss <= '0';
        tb_cpu_addr <= "11001100";
        wait for 20 ns; tb_start <='0';
        wait for 100 ns;

        tb_mem_addr_ready <= '0';
        
        tb_start <= '1';
        tb_R_W <= '0';
        tb_hit_miss <= '0';
        tb_cpu_addr <= "11001100";
        wait for 20 ns; tb_start <='0';
        wait for 100 ns;

         -- read miss
        tb_start <= '1';
        tb_R_W <= '1';
        tb_hit_miss <= '0';
        tb_cpu_addr <= "11001100";
        wait for 20 ns; tb_start <='0';
        wait for 10 ns; tb_mem_addr_ready <= '1';
        wait for 500 ns;


        -- End simulation
        assert false report "Simulation completed" severity note;
        wait;
    end process stimulus_process;

end architecture behavior;
