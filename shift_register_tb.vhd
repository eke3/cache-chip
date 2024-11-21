library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_shift_register_bit is
end entity tb_shift_register_bit;

architecture behavior of tb_shift_register_bit is
    -- Component declaration
    component shift_register_bit_2
        port(
            input  : in  std_logic;
            clk    : in  std_logic;
            output : out std_logic
        );
    end component;

    -- Test bench signals
    signal tb_input  : std_logic := '0';
    signal tb_clk    : std_logic := '0';
    signal tb_output : std_logic;

    -- Clock period constant
    constant clk_period : time := 20 ns;
    
begin
    -- Instantiate the shift_register_bit
    uut: entity work.shift_register_bit_2(structural)
        port map (
            input  => tb_input,
            clk    => tb_clk,
            output => tb_output
        );

    -- Clock process
    clk_process: process
    begin
        while true loop
            tb_clk <= '1';
            wait for clk_period / 2;
            tb_clk <= '0';
            wait for clk_period / 2;
        end loop;
    end process clk_process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Initial state
        tb_input <= '0';
        wait for clk_period;
        wait for clk_period;

        -- Apply a series of test inputs
        tb_input <= '1'; wait for clk_period;
        tb_input<='0';
        wait for clk_period;
        wait for clk_period;
        wait for clk_period;
        wait for clk_period;

    end process stimulus_process;
end architecture behavior;

