-- Entity: decoder_2x4
-- Architecture: Structural

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decoder_2x4 is
    port (
        A : in  STD_LOGIC_VECTOR(1 downto 0);
        E : in  STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(3 downto 0)
    );
end decoder_2x4;

architecture Structural of decoder_2x4 is

    -- Declare the components
    component inverter
        port (
            input  : in  STD_LOGIC;
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

    for all: inverter use entity work.inverter(Structural);
    for all: and_2x1 use entity work.and_2x1(Structural);

    -- Intermediate signals
    signal not_A   : STD_LOGIC_VECTOR(1 downto 0);
    signal and_vec : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate components
    inv0: inverter
    port map (
        input  => A(0),
        output => not_A(0)
    );

    inv1: inverter
    port map (
        input  => A(1),
        output => not_A(1)
    );

    AND1: and_2x1
    port map (
        A          => A(1),
        B          => A(0),
        output     => and_vec(3)
    );

    AND2: and_2x1
    port map (
        A          => A(1),
        B          => not_A(0),
        output     => and_vec(2)
    );

    AND3: and_2x1
    port map (
        A          => not_A(1),
        B          => A(0),
        output     => and_vec(1)
    );

    AND4: and_2x1
    port map (
        A          => not_A(1),
        B          => not_A(0),
        output     => and_vec(0)
    );

    and5: and_2x1
    port map (
        A      => and_vec(0),
        B      => E,
        output => Y(0)
    );

    and6: and_2x1
    port map (
        A      => and_vec(1),
        B      => E,
        output => Y(1)
    );

    and7: and_2x1
    port map (
        A      => and_vec(2),
        B      => E,
        output => Y(2)
    );

    and8: and_2x1
    port map (
        A      => and_vec(3),
        B      => E,
        output => Y(3)
    );

end Structural;
