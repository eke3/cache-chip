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
end mux_4x1;

architecture Structural of mux_4x1 is
    -- Component declarations
    component and_3x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component or_4x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            D      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component inverter
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for all: inverter use entity work.inverter(Structural);
    for all: and_3x1 use entity work.and_3x1(Structural);
    for all: or_4x1 use entity work.or_4x1(Structural);

    -- Internal signals
    signal and_out : STD_LOGIC_VECTOR(3 downto 0);
    signal sel_not : STD_LOGIC_VECTOR(1 downto 0);
    signal mux_out : STD_LOGIC;

begin

    -- Instantiate inverters for sel signal
    inv0: inverter
    port map (
        input  => sel(0),
        output => sel_not(0)
    );

    inv1: inverter
    port map (
        input  => sel(1),
        output => sel_not(1)
    );

    -- Instantiate and_3x1 gates for each read_data input
    and_gate0: and_3x1
    port map (
        A          => read_data0,
        B          => sel_not(1),
        C          => sel_not(0),
        output     => and_out(0)
    );

    and_gate1: and_3x1
    port map (
        A          => read_data1,
        B          => sel_not(1),
        C          => sel(0),
        output     => and_out(1)
    );

    and_gate2: and_3x1
    port map (
        A          => read_data2,
        B          => sel(1),
        C          => sel_not(0),
        output     => and_out(2)
    );

    and_gate3: and_3x1
    port map (
        A          => read_data3,
        B          => sel(1),
        C          => sel(0),
        output     => and_out(3)
    );

    -- Instantiate or_4x1 gate to combine outputs from and gates
    or_gate: or_4x1
    port map (
        A          => and_out(0),
        B          => and_out(1),
        C          => and_out(2),
        D          => and_out(3),
        output     => mux_out
    );

    -- Assign mux output to F
    F <= mux_out;

end Structural;

