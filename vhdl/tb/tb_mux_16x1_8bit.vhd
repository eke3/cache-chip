-- Entity: tb_mux_16x1_8bit
-- Architecture: Test
-- Note: Run for 100 ns

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_mux_16x1_8bit is
end tb_mux_16x1_8bit;

architecture Test of tb_mux_16x1_8bit is
    -- Component Declaration
    component mux_16x1_8bit 
        port (
            inputs   : in  STD_LOGIC_VECTOR(127 downto 0);
            sel      : in  STD_LOGIC_VECTOR(15 downto 0);
            output   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    for all: mux_16x1_8bit use entity work.mux_16x1_8bit(Structural);

    -- Signals for the testbench
    signal tb_inputs : STD_LOGIC_VECTOR(127 downto 0);
    signal tb_sel    : STD_LOGIC_VECTOR(15 downto 0);
    signal tb_output : STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Instantiate the DUT (Device Under Test)
    DUT: mux_16x1_8bit
    port map (
        inputs   => tb_inputs,
        sel      => tb_sel,
        output   => tb_output
    );

    -- Stimulus process
    process
    begin
        -- Test Case 1: Select input 0
        tb_inputs <= "00000001000000100000001100000100000001010000011000000111000010000000100100001010000010110000110000001101000011100000111100010000"; -- 16 inputs, each 8 bits
        tb_sel    <= "0000000000000001";                  -- Select input 0

        wait for 10 ns;
        assert tb_output = "00000001" report "Test Case 1 Failed: Expected output = X'01'" severity error;

        -- Test Case 2: Select input 1
        tb_sel    <= "0000000000000010";                  -- Select input 1
        wait for 10 ns;
        assert tb_output = "00000010" report "Test Case 2 Failed: Expected output = X'02'" severity error;


        -- Test Case 3: Select input 15
        tb_sel    <= "1000000000000000";                  -- Select input 15
        wait for 10 ns;
        assert tb_output = "00010000" report "Test Case 3 Failed: Expected output = X'10'" severity error;

        assert false report "Test bench completed." severity failure;
    end process;

end Test;
