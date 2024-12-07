-- Entity: tb_one_hot_to_binary
-- Architecture: Test
-- Note: Run for 100 ns

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use STD.TEXTIO.all;

entity tb_one_hot_to_binary is
end tb_one_hot_to_binary;

architecture Test of tb_one_hot_to_binary is

    component one_hot_to_binary 
        port (
            one_hot : in  STD_LOGIC_VECTOR(3 downto 0); -- One-hot encoded input
            binary  : out STD_LOGIC_VECTOR(1 downto 0) -- 2-bit binary output
        );
    end component;

    for all: one_hot_to_binary use entity work.one_hot_to_binary(Structural);

    signal one_hot : STD_LOGIC_VECTOR(3 downto 0);
    signal binary  : STD_LOGIC_VECTOR(1 downto 0);

begin

    DUT: one_hot_to_binary
    port map (
        one_hot => one_hot,
        binary  => binary
    );

    stim: process
    begin
        one_hot <= "ZZZZ";
        wait for 10 ns;

        one_hot <= "0001";
        wait for 10 ns;
        assert (binary = "00") report "Test Case 1 failed." severity warning;

        one_hot <= "0010";
        wait for 10 ns;
        assert (binary = "01") report "Test Case 2 failed." severity warning;

        one_hot <= "0100";
        wait for 10 ns;
        assert (binary = "10") report "Test Case 3 failed." severity warning;

        one_hot <= "1000";
        wait for 10 ns;
        assert (binary = "11") report "Test Case 4 failed." severity warning;

        assert false report "Test bench completed." severity failure;
    end process;

end Test;