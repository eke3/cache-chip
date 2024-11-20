library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1 is
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
end entity mux_16x1;

architecture Structural of mux_16x1 is
    -- Declare the mux_4x1 component
    component mux_4x1 is
        port (
            read_data0 : in  STD_LOGIC;
            read_data1 : in  STD_LOGIC;
            read_data2 : in  STD_LOGIC;
            read_data3 : in  STD_LOGIC;
            sel        : in  STD_LOGIC_VECTOR(1 downto 0);
            F          : out STD_LOGIC
        );
    end component mux_4x1;

    -- Intermediate signals for the outputs of the first layer of mux_4x1
    signal mux_layer1_out0, mux_layer1_out1, mux_layer1_out2, mux_layer1_out3 : STD_LOGIC;

begin

    -- Instantiate the first layer of mux_4x1 to select groups of 4 inputs
    mux_layer1_0: mux_4x1
    port map (
        read_data0 => read_data0,
        read_data1 => read_data1,
        read_data2 => read_data2,
        read_data3 => read_data3,
        sel        => sel(1 downto 0),
        F          => mux_layer1_out0
    );

    mux_layer1_1: mux_4x1
    port map (
        read_data0 => read_data4,
        read_data1 => read_data5,
        read_data2 => read_data6,
        read_data3 => read_data7,
        sel        => sel(1 downto 0),
        F          => mux_layer1_out1
    );

    mux_layer1_2: mux_4x1
    port map (
        read_data0 => read_data8,
        read_data1 => read_data9,
        read_data2 => read_data10,
        read_data3 => read_data11,
        sel        => sel(1 downto 0),
        F          => mux_layer1_out2
    );

    mux_layer1_3: mux_4x1
    port map (
        read_data0 => read_data12,
        read_data1 => read_data13,
        read_data2 => read_data14,
        read_data3 => read_data15,
        sel        => sel(1 downto 0),
        F          => mux_layer1_out3
    );

    -- Instantiate the second layer of mux_4x1 to select from the outputs of the first layer
    mux_layer2: mux_4x1
    port map (
        read_data0 => mux_layer1_out0,
        read_data1 => mux_layer1_out1,
        read_data2 => mux_layer1_out2,
        read_data3 => mux_layer1_out3,
        sel        => sel(3 downto 2),
        F          => F
    );

end architecture Structural;
