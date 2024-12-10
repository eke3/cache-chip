-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


architecture Structural of and_4x1 is
    -- Declare components and intermediate signals
    component and_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component and_3x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for and3: and_3x1 use entity work.and_3x1(Structural);
    for and2: and_2x1 use entity work.and_2x1(Structural);
    -- Intermediate signals
    signal and_abc : STD_LOGIC; -- Intermediate signal for A, B, and C AND

begin
    -- Instantiate the and_3x1 gate to AND A, B, and C
    and3: and_3x1
    port map (
        A      => A,
        B      => B,
        C      => C,
        output => and_abc       -- Intermediate result of A AND B AND C
    );

    -- Instantiate the and_2x1 gate to AND the result of A, B, and C with D
    and2: and_2x1
    port map (
        A      => and_abc,
        B      => D,
        output => output        -- Final result of A AND B AND C AND D
    );

end Structural;
