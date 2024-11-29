library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity or_16x1 is
    port (
        input0  : in  STD_LOGIC; -- Input 0
        input1  : in  STD_LOGIC; -- Input 1
        input2  : in  STD_LOGIC; -- Input 2
        input3  : in  STD_LOGIC; -- Input 3
        input4  : in  STD_LOGIC; -- Input 4
        input5  : in  STD_LOGIC; -- Input 5
        input6  : in  STD_LOGIC; -- Input 6
        input7  : in  STD_LOGIC; -- Input 7
        input8  : in  STD_LOGIC; -- Input 8
        input9  : in  STD_LOGIC; -- Input 9
        input10 : in  STD_LOGIC; -- Input 10
        input11 : in  STD_LOGIC; -- Input 11
        input12 : in  STD_LOGIC; -- Input 12
        input13 : in  STD_LOGIC; -- Input 13
        input14 : in  STD_LOGIC; -- Input 14
        input15 : in  STD_LOGIC; -- Input 15
        output  : out STD_LOGIC -- Single OR output
    );
end entity or_16x1;

architecture Structural of or_16x1 is

    component or_8x1 is
        port (
            A      : in  STD_LOGIC;                           -- Input A
            B      : in  STD_LOGIC;                           -- Input B
            C      : in  STD_LOGIC;                           -- Input C
            D      : in  STD_LOGIC;                           -- Input D
            E      : in  STD_LOGIC;                           -- Input E
            F      : in  STD_LOGIC;                           -- Input F
            G      : in  STD_LOGIC;                           -- Input G
            H      : in  STD_LOGIC;                           -- Input H
            output : out STD_LOGIC                            -- Output of the OR gate
        );
    end component or_8x1;

    -- Declare the 2x1 OR gate component
    component or_2x1 is
        port (
            A      : in  STD_LOGIC;                           -- Input A
            B      : in  STD_LOGIC;                           -- Input B
            output : out STD_LOGIC                            -- Output of the OR gate
        );
    end component or_2x1;

    -- Signals for intermediate connections
    signal or_8x1_out1, or_8x1_out2, or_16x1_out : STD_LOGIC; -- Intermediate signals for OR operations

begin

    or_1: entity work.or_8x1(Structural)
    port map (
        A      => input0,
        B      => input1,
        C      => input2,
        D      => input3,
        E      => input4,
        F      => input5,
        G      => input6,
        H      => input7,
        output => or_8x1_out1
    );

    or_2: entity work.or_8x1(Structural)
    port map (
        A      => input8,
        B      => input9,
        C      => input10,
        D      => input11,
        E      => input12,
        F      => input13,
        G      => input14,
        H      => input15,
        output => or_8x1_out2
    );

    or_3: entity work.or_2x1(Structural)
    port map (
        A      => or_8x1_out1,
        B      => or_8x1_out2,
        output => or_16x1_out
    );

    output <= or_16x1_out;

end architecture Structural;
