library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sr_latch is
    port (
        S  : in    std_logic; -- Set input
        R  : in    std_logic; -- Reset input
        Q  : inout std_logic; -- Output Q
        Qn : inout std_logic -- Complement of Q
    );
end sr_latch;

architecture Structural of sr_latch is

    -- Declare the nor_2x1 component
    component nor_2x1
        port (
            A      : in  std_logic; -- Input A
            B      : in  std_logic; -- Input B
            output : out std_logic  -- NOR output
        );
    end component;

    for nor1, nor2: nor_2x1 use entity work.nor_2x1(Structural);

begin
    -- First NOR gate for Q
    nor1: nor_2x1
    port map (
        A      => R,
        B      => Qn,
        output => Q
    );

    -- Second NOR gate for Qn
    nor2: nor_2x1
    port map (
        A      => S,
        B      => Q,
        output => Qn
    );

end Structural;
