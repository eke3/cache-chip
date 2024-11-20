library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_shift_byte_mem_data is
    -- Test bench has no ports
end entity tb_shift_byte_mem_data;

architecture test of tb_shift_byte_mem_data is
    -- Component Declaration
    component shift_byte_mem_data is
        port(
            enable   : in  std_logic;
            mem_byte : in  std_logic_vector(7 downto 0);
            clk      : in  std_logic;
            reset:     in std_logic;
            byte_00  : out std_logic_vector(7 downto 0);
            byte_01  : out std_logic_vector(7 downto 0);
            byte_10  : out std_logic_vector(7 downto 0);
            byte_11  : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals for Input and Output
    signal enable   : std_logic := '0';
    signal mem_byte : std_logic_vector(7 downto 0) := (others => '0');
    signal tb_clk   : std_logic := '0'; -- Test bench clock
    signal clk      : std_logic := '1'; -- Negative edge-triggered clock
    signal byte_00  : std_logic_vector(7 downto 0);
    signal byte_01  : std_logic_vector(7 downto 0);
    signal byte_10  : std_logic_vector(7 downto 0);
    signal byte_11  : std_logic_vector(7 downto 0);
    signal reset: std_logic;

    -- Clock Period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: shift_byte_mem_data
        port map(
            enable   => enable,
            mem_byte => mem_byte,
            clk      => clk,
            reset    => reset,
            byte_00  => byte_00,
            byte_01  => byte_01,
            byte_10  => byte_10,
            byte_11  => byte_11
        );

    -- Generate Test Bench Clock (tb_clk)
    tb_clk_process: process
    begin
        while true loop
            tb_clk <= '0';
            wait for clk_period / 2;
            tb_clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Generate Negative Edge-Triggered Clock (clk)
    clk_process: process(tb_clk)
    begin
        clk <= not tb_clk after clk_period / 2;
    end process;

    -- Stimulus Process
    stimulus: process
    begin
        reset<='1';
        wait for clk_period;
        reset<='0';
        wait for clk_period * 10;
        -- Test Case 1: Enable signal is low, no operation
        enable <= '1'; wait for clk_period; enable <= '0';
        mem_byte <= "10101010";
        wait for clk_period*2;
        



        -- Test Case 2: Enable signal high, shift input to bytes
        mem_byte <= "11001100";
        wait for clk_period * 2; -- Hold for 2 clock cycles

        -- Test Case 3: Change mem_byte while enabled
        mem_byte <= "11110000";
        wait for clk_period * 2; -- Hold for 2 clock cycles

        -- Test Case 4: Disable module
        --enable <= '';
        mem_byte <= "00000011";
        wait for clk_period * 2; -- Hold for 2 clock cycles

        -- End Simulation
        wait;
    end process;

end architecture test;