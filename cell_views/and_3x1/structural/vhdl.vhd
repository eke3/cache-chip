-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


architecture Structural of and_3x1 is
    -- Declare the and_2x1 component
    component and_2x1 
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;


    for and_gate1, and_gate2: and_2x1 use entity work.and_2x1(Structural);
    -- Intermediate signal to hold the result of the first and_2x1 gate
    signal intermediate : STD_LOGIC;

begin
    -- Instantiate the first and_2x1 gate to AND inputs A and B
    and_gate1: and_2x1
    port map (
        A      => A,
        B      => B,
        output => intermediate
    );

    -- Instantiate the second and_2x1 gate to AND intermediate with C
    and_gate2: and_2x1
    port map (
        A      => intermediate,
        B      => C,
        output => output
    );

end Structural;
