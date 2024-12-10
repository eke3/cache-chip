-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


architecture Structural of xor_2x1 is

    -- Declare components for AND, OR, and NOT gates
    component and_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component or_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component inverter
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for not_A_gate, not_B_gate: inverter use entity work.inverter(Structural);
    for and1_gate, and2_gate: and_2x1 use entity work.and_2x1(Structural);
    for or_gate: or_2x1 use entity work.or_2x1(Structural);

    -- Intermediate signals for AND, OR, and NOT gates
    signal not_A    : STD_LOGIC;
    signal not_B    : STD_LOGIC;
    signal and1_out : STD_LOGIC;
    signal and2_out : STD_LOGIC;
    signal or_out   : STD_LOGIC;

begin
    -- Invert the inputs A and B
    not_A_gate: inverter
    port map (
        input  => A,
        output => not_A
    );

    not_B_gate: inverter
    port map (
        input  => B,
        output => not_B
    );

    -- First AND gate: A AND NOT B
    and1_gate: and_2x1
    port map (
        A      => A,
        B      => not_B,
        output => and1_out
    );

    -- Second AND gate: NOT A AND B
    and2_gate: and_2x1
    port map (
        A      => not_A,
        B      => B,
        output => and2_out
    );

    -- OR gate: (A AND NOT B) OR (NOT A AND B)
    or_gate: or_2x1
    port map (
        A      => and1_out,
        B      => and2_out,
        output => output
    );

end Structural;
