-- Entity: selector
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity selector is
    port (
        chip_enable  : in  std_logic;
        RW           : in  std_logic;
        read_enable  : out std_logic;
        write_enable : out std_logic
    );
end entity selector;

architecture Structural of selector is
    component and_2x1 is
        port (
            A      : in  std_logic;
            B      : in  std_logic;
            output : out std_logic
        );
    end component and_2x1;

    component inverter is
        port (
            input  : in  std_logic;
            output : out std_logic
        );
    end component inverter;

    signal write_inv : std_logic;

begin
    and_1: entity work.and_2x1(Structural)
    port map (
        A      => chip_enable,
        B      => RW,
        output => read_enable
    );

    inverter_1: entity work.inverter(Structural)
    port map (
        input  => RW,
        output => write_inv
    );

    and_2: entity work.and_2x1(Structural)
    port map (
        A      => chip_enable,
        B      => write_inv,
        output => write_enable
    );

end architecture Structural;
