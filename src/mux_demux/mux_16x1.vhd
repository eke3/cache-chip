library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1 is
    port (
        inputs      : in  STD_LOGIC_VECTOR(15 downto 0); -- 16-bit input vector
        sel         : in  STD_LOGIC_VECTOR(3 downto 0); -- 4-bit select signal
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
    gen_and: for i in 0 to 15 generate
        and_gate: and_2x1
        port map (
            A      => inputs(i),
            B      => sel_one_hot(i),
            output => and_out(i)
        );
    end generate;

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

