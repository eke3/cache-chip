library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_16x1_8bit is
    port (
        inputs   : in  STD_LOGIC_VECTOR(127 downto 0); -- 16 inputs, each 8-bit wide
        sel      : in  STD_LOGIC_VECTOR(15 downto 0); -- 16-bit 1-hot select signal
        sel_4bit : in  std_logic_vector(3 downto 0);
        output   : out STD_LOGIC_VECTOR(7 downto 0) -- 8-bit output
    );
end mux_16x1_8bit;

architecture Structural of mux_16x1_8bit is

    -- Declare the 16x1 multiplexer and concatenator components
    component mux_16x1
        port (
            inputs      : in  STD_LOGIC_VECTOR(15 downto 0);        -- 16-bit input vector
            sel         : in  STD_LOGIC_VECTOR(3 downto 0);         -- 4-bit select signal
            sel_one_hot : in  std_logic_vector(15 downto 0);        -- 1-hot select signal
            output      : out STD_LOGIC                             -- Output of the multiplexer
        );
    end component;

    component concatenator_8bit
        port (
            in0    : in  std_logic;                                 -- First input bit
            in1    : in  std_logic;                                 -- Second input bit
            in2    : in  std_logic;                                 -- Third input bit
            in3    : in  std_logic;                                 -- Fourth input bit
            in4    : in  std_logic;                                 -- Fifth input bit
            in5    : in  std_logic;                                 -- Sixth input bit
            in6    : in  std_logic;                                 -- Seventh input bit
            in7    : in  std_logic;                                 -- Eighth input bit
            in8    : in  std_logic;                                 -- Ninth input bit
            in9    : in  std_logic;                                 -- Tenth input bit
            in10   : in  std_logic;                                 -- Eleventh input bit
            in11   : in  std_logic;                                 -- Twelfth input bit
            in12   : in  std_logic;                                 -- Thirteenth input bit
            in13   : in  std_logic;                                 -- Fourteenth input bit
            in14   : in  std_logic;                                 -- Fifteenth input bit
            in15   : in  std_logic;                                 -- Sixteenth input bit
            output : out std_logic_vector(15 downto 0)              -- Concatenated 16-bit output
        );
    end component;

    signal bits : std_logic_vector(127 downto 0);

    -- Bind components
    for select_out : mux_16x1 use entity work.mux_16x1(Structural);
    for concat : concatenator_8bit use entity work.concatenator_8bit(Structural);

begin

    -- Generate block for concatenators
    gen_1: for i in 0 to 7 generate
        concat: concatenator_8bit
        port map (
            in0         => inputs(i),
            in1         => inputs(i + 8),
            in2         => inputs(i + 16),
            in3         => inputs(i + 24),
            in4         => inputs(i + 32),
            in5         => inputs(i + 40),
            in6         => inputs(i + 48),
            in7         => inputs(i + 56),
            in8         => inputs(i + 64),
            in9         => inputs(i + 72),
            in10        => inputs(i + 80),
            in11        => inputs(i + 88),
            in12        => inputs(i + 96),
            in13        => inputs(i + 104),
            in14        => inputs(i + 112),
            in15        => inputs(i + 120),
            output      => bits((16 * (i + 1) - 1) downto (16 * i))
        );
    end generate;

    -- Generate block for multiplexers
    gen_2: for i in 0 to 7 generate
        select_out: mux_16x1
        port map (
            inputs      => bits(127 - (16 * i) downto 127 - (16 * i) - 15),
            sel         => sel_4bit,
            sel_one_hot => sel,
            output      => output(7 - i)
        );
    end generate;

end Structural;

