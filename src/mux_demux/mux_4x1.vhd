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
    signal and_out : STD_LOGIC_VECTOR(3 downto 0);
    -- Intermediate signal for inverted sel bit
    signal sel_not : STD_LOGIC_VECTOR(1 downto 0);
    signal mux_out : std_logic;

begin

    -- Instantiate the inverter to generate sel_not signal
    gen_inverters: for i in 0 to 1 generate
        sel_inverter: entity work.inverter(Structural)
        port map (
            input  => sel(i),
            output => sel_not(i)
        );
    end generate;

    -- Instantiate the and_3x1 gates to enable each read_data input based on sel signal
    and_gate0: entity work.and_3x1(Structural)
    port map (
        A          => read_data0,
        B          => sel_not(1),
        C          => sel_not(0),
        output     => and_out(0)
    );

    and_gate1: entity work.and_3x1(Structural)
    port map (
        A          => read_data1,
        B          => sel_not(1),
        C          => sel(0),
        output     => and_out(1)
    );

    and_gate2: entity work.and_3x1(Structural)
    port map (
        A          => read_data2,
        B          => sel(1),
        C          => sel_not(0),
        output     => and_out(2)
    );

    and_gate3: entity work.and_3x1(Structural)
    port map (
        A          => read_data3,
        B          => sel(1),
        C          => sel(0),
        output     => and_out(3)
    );

    -- Instantiate the or_4x1 gate to combine the outputs of the and gates
    or_gate: entity work.or_4x1(Structural)
    port map (
        A          => and_out(0),
        B          => and_out(1),
        C          => and_out(2),
        D          => and_out(3),
        output     => mux_out
    );

    F <= mux_out;

end architecture Structural;
