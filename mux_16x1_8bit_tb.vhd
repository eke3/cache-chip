library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1_8bit_tb is
end entity mux_16x1_8bit_tb;

architecture Test of mux_16x1_8bit_tb is
    -- Component Declaration
    component mux_16x1_8bit is
        port (
            inputs   : in  STD_LOGIC_VECTOR(127 downto 0);
            sel      : in  STD_LOGIC_VECTOR(15 downto 0);
            sel_4bit : in  std_logic_vector(3 downto 0);
            output   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component mux_16x1_8bit;

    -- Signals for the testbench
    signal tb_inputs : STD_LOGIC_VECTOR(127 downto 0);
    signal tb_sel    : STD_LOGIC_VECTOR(15 downto 0);
    signal tb_sel_4  : std_logic_vector(3 downto 0);
    signal tb_output : STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Instantiate the DUT (Device Under Test)
    DUT: component mux_16x1_8bit
    port map (
        inputs   => tb_inputs,
        sel      => tb_sel,
        sel_4bit => tb_sel_4,
        output   => tb_output
    );

    -- Stimulus process
    process
    begin
        -- Test Case 1: Select input 0
        tb_inputs <= X"0102030405060708090A0B0C0D0E0F10"; -- 16 inputs, each 8 bits
        tb_sel    <= "0000000000000001";                  -- Select input 0
        tb_sel_4  <= "0001";

        wait for 10 ns;
        assert tb_output = X"01" report "Test Case 1 Failed: Expected output = X'01'" severity error;

        -- Test Case 2: Select input 1
        tb_sel    <= "0000000000000010";                  -- Select input 1
        tb_sel_4  <= "0010";
        wait for 10 ns;
        assert tb_output = X"02" report "Test Case 2 Failed: Expected output = X'02'" severity error;


        -- Test Case 3: Select input 15
        tb_sel    <= "1000000000000000";                  -- Select input 15
        tb_sel_4  <= "1111";
        wait for 10 ns;
        assert tb_output = X"10" report "Test Case 3 Failed: Expected output = X'10'" severity error;

        wait;
    end process;
end architecture Test;
