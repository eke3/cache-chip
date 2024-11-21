-- Entity: mux_4x1_one_hot_2bit_tb
-- Architecture: Test

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_4x1_one_hot_2bit_tb is
end mux_4x1_one_hot_2bit_tb;

architecture Test of mux_4x1_one_hot_2bit_tb is
    component mux_4x1_one_hot_2bit is
        port (
            A : in  std_logic_vector(1 downto 0);
            B : in  std_logic_vector(1 downto 0);
            C : in  std_logic_vector(1 downto 0);
            D : in  std_logic_vector(1 downto 0);
            sel : in  std_logic_vector(3 downto 0);
            F : out std_logic_vector(1 downto 0)
        );
    end component mux_4x1_one_hot_2bit;

    signal A : std_logic_vector(1 downto 0);
    signal B : std_logic_vector(1 downto 0);
    signal C : std_logic_vector(1 downto 0);
    signal D : std_logic_vector(1 downto 0);
    signal sel : std_logic_vector(3 downto 0);
    signal output : std_logic_vector(1 downto 0);
begin
    -- instantiate mux_4x1_one_hot_2bit
    mux_4x1_one_hot_2bit0: entity work.mux_4x1_one_hot_2bit(structural)
        port map (
            A => A,
            B => B,
            C => C,
            D => D,
            sel => sel,
            F => output
        );

    stimulus: process
    begin
        A <= "00";
        B <= "01";
        C <= "10";
        D <= "11";
        sel <= "1000";
        wait for 10 ns;
        sel <= "0100";
        wait for 10 ns;
        sel <= "0010";
        wait for 10 ns;
        sel <= "0001";
        wait for 10 ns;
        wait;
    end process stimulus;
end architecture Test;
