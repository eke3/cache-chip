-- Entity: mux_4x1_one_hot
-- Architecture: Structural

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_4x1_one_hot is
    port (
        A   : in  std_logic;
        B   : in  std_logic;
        C   : in  std_logic;
        D   : in  std_logic;
        sel : in  std_logic_vector(3 downto 0);
        F   : out std_logic
    );
end entity mux_4x1_one_hot;

architecture Structural of mux_4x1_one_hot is
    component and_2x1 is
        port (
            A      : in  std_logic;
            B      : in  std_logic;
            output : out std_logic
        );
    end component and_2x1;

    component or_4x1 is
        port (
            A      : in  std_logic;
            B      : in  std_logic;
            C      : in  std_logic;
            D      : in  std_logic;
            output : out std_logic
        );
    end component or_4x1;

    signal and1_out, and2_out, and3_out, and4_out : std_logic;
    signal or_out                                 : std_logic;

begin
    and1: entity work.and_2x1(Structural)
    port map (
        A      => sel(3),
        B      => A,
        output => and1_out
    );
    and2: entity work.and_2x1(Structural)
    port map (
        A      => sel(2),
        B      => B,
        output => and2_out
    );
    and3: entity work.and_2x1(Structural)
    port map (
        A      => sel(1),
        B      => C,
        output => and3_out
    );
    and4: entity work.and_2x1(Structural)
    port map (
        A      => sel(0),
        B      => D,
        output => and4_out
    );

    or1: entity work.or_4x1(Structural)
    port map (
        A      => and1_out,
        B      => and2_out,
        C      => and3_out,
        D      => and4_out,
        output => or_out
    );

    F <= or_out;

end architecture Structural;
