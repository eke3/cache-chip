library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1_8bit_tb is
end entity mux_16x1_8bit_tb;

architecture Test of mux_16x1_8bit_tb is
    -- Component Declaration
    component mux_16x1_8bit
        port (
            read_data0  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 0
            read_data1  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 1
            read_data2  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 2
            read_data3  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 3
            read_data4  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 4
            read_data5  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 5
            read_data6  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 6
            read_data7  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 7
            read_data8  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 8
            read_data9  : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 9
            read_data10 : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 10
            read_data11 : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 11
            read_data12 : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 12
            read_data13 : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 13
            read_data14 : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 14
            read_data15 : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit Input 15
            sel         : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit select signal
            F           : out STD_LOGIC_VECTOR(7 downto 0) 
        );
    end component;

    -- Signals for the testbench
    signal data0, data1, data2, data3, data4, data5, data6, data7, data8, data9, data10, data11, data12, data13, data14, data15 : STD_LOGIC_VECTOR(7 downto 0);
    signal sel : STD_LOGIC_VECTOR(3 downto 0);
    signal F : STD_LOGIC_VECTOR(7 downto 0);
begin

    mux: entity work.mux_16x1_8bit(structural)
     port map(
        read_data0 => data0,
        read_data1 => data1,
        read_data2 => data2,
        read_data3 => data3,
        read_data4 => data4,
        read_data5 => data5,
        read_data6 => data6,
        read_data7 => data7,
        read_data8 => data8,
        read_data9 => data9,
        read_data10 => data10,
        read_data11 => data11,
        read_data12 => data12,
        read_data13 => data13,
        read_data14 => data14,
        read_data15 => data15,
        sel => sel,
        F => F
    );

    -- Stimulus process
    process
    begin

        data0 <= X"00";
        data1 <= X"01";
        -- data2 <= X"02";
        -- data3 <= X"03";
        -- data4 <= X"04";
        -- data5 <= X"05";
        -- data6 <= X"06";
        -- data7 <= X"07";
        -- data8 <= X"08";
        -- data9 <= X"09";
        -- data10 <= X"0A";
        -- data11 <= X"0B";
        -- data12 <= X"0C";
        -- data13 <= X"0D";
        -- data14 <= X"0E";
        data15 <= X"0F";

        -- Test Case 1: Select input 0
        sel <= "0000"; -- Select input 0        
        wait for 10 ns;
        assert F = X"00"
            report "Test Case 1 Failed: Expected output = X'00'" severity error;

        -- Test Case 2: Select input 1
        sel <= "0001"; -- Select input 1
        wait for 10 ns;
        assert F = X"01"
            report "Test Case 2 Failed: Expected output = X'01'" severity error;

                    -- Test Case 2: Select input 1
        sel <= "1111"; -- Select input 1
        wait for 10 ns;
        assert F = X"0F"
            report "Test Case 3 Failed: Expected output = X'0F'" severity error;
        wait;
    end process;
end architecture Test;

