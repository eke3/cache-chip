--Entity: xor_2x1_2bit
--Architecture: Structural

library IEEE;
use IEEE.std_logic_1164.all;

entity xor_2x1_2bit is
    port (
        A      : in  std_logic_vector(1 downto 0);
        B      : in  std_logic_vector(1 downto 0);
        output : out std_logic_vector(1 downto 0)
    );
end entity xor_2x1_2bit;

architecture Structural of xor_2x1_2bit is
    component xor_2x1 is
        port (
            A      : in  std_logic;
            B      : in  std_logic;
            output : out std_logic
        );
    end component xor_2x1;
begin
    xor0: entity work.xor_2x1(Structural)
    port map (
        A      => A(0),
        B      => B(0),
        output => output(0)
    );
    xor1: entity work.xor_2x1(Structural)
    port map (
        A      => A(1),
        B      => B(1),
        output => output(1)
    );
end architecture Structural;
