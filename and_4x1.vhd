-- Entity: and_4x1
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity and_4x1 is
    port (
        A      : in  STD_LOGIC; -- First input
        B      : in  STD_LOGIC; -- Second input
        C      : in  STD_LOGIC; -- Third input
        D      : in  STD_LOGIC; -- Fourth input
        output : out STD_LOGIC -- Output of the 4-input AND gate
    );
end entity and_4x1;

architecture Structural of and_4x1 is
    -- Declare components and intermediate signals
    component and_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_2x1;

    component and_3x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            C      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_3x1;

    -- Intermediate signals
    signal and_abc : STD_LOGIC; -- Intermediate signal for A, B, and C AND

begin
    -- Instantiate the and_3x1 gate to AND A, B, and C
    and3: entity work.and_3x1(Structural)
    port map (
        A      => A,
        B      => B,
        C      => C,
        output => and_abc       -- Intermediate result of A AND B AND C
    );

    -- Instantiate the and_2x1 gate to AND the result of A, B, and C with D
    and2: entity work.and_2x1(Structural)
    port map (
        A      => and_abc,
        B      => D,
        output => output        -- Final result of A AND B AND C AND D
    );

end architecture Structural;
