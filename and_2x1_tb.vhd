-- Entity: and_2x1_tb
-- Architecture: Test

library IEEE;
use IEEE.std_logic_1164.all;

entity and_2x1_tb is
end and_2x1_tb;

architecture Test of and_2x1_tb is
    component and_2x1
        port (
            A      : in  std_logic;
            B      : in  std_logic;
            output : out std_logic
        );
    end component and_2x1;

    signal A, B : std_logic;
    signal output : std_logic;
begin
    -- Instantiate the and_2x1 component
    and_2x1_inst : and_2x1
        port map (
            A      => A,
            B      => B,
            output => output
        );

    -- Stimulus process
    stimulus : process
    begin
        A <= 'X'; B <= '0'; wait for 10 ns;
        wait;
    end process stimulus;
end architecture Test;