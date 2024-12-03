-- Entity: tx_6bit
-- Architecture: Structural
-- Author:

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tx_6bit is
    port (
        sel    : in  std_logic; -- Selector signal
        selnot : in  std_logic; -- Inverted selector signal
        input  : in  std_logic_vector(5 downto 0); -- 6-bit input data
        output : out std_logic_vector(5 downto 0) -- 6-bit output data
    );
end tx_6bit;

architecture Structural of tx_6bit is

    component tx
        port (
            sel    : in  std_logic; -- Selector signal
            selnot : in  std_logic; -- Inverted selector signal
            input  : in  std_logic; -- 1-bit input data
            output : out std_logic  -- 1-bit output data
        );
    end component;

    for all: tx use entity work.tx(Structural);

begin

    tx_instance_0: tx
    port map (
        sel    => sel,
        selnot => selnot,
        input  => input(0),
        output => output(0)
    );

    tx_instance_1: tx
    port map (
        sel    => sel,
        selnot => selnot,
        input  => input(1),
        output => output(1)
    );

    tx_instance_2: tx
    port map (
        sel    => sel,
        selnot => selnot,
        input  => input(2),
        output => output(2)
    );

    tx_instance_3: tx
    port map (
        sel    => sel,
        selnot => selnot,
        input  => input(3),
        output => output(3)
    );

    tx_instance_4: tx
    port map (
        sel    => sel,
        selnot => selnot,
        input  => input(4),
        output => output(4)
    );

    tx_instance_5: tx
    port map (
        sel    => sel,
        selnot => selnot,
        input  => input(5),
        output => output(5)
    );

end Structural;
