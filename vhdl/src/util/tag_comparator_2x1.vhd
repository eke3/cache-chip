-- Entity: tag_comparator_2x1
-- Architecture: Structural

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tag_comparator_2x1 is
    port (
        A      : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit input A
        B      : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit input B
        output : out STD_LOGIC -- 1 if A = B, 0 otherwise
    );
end tag_comparator_2x1;

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

