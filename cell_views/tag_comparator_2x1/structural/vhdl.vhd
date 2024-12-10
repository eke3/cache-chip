-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:58:21 2024


architecture Structural of tag_comparator_2x1 is

    -- Component declarations
    component xnor_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    component and_2x1
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for all: xnor_2x1 use entity work.xnor_2x1(Structural);
    for all: and_2x1 use entity work.and_2x1(Structural);

    -- Component instantiations
    signal bit_equal : STD_LOGIC_VECTOR(1 downto 0);

begin
    -- Compare each bit of A and B using XNOR gates
    U0: xnor_2x1
    port map (
        A      => A(0),
        B      => B(0),
        output => bit_equal(0)
    );

    U1: xnor_2x1
    port map (
        A      => A(1),
        B      => B(1),
        output => bit_equal(1)
    );

    -- AND the results to check if both bits are equal
    U3: and_2x1
    port map (
        A      => bit_equal(1),
        B      => bit_equal(0),
        output => output
    );

end Structural;
