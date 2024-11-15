library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity data_input_selector_tb is
end entity;

architecture behavior of data_input_selector_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component data_input_selector
        port(
            cpu_data : in  std_logic_vector(7 downto 0);
            mem_data : in  std_logic_vector(7 downto 0);
            hit_miss : in  std_logic;
            R_W      : in  std_logic;
            out_data : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Testbench Signals
    signal cpu_data : std_logic_vector(7 downto 0) := (others => '0');
    signal mem_data : std_logic_vector(7 downto 0) := (others => '0');
    signal hit_miss : std_logic := '0';
    signal R_W      : std_logic := '0';
    signal out_data : std_logic_vector(7 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: data_input_selector
        port map(
            cpu_data => cpu_data,
            mem_data => mem_data,
            hit_miss => hit_miss,
            R_W      => R_W,
            out_data => out_data
        );

    -- Stimulus Process
    process
    begin
        -- Test Case 1: hit_miss = '0', R_W = '0' (read operation)
        cpu_data <= "10101010";
        mem_data <= "01010101";
        hit_miss <= '0';
        R_W <= '0';
        wait for 10 ns;

        -- Test Case 2: hit_miss = '1', R_W = '0' (read operation)
        hit_miss <= '1';
        R_W <= '0';
        wait for 10 ns;

        -- Test Case 3: hit_miss = '0', R_W = '1' (write operation)
        hit_miss <= '0';
        R_W <= '1';
        wait for 10 ns;

        -- Test Case 4: hit_miss = '1', R_W = '1' (write operation)
        hit_miss <= '1';
        R_W <= '1';
        wait for 10 ns;

        -- Test Case 5: Change input data values and observe output
        cpu_data <= "11110000";
        mem_data <= "00001111";
        hit_miss <= '0';
        R_W <= '0';
        wait for 10 ns;

        -- Test Case 6: hit_miss = '1', R_W = '0' with new data
        hit_miss <= '1';
        wait for 10 ns;

        -- End of test
        wait;
    end process;

end architecture behavior;
