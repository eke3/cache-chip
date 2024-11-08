-- decoder_2x4.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_2x4 is
    Port ( A : in STD_LOGIC_VECTOR (1 downto 0);
           E : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end decoder_2x4;

architecture Structural of decoder_2x4 is

    -- Declare the components
    component inverter
        Port ( input : in STD_LOGIC;
               output : out STD_LOGIC);
    end component;

    component and_2x1
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               output : out STD_LOGIC);
    end component;

    -- Intermediate signals
    signal not_A1, not_A0, g, h, i, j : STD_LOGIC;

begin

    -- Instantiate components
    NOT1: inverter port map (input => A(1), output => not_A1);
    NOT0: inverter port map (input => A(0), output => not_A0);
    AND1: and_2x1 port map (A => A(1), B => A(0), output => g);
    AND2: and_2x1 port map (A => A(1), B => not_A0, output => h);
    AND3: and_2x1 port map (A => not_A1, B => A(0), output => i);
    AND4: and_2x1 port map (A => not_A1, B => not_A0, output => j);
    AND5: and_2x1 port map (A => g, B => E, output => Y(3));
    AND6: and_2x1 port map (A => h, B => E, output => Y(2));
    AND7: and_2x1 port map (A => i, B => E, output => Y(1));
    AND8: and_2x1 port map (A => j, B => E, output => Y(0));

end Structural;
