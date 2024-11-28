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

    -- Declare the 2x1 OR gate component
    component or_2x1 is
        port (
            A      : in  STD_LOGIC;               -- Input A
            B      : in  STD_LOGIC;               -- Input B
            output : out STD_LOGIC                -- Output of the OR gate
        );
    end component or_2x1;

    -- Signals for intermediate connections
    signal level1 : STD_LOGIC_VECTOR(7 downto 0); -- First stage (8 OR gates)
    signal level2 : STD_LOGIC_VECTOR(3 downto 0); -- Second stage (4 OR gates)
    signal level3 : STD_LOGIC_VECTOR(1 downto 0); -- Third stage (2 OR gates)
    signal level4 : STD_LOGIC;                    -- Final OR gate output

begin

    -- Stage 1: Combine pairs of inputs using 8 OR gates
    or_gate1: entity work.or_2x1(Structural)
    port map (
        A      => input0,
        B      => input1,
        output => level1(0)
    );

    or_gate2: entity work.or_2x1(Structural)
    port map (
        A      => input2,
        B      => input3,
        output => level1(1)
    );

    or_gate3: entity work.or_2x1(Structural)
    port map (
        A      => input4,
        B      => input5,
        output => level1(2)
    );

    or_gate4: entity work.or_2x1(Structural)
    port map (
        A      => input6,
        B      => input7,
        output => level1(3)
    );

    or_gate5: entity work.or_2x1(Structural)
    port map (
        A      => input8,
        B      => input9,
        output => level1(4)
    );

    or_gate6: entity work.or_2x1(Structural)
    port map (
        A      => input10,
        B      => input11,
        output => level1(5)
    );

    or_gate7: entity work.or_2x1(Structural)
    port map (
        A      => input12,
        B      => input13,
        output => level1(6)
    );

    or_gate8: entity work.or_2x1(Structural)
    port map (
        A      => input14,
        B      => input15,
        output => level1(7)
    );

    -- Stage 2: Combine results from Stage 1 using 4 OR gates
    or_gate9: entity work.or_2x1(Structural)
    port map (
        A      => level1(0),
        B      => level1(1),
        output => level2(0)
    );

    or_gate10: entity work.or_2x1(Structural)
    port map (
        A      => level1(2),
        B      => level1(3),
        output => level2(1)
    );

    or_gate11: entity work.or_2x1(Structural)
    port map (
        A      => level1(4),
        B      => level1(5),
        output => level2(2)
    );

    or_gate12: entity work.or_2x1(Structural)
    port map (
        A      => level1(6),
        B      => level1(7),
        output => level2(3)
    );

    -- Stage 3: Combine results from Stage 2 using 2 OR gates
    or_gate13: entity work.or_2x1(Structural)
    port map (
        A      => level2(0),
        B      => level2(1),
        output => level3(0)
    );

    or_gate14: entity work.or_2x1(Structural)
    port map (
        A      => level2(2),
        B      => level2(3),
        output => level3(1)
    );

    -- Stage 4: Combine results from Stage 3 using 1 OR gate
    or_gate15: entity work.or_2x1(Structural)
    port map (
        A      => level3(0),
        B      => level3(1),
        output => level4
    );

    -- Assign the final output
    output <= level4;

end architecture Structural;
