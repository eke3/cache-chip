-- Entity: or_4x1_2bit
-- Architecture: Structural

library IEEE;
use IEEE.std_logic_1164.all;

entity or_4x1_2bit is
    port (
        A      : in  std_logic_vector(1 downto 0);
        B      : in  std_logic_vector(1 downto 0);
        C      : in  std_logic_vector(1 downto 0);
        D      : in  std_logic_vector(1 downto 0);
        output : out std_logic_vector(1 downto 0)
    );
end or_4x1_2bit;

architecture Structural of or_4x1_2bit is

    component or_4x1
        port (
            A      : in  std_logic;
            B      : in  std_logic;
            C      : in  std_logic;
            D      : in  std_logic;
            output : out std_logic
        );
    end component;

    for all: or_4x1 use entity work.or_4x1(Structural);

begin

    u_or0: or_4x1
    port map (
        A(0),
        B(0),
        C(0),
        D(0),
        output(0)
    );

    u_or1: or_4x1
    port map (
        A(1),
        B(1),
        C(1),
        D(1),
        output(1)
    );

end Structural;
