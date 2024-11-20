-- Entity: mux_4x1_one_hot_2bit
-- Architecture: structural

library IEEE;
use IEEE.std_logic_1164.all;

entity mux_4x1_one_hot_2bit is
    port (
        A : in  std_logic_vector(1 downto 0);
        B : in  std_logic_vector(1 downto 0);
        C : in  std_logic_vector(1 downto 0);
        D : in  std_logic_vector(1 downto 0);
        sel : in  std_logic_vector(3 downto 0);
        F : out std_logic_vector(1 downto 0)
    );
end entity mux_4x1_one_hot_2bit;

architecture structural of mux_4x1_one_hot_2bit is
    component mux_4x1_one_hot is
        port (
            A : in  std_logic;
            B : in  std_logic;
            C : in  std_logic;
            D : in  std_logic;
            sel : in  std_logic_vector(3 downto 0);
            F : out std_logic
        );
    end component mux_4x1_one_hot;

    signal result : std_logic_vector(1 downto 0);

begin
    mux_4x1_one_hot_inst: mux_4x1_one_hot
        port map (
            A => A(0),
            B => B(0),
            C => C(0),
            D => D(0),
            sel => sel,
            F => result(0)
        );

    mux_4x1_one_hot_inst2: mux_4x1_one_hot
        port map (
            A => A(1),
            B => B(1),
            C => C(1),
            D => D(1),
            sel => sel,
            F => result(1)
        );

    F <= result;
end architecture structural;