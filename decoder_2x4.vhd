-- decoder_2x4.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity decoder_2x4 is
    port (
        A : in  STD_LOGIC_VECTOR(1 downto 0);
        E : in  STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity decoder_2x4;

architecture Structural of decoder_2x4 is

    -- Declare the components
    component inverter is
        port (
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component inverter;

    component and_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component and_2x1;

    -- Intermediate signals
    signal not_A1, not_A0 : STD_LOGIC;
    signal and_vec        : STD_LOGIC_VECTOR(3 downto 0);

begin

    -- Instantiate components
    NOT1: entity work.inverter(Structural)
    port map (
        input      => A(1),
        output     => not_A1
    );

    NOT0: entity work.inverter(Structural)
    port map (
        input      => A(0),
        output     => not_A0
    );

    AND1: entity work.and_2x1(Structural)
    port map (
        A          => A(1),
        B          => A(0),
        output     => and_vec(3)
    );

    AND2: entity work.and_2x1(Structural)
    port map (
        A          => A(1),
        B          => not_A0,
        output     => and_vec(2)
    );

    AND3: entity work.and_2x1(Structural)
    port map (
        A          => not_A1,
        B          => A(0),
        output     => and_vec(1)
    );

    AND4: entity work.and_2x1(Structural)
    port map (
        A          => not_A1,
        B          => not_A0,
        output     => and_vec(0)
    );

    gen_and: for i in 0 to 3 generate
        ANDX: entity work.and_2x1(Structural)
        port map (
            A      => and_vec(i),
            B      => E,
            output => Y(i)
        );
    end generate;

end architecture Structural;
