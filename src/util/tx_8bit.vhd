library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tx_8bit is
    port (
        sel    : in  std_logic; -- Selector signal
        selnot : in  std_logic; -- Inverted selector signal
        input  : in  std_logic_vector(7 downto 0); -- 8-bit input data
        output : out std_logic_vector(7 downto 0) -- 8-bit output data
    );
end tx_8bit;

architecture Structural of tx_8bit is

    component tx
        port (
            sel    : in  std_logic;                    -- Selector signal
            selnot : in  std_logic;                    -- Inverted selector signal
            input  : in  std_logic;                    -- 1-bit input data
            output : out std_logic                     -- 1-bit output data
        );
    end component;

    component tx_6bit
        port (
            sel    : in  std_logic;                    -- Selector signal
            selnot : in  std_logic;                    -- Inverted selector signal
            input  : in  std_logic_vector(5 downto 0); -- 6-bit input data
            output : out std_logic_vector(5 downto 0)  -- 6-bit output data
        );
    end component;

    for all: tx_6bit use entity work.tx_6bit(Structural);
    for all: tx use entity work.tx(Structural);

begin

    tx_6bit_inst: tx_6bit
    port map (
        sel        => sel,
        selnot     => selnot,
        input      => input(7 downto 2),
        output     => output(7 downto 2)
    );

    gen_tx: for i in 0 to 1 generate
        tx_instance: tx
        port map (
            sel    => sel,
            selnot => selnot,
            input  => input(i),
            output => output(i)
        );
    end generate;

end Structural;
