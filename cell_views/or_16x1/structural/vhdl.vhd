-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


architecture Structural of or_16x1 is

    component or_8x1
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
    end component;

    -- Declare the 2x1 OR gate component
    component or_2x1
        port (
            A      : in  STD_LOGIC;                           -- Input A
            B      : in  STD_LOGIC;                           -- Input B
            output : out STD_LOGIC                            -- Output of the OR gate
        );
    end component;

    for or_1, or_2: or_8x1 use entity work.or_8x1(Structural);
    for or_3: or_2x1 use entity work.or_2x1(Structural);

    -- Signals for intermediate connections
    signal or_8x1_out1, or_8x1_out2, or_16x1_out : STD_LOGIC; -- Intermediate signals for OR operations

begin

    or_1: or_8x1
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

    or_2: or_8x1
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

    or_3: or_2x1
    port map (
        A      => or_8x1_out1,
        B      => or_8x1_out2,
        output => or_16x1_out
    );

    output <= or_16x1_out;

end Structural;
