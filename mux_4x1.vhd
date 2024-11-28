-- Entity: mux_4x1
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_4x1 is
    port (
        read_data0 : in  STD_LOGIC; -- Input 0
        read_data1 : in  STD_LOGIC; -- Input 1
        read_data2 : in  STD_LOGIC; -- Input 2
        read_data3 : in  STD_LOGIC; -- Input 3
        sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit sel signal
        F          : out STD_LOGIC -- Output of the multiplexer
    );
end entity mux_4x1;

architecture Structural of mux_4x1 is
    -- Declare the and_3x1 component
    component and_3x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_3x1;

    -- Declare the or_4x1 component
    component or_4x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            D      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_4x1;

    -- Declare the inverter component
    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    -- Intermediate signals for outputs of the 4 and_3x1 gates
    signal and_out0, and_out1, and_out2, and_out3 : STD_LOGIC;
    -- Intermediate signal for inverted sel bit
    signal sel_not0, sel_not1                     : STD_LOGIC;
    signal outline :std_logic;


    for sel_inverter0, sel_inverter1: inverter use entity work.inverter(Structural);
    for and_gate0, and_gate1, and_gate2, and_gate3: and_3x1 use entity work.and_3x1(Structural);
    for or_gate: or_4x1 use entity work.or_4x1(Structural);

begin

    -- Instantiate the inverter to generate sel_not signal
    sel_inverter0: component inverter
    port map (
        input  => sel(0),
        output => sel_not0
    );

    sel_inverter1: component inverter
    port map (
        input  => sel(1),
        output => sel_not1
    );

    -- Instantiate the and_3x1 gates to enable each read_data input based on sel signal
    and_gate0: component and_3x1
    port map (
        A      => read_data0,
        B      => sel_not1,
        C      => sel_not0,
        output => and_out0
    );

    and_gate1: component and_3x1
    port map (
        A      => read_data1,
        B      => sel_not1,
        C      => sel(0),
        output => and_out1
    );

    and_gate2: component and_3x1
    port map (
        A      => read_data2,
        B      => sel(1),
        C      => sel_not0,
        output => and_out2
    );

    and_gate3: component and_3x1
    port map (
        A      => read_data3,
        B      => sel(1),
        C      => sel(0),
        output => and_out3
    );

    -- Instantiate the or_4x1 gate to combine the outputs of the and gates
    or_gate: component or_4x1
    port map (
        A      => and_out0,
        B      => and_out1,
        C      => and_out2,
        D      => and_out3,
        output => outline
    );
    
    F <= outline;

end architecture Structural;

