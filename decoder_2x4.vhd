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
    signal not_A1, not_A0, g, h, i, j : STD_LOGIC;

begin

    -- Instantiate components
    NOT1: entity work.inverter
    port map (
        input  => A(1),
        output => not_A1
    );
    NOT0: entity work.inverter
    port map (
        input  => A(0),
        output => not_A0
    );
    AND1: entity work.and_2x1
    port map (
        A      => A(1),
        B      => A(0),
        output => g
    );
    AND2: entity work.and_2x1
    port map (
        A      => A(1),
        B      => not_A0,
        output => h
    );
    AND3: entity work.and_2x1
    port map (
        A      => not_A1,
        B      => A(0),
        output => i
    );
    AND4: entity work.and_2x1
    port map (
        A      => not_A1,
        B      => not_A0,
        output => j
    );
    AND5: entity work.and_2x1
    port map (
        A      => g,
        B      => E,
        output => Y(3)
    );
    AND6: entity work.and_2x1
    port map (
        A      => h,
        B      => E,
        output => Y(2)
    );
    AND7: entity work.and_2x1
    port map (
        A      => i,
        B      => E,
        output => Y(1)
    );
    AND8: entity work.and_2x1
    port map (
        A      => j,
        B      => E,
        output => Y(0)
    );

end architecture Structural;
