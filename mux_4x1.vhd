-- Entity: mux_4x1
-- Architecture: structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4x1 is
    Port (
        read_data0 : in STD_LOGIC;    -- Input 0
        read_data1 : in STD_LOGIC;    -- Input 1
        read_data2 : in STD_LOGIC;    -- Input 2
        read_data3 : in STD_LOGIC;    -- Input 3
        sel     : in STD_LOGIC_VECTOR(1 downto 0); -- 2-bit sel signal
        F          : out STD_LOGIC    -- Output of the multiplexer
    );
end mux_4x1;

architecture Structural of mux_4x1 is
    -- Declare the and_3x1 component
    component and_3x1
        Port (
            A       : in STD_LOGIC;
            B       : in STD_LOGIC;
            C       : in STD_LOGIC;
            output  : out STD_LOGIC
        );
    end component;

    -- Declare the or_4x1 component
    component or_4x1
        Port (
            A       : in STD_LOGIC;
            B       : in STD_LOGIC;
            C       : in STD_LOGIC;
            D       : in STD_LOGIC;
            output  : out STD_LOGIC
        );
    end component;

    -- Intermediate signals for outputs of the 4 and_3x1 gates
    signal and_out0, and_out1, and_out2, and_out3 : STD_LOGIC;
    -- Intermediate signals for inverted sel bits
    signal sel_not0, sel_not1 : STD_LOGIC;

begin
    -- Generate inverted sel signals
    sel_not0 <= not sel(0);
    sel_not1 <= not sel(1);

    -- Instantiate the and_3x1 gates to enable each read_data input based on sel signal
    and_gate0: and_3x1 port map (
        A       => read_data0,
        B       => sel_not1,
        C       => sel_not0,
        output  => and_out0
    );

    and_gate1: and_3x1 port map (
        A       => read_data1,
        B       => sel_not1,
        C       => sel(0),
        output  => and_out1
    );

    and_gate2: and_3x1 port map (
        A       => read_data2,
        B       => sel(1),
        C       => sel_not0,
        output  => and_out2
    );

    and_gate3: and_3x1 port map (
        A       => read_data3,
        B       => sel(1),
        C       => sel(0),
        output  => and_out3
    );

    -- Instantiate the or_4x1 gate to combine the outputs of the and gates
    or_gate: or_4x1 port map (
        A       => and_out0,
        B       => and_out1,
        C       => and_out2,
        D       => and_out3,
        output  => F
    );

end Structural;
