library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sr_latch is
    port (
        S  : in  std_logic; -- Set input
        R  : in  std_logic; -- Reset input
        Q  : inout std_logic; -- Output Q
        Qn : inout std_logic  -- Complement of Q
    );
end entity sr_latch;

architecture structural of sr_latch is

    -- Declare the nor_2x1 component
    component nor_2x1 is
        port (
            A      : in  std_logic; -- Input A
            B      : in  std_logic; -- Input B
            output : out std_logic  -- NOR output
        );
    end component;

    -- Intermediate signals
    signal Q_wire  : std_logic;  -- Internal connection for Q
    signal Qn_wire : std_logic;  -- Internal connection for Qn

begin

    -- First NOR gate for Q
    nor1: entity work.nor_2x1(structural)
        port map (
            A      => R,
            B      => Qn,
            output => Q
        );

    -- Second NOR gate for Qn
    nor2: entity work.nor_2x1(structural)
        port map (
            A      => S,
            B      => Q,
            output => Qn
        );

end architecture structural;
