library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1 is
    port (
        inputs      : in  STD_LOGIC_VECTOR(15 downto 0); -- 16-bit input vector
        sel_one_hot : in  STD_LOGIC_VECTOR(15 downto 0); -- 1-hot encoded select signal
        output      : out STD_LOGIC -- Output of the multiplexer
    );
end mux_16x1;

architecture Structural of mux_16x1 is

    -- Declare the 2x1 multiplexer component
    component and_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component or_16x1
        port (
            input0  : in  STD_LOGIC;                -- Input 0
            input1  : in  STD_LOGIC;                -- Input 1
            input2  : in  STD_LOGIC;                -- Input 2
            input3  : in  STD_LOGIC;                -- Input 3
            input4  : in  STD_LOGIC;                -- Input 4
            input5  : in  STD_LOGIC;                -- Input 5
            input6  : in  STD_LOGIC;                -- Input 6
            input7  : in  STD_LOGIC;                -- Input 7
            input8  : in  STD_LOGIC;                -- Input 8
            input9  : in  STD_LOGIC;                -- Input 9
            input10 : in  STD_LOGIC;                -- Input 10
            input11 : in  STD_LOGIC;                -- Input 11
            input12 : in  STD_LOGIC;                -- Input 12
            input13 : in  STD_LOGIC;                -- Input 13
            input14 : in  STD_LOGIC;                -- Input 14
            input15 : in  STD_LOGIC;                -- Input 15
            output  : out STD_LOGIC                 -- Single OR output
        );
    end component;

    -- Intermediate signals for the 1-hot encoded AND gates
    signal and_out : STD_LOGIC_VECTOR(15 downto 0); -- For each AND gate's output

    -- Component binding
    for all : and_2x1 use entity work.and_2x1(Structural);
    for all : or_16x1 use entity work.or_16x1(Structural);

begin

    -- Stage 1: 16 AND gates to implement 1-hot selection
    and_gate0: and_2x1
    port map (
        A      => inputs(0),
        B      => sel_one_hot(0),
        output => and_out(0)
    );

    and_gate1: and_2x1
    port map (
        A      => inputs(1),
        B      => sel_one_hot(1),
        output => and_out(1)
    );

    and_gate2: and_2x1
    port map (
        A      => inputs(2),
        B      => sel_one_hot(2),
        output => and_out(2)
    );

    and_gate3: and_2x1
    port map (
        A      => inputs(3),
        B      => sel_one_hot(3),
        output => and_out(3)
    );

    and_gate4: and_2x1
    port map (
        A      => inputs(4),
        B      => sel_one_hot(4),
        output => and_out(4)
    );

    and_gate5: and_2x1
    port map (
        A      => inputs(5),
        B      => sel_one_hot(5),
        output => and_out(5)
    );

    and_gate6: and_2x1
    port map (
        A      => inputs(6),
        B      => sel_one_hot(6),
        output => and_out(6)
    );

    and_gate7: and_2x1
    port map (
        A      => inputs(7),
        B      => sel_one_hot(7),
        output => and_out(7)
    );

    and_gate8: and_2x1
    port map (
        A      => inputs(8),
        B      => sel_one_hot(8),
        output => and_out(8)
    );

    and_gate9: and_2x1
    port map (
        A      => inputs(9),
        B      => sel_one_hot(9),
        output => and_out(9)
    );

    and_gate10: and_2x1
    port map (
        A      => inputs(10),
        B      => sel_one_hot(10),
        output => and_out(10)
    );

    and_gate11: and_2x1
    port map (
        A      => inputs(11),
        B      => sel_one_hot(11),
        output => and_out(11)
    );

    and_gate12: and_2x1
    port map (
        A      => inputs(12),
        B      => sel_one_hot(12),
        output => and_out(12)
    );

    and_gate13: and_2x1
    port map (
        A      => inputs(13),
        B      => sel_one_hot(13),
        output => and_out(13)
    );

    and_gate14: and_2x1
    port map (
        A      => inputs(14),
        B      => sel_one_hot(14),
        output => and_out(14)
    );

    and_gate15: and_2x1
    port map (
        A      => inputs(15),
        B      => sel_one_hot(15),
        output => and_out(15)
    );

    -- Stage 2: OR gate to combine the AND gate outputs
    or_gate: or_16x1
    port map (
        input0     => and_out(0),
        input1     => and_out(1),
        input2     => and_out(2),
        input3     => and_out(3),
        input4     => and_out(4),
        input5     => and_out(5),
        input6     => and_out(6),
        input7     => and_out(7),
        input8     => and_out(8),
        input9     => and_out(9),
        input10    => and_out(10),
        input11    => and_out(11),
        input12    => and_out(12),
        input13    => and_out(13),
        input14    => and_out(14),
        input15    => and_out(15),
        output     => output
    );

end Structural;

