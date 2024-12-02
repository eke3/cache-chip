-- decoder_2x4.vhd

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
    gen_inv: for i in 0 to 1 generate
        inv: inverter
        port map (
            input  => A(i),
            output => not_A(i)
        );
    end generate;

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

    gen_and: for i in 0 to 3 generate
        ANDX: and_2x1
        port map (
            A      => and_vec(i),
            B      => E,
            output => Y(i)
        );
    end generate;

end Structural;
