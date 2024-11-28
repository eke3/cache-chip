-- Entity: shift_byte_mem_data.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity shift_byte_mem_data is
    port (
        vdd         : in  std_logic;
        gnd         : in  std_logic;
        enable      : in  std_logic;
        reset       : in  std_logic;
        mem_byte    : in  std_logic_vector(7 downto 0);
        clk         : in  std_logic;
        byte_offset : out std_logic_vector(1 downto 0);
        byte_00     : out std_logic_vector(7 downto 0);
        byte_01     : out std_logic_vector(7 downto 0);
        byte_10     : out std_logic_vector(7 downto 0);
        byte_11     : out std_logic_vector(7 downto 0)
    );
end entity shift_byte_mem_data;

architecture Structural of shift_byte_mem_data is

    component shift_register_bit_8 is
        port (
            vdd            : in  std_logic;
            gnd            : in  std_logic;
            input          : in  std_logic;
            clk            : in  std_logic;
            output         : out std_logic;
            addr_en_encode : out std_logic_vector(3 downto 0)
        );
    end component shift_register_bit_8;

    component demux_1x4_8bit is
        port (
            data_in    : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input data
            sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector
            data_out_0 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "00"
            data_out_1 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "01"
            data_out_2 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "10"
            data_out_3 : out STD_LOGIC_VECTOR(7 downto 0)  -- 8-bit output for selection "11"
        );
    end component demux_1x4_8bit;

    component one_hot_to_binary is
        port (
            one_hot : in  STD_LOGIC_VECTOR(3 downto 0);    -- One-hot encoded input
            binary  : out STD_LOGIC_VECTOR(1 downto 0)     -- 2-bit binary output
        );
    end component one_hot_to_binary;

    component or_2x1 is
        port (
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_2x1;

    component mux_2x1 is
        port (
            A      : in  STD_LOGIC;                        -- Input 0
            B      : in  STD_LOGIC;                        -- Input 1
            sel    : in  STD_LOGIC;                        -- sel signal
            output : out STD_LOGIC                         -- Output of the multiplexer
        );
    end component mux_2x1;

    signal enable_out, go      : std_logic;
    signal temp_byte           : std_logic_vector(7 downto 0);
    signal encoded_byte_offset : std_logic_vector(3 downto 0);
    signal binary_byte_offset  : std_logic_vector(1 downto 0);

begin
    shift_reg_8_1: entity work.shift_register_bit_8(Structural)
    port map (
        vdd,
        gndgo,
        clk,
        enable_out,
        encoded_byte_offset
    );

    demux: entity work.demux_1x4_8bit(Structural)
    port map (
        mem_byte,
        binary_byte_offset,
        byte_00,
        byte_01,
        byte_10,
        byte_11
    );

    converter: entity work.one_hot_to_binary(Structural)
    port map (
        encoded_byte_offset,
        binary_byte_offset
    );

    mux_1: entity work.mux_2x1(Structural)
    port map (
        enable,
        gnd,
        reset,
        go
    );

    byte_offset <= binary_byte_offset;

end architecture Structural;
