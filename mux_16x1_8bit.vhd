library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1_8bit is
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
        F           : out STD_LOGIC_VECTOR(7 downto 0)   -- 8-bit Output
    );
end entity mux_16x1_8bit;

architecture Structural of mux_16x1_8bit is
    -- Declare the mux_16x1 component for 1-bit selections
    component mux_16x1 is
        port (
            read_data0  : in  STD_LOGIC; -- Input 0
            read_data1  : in  STD_LOGIC; -- Input 1
            read_data2  : in  STD_LOGIC; -- Input 2
            read_data3  : in  STD_LOGIC; -- Input 3
            read_data4  : in  STD_LOGIC; -- Input 4
            read_data5  : in  STD_LOGIC; -- Input 5
            read_data6  : in  STD_LOGIC; -- Input 6
            read_data7  : in  STD_LOGIC; -- Input 7
            read_data8  : in  STD_LOGIC; -- Input 8
            read_data9  : in  STD_LOGIC; -- Input 9
            read_data10 : in  STD_LOGIC; -- Input 10
            read_data11 : in  STD_LOGIC; -- Input 11
            read_data12 : in  STD_LOGIC; -- Input 12
            read_data13 : in  STD_LOGIC; -- Input 13
            read_data14 : in  STD_LOGIC; -- Input 14
            read_data15 : in  STD_LOGIC; -- Input 15
            sel         : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit select signal
            F           : out STD_LOGIC -- Output
        );
    end component;


begin

    -- Instantiate 8 1-bit muxes for each bit of the 8-bit wide output
    mux_bit_0: mux_16x1
    port map (
        read_data0  => read_data0(0),
        read_data1  => read_data1(0),
        read_data2  => read_data2(0),
        read_data3  => read_data3(0),
        read_data4  => read_data4(0),
        read_data5  => read_data5(0),
        read_data6  => read_data6(0),
        read_data7  => read_data7(0),
        read_data8  => read_data8(0),
        read_data9  => read_data9(0),
        read_data10 => read_data10(0),
        read_data11 => read_data11(0),
        read_data12 => read_data12(0),
        read_data13 => read_data13(0),
        read_data14 => read_data14(0),
        read_data15 => read_data15(0),
        sel         => sel,
        F           => F(0)
    );

    mux_bit_1: mux_16x1
    port map (
        read_data0  => read_data0(1),
        read_data1  => read_data1(1),
        read_data2  => read_data2(1),
        read_data3  => read_data3(1),
        read_data4  => read_data4(1),
        read_data5  => read_data5(1),
        read_data6  => read_data6(1),
        read_data7  => read_data7(1),
        read_data8  => read_data8(1),
        read_data9  => read_data9(1),
        read_data10 => read_data10(1),
        read_data11 => read_data11(1),
        read_data12 => read_data12(1),
        read_data13 => read_data13(1),
        read_data14 => read_data14(1),
        read_data15 => read_data15(1),
        sel         => sel,
        F           => F(1)
    );

    mux_bit_2: mux_16x1
    port map (
        read_data0  => read_data0(2),
        read_data1  => read_data1(2),
        read_data2  => read_data2(2),
        read_data3  => read_data3(2),
        read_data4  => read_data4(2),
        read_data5  => read_data5(2),
        read_data6  => read_data6(2),
        read_data7  => read_data7(2),
        read_data8  => read_data8(2),
        read_data9  => read_data9(2),
        read_data10 => read_data10(2),
        read_data11 => read_data11(2),
        read_data12 => read_data12(2),
        read_data13 => read_data13(2),
        read_data14 => read_data14(2),
        read_data15 => read_data15(2),
        sel         => sel,
        F           => F(2)
    );

    mux_bit_3: mux_16x1
    port map (
        read_data0  => read_data0(3),
        read_data1  => read_data1(3),
        read_data2  => read_data2(3),
        read_data3  => read_data3(3),
        read_data4  => read_data4(3),
        read_data5  => read_data5(3),
        read_data6  => read_data6(3),
        read_data7  => read_data7(3),
        read_data8  => read_data8(3),
        read_data9  => read_data9(3),
        read_data10 => read_data10(3),
        read_data11 => read_data11(3),
        read_data12 => read_data12(3),
        read_data13 => read_data13(3),
        read_data14 => read_data14(3),
        read_data15 => read_data15(3),
        sel         => sel,
        F           => F(3)
    );

    mux_bit_4: mux_16x1
    port map (
        read_data0  => read_data0(4),
        read_data1  => read_data1(4),
        read_data2  => read_data2(4),
        read_data3  => read_data3(4),
        read_data4  => read_data4(4),
        read_data5  => read_data5(4),
        read_data6  => read_data6(4),
        read_data7  => read_data7(4),
        read_data8  => read_data8(4),
        read_data9  => read_data9(4),
        read_data10 => read_data10(4),
        read_data11 => read_data11(4),
        read_data12 => read_data12(4),
        read_data13 => read_data13(4),
        read_data14 => read_data14(4),
        read_data15 => read_data15(4),
        sel         => sel,
        F           => F(4)
    );

    mux_bit_5: mux_16x1
    port map (
        read_data0  => read_data0(5),
        read_data1  => read_data1(5),
        read_data2  => read_data2(5),
        read_data3  => read_data3(5),
        read_data4  => read_data4(5),
        read_data5  => read_data5(5),
        read_data6  => read_data6(5),
        read_data7  => read_data7(5),
        read_data8  => read_data8(5),
        read_data9  => read_data9(5),
        read_data10 => read_data10(5),
        read_data11 => read_data11(5),
        read_data12 => read_data12(5),
        read_data13 => read_data13(5),
        read_data14 => read_data14(5),
        read_data15 => read_data15(5),
        sel         => sel,
        F           => F(5)
    );

    mux_bit_6: mux_16x1
    port map (
        read_data0  => read_data0(6),
        read_data1  => read_data1(6),
        read_data2  => read_data2(6),
        read_data3  => read_data3(6),
        read_data4  => read_data4(6),
        read_data5  => read_data5(6),
        read_data6  => read_data6(6),
        read_data7  => read_data7(6),
        read_data8  => read_data8(6),
        read_data9  => read_data9(6),
        read_data10 => read_data10(6),
        read_data11 => read_data11(6),
        read_data12 => read_data12(6),
        read_data13 => read_data13(6),
        read_data14 => read_data14(6),
        read_data15 => read_data15(6),
        sel         => sel,
        F           => F(6)
    );

    mux_bit_7: mux_16x1
    port map (
        read_data0  => read_data0(7),
        read_data1  => read_data1(7),
        read_data2  => read_data2(7),
        read_data3  => read_data3(7),
        read_data4  => read_data4(7),
        read_data5  => read_data5(7),
        read_data6  => read_data6(7),
        read_data7  => read_data7(7),
        read_data8  => read_data8(7),
        read_data9  => read_data9(7),
        read_data10 => read_data10(7),
        read_data11 => read_data11(7),
        read_data12 => read_data12(7),
        read_data13 => read_data13(7),
        read_data14 => read_data14(7),
        read_data15 => read_data15(7),
        sel         => sel,
        F           => F(7)
    );


end architecture Structural;
