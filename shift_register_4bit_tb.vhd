-- Entity: shift_register_4bit_tb
-- Architecture: Test

library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_4bit_tb is
end shift_register_4bit_tb;

architecture Test of shift_register_4bit_tb is
    component shift_register_4bit is
        port (
            d : in  std_logic;
            clk : in  std_logic;
            reset : in  std_logic;
            q : out std_logic_vector(3 downto 0)
        );
    end component shift_register_4bit;

    signal d : std_logic;
    signal clk, reset : std_logic;
    signal q : std_logic_vector(3 downto 0);

begin
    -- instantiate shift_register_4bit
    shift_register_4bit0: entity work.shift_register_4bit(structural)
        port map (
            d   => d,
            clk => clk,
            reset => reset,
            q   => q
        );

    stim: process 
    begin
        reset <= '1';
        clk <= '1'; -- shifter_enable is low and system clock high
        d <= '1'; -- load_shifter is 0, selects a 0
        wait for 10 ns;

        clk <= '0'; -- system clock goes low
        reset <= '0';
        wait for 10 ns;

        clk <= '1'; -- system clock goes high
        wait for 10 ns;
        
        clk <= '0';
        d <= '0';
        wait for 10 ns;
        
        clk <= '1';
        wait for 10 ns;


        clk <= '0'; -- shifter_enable goes high and system clock goes low (1st edge shifter enable is high)
--        d <= '1'; -- mux chooses one for one clock cycle, as load_shifter and shifter_enable go high at the same time
        wait for 10 ns;

        d <= '0'; -- load_shifter goes low
        clk <= '1'; -- system clock goes high, shifter_enable stays high 
        wait for 10 ns;

        clk <= '0'; -- system clock goes low, shifter_enable stays high (2nd negedge shifter enable is high)
        wait for 10 ns;

        clk <= '1'; -- system clock goes high, shifter_enable stays high 
        wait for 10 ns;

        clk <= '0'; -- system clock goes low, shifter_enable stays high (3rd negedge shifter enable is high)
        wait for 10 ns;
        
        clk <= '1'; -- system clock goes high, shifter_enable stays high
        wait for 10 ns;
        
        clk <= '0'; -- system clock goes low, shifter_enable stays high (4th negedge shifter enable is high)
        wait for 10 ns;
        
        clk <= '1'; -- system clock goes high, shifter enable goes low
        wait for 10 ns;
        
        wait;
        
    end process stim;
end architecture Test;
