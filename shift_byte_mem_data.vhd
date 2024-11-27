-- Entity: shift_byte_mem_data.vhd

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity shift_byte_mem_data is
    port(
        enable: in std_logic;
        reset: in std_logic;
        mem_byte: in std_logic_vector(7 downto 0);
        clk: in std_logic;
        byte_offset: out std_logic_vector(1 downto 0);
        byte_00: out std_logic_vector(7 downto 0);
        byte_01: out std_logic_vector(7 downto 0);
        byte_10: out std_logic_vector(7 downto 0);
        byte_11: out std_logic_vector(7 downto 0)
    );
end shift_byte_mem_data;

architecture structural of shift_byte_mem_data is

    component shift_register_bit_8
        port(
            input: in std_logic;
            clk: in std_logic;
            output: out std_logic;
            addr_en_encode: out std_logic_vector(3 downto 0)
        );
    end component;

    component demux_1x4_8bit
        port(
            data_in    : in  STD_LOGIC_VECTOR(7 downto 0); -- 8-bit input data
            sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit selector
            data_out_0 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "00"
            data_out_1 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "01"
            data_out_2 : out STD_LOGIC_VECTOR(7 downto 0); -- 8-bit output for selection "10"
            data_out_3 : out STD_LOGIC_VECTOR(7 downto 0) -- 8-bit output for selection "11"
        );
    end component;

    component one_hot_to_binary
        port(
            one_hot : in  STD_LOGIC_VECTOR(3 downto 0); -- One-hot encoded input
            binary  : out STD_LOGIC_VECTOR(1 downto 0)  -- 2-bit binary output
        );    
    end component;
    
    component or_2x1
        port(
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC        
        );
    end component;
    
    component mux_2x1
    port(
        A      : in  STD_LOGIC; -- Input 0
        B      : in  STD_LOGIC; -- Input 1
        sel    : in  STD_LOGIC; -- sel signal
        output : out STD_LOGIC -- Output of the multiplexer
    );
    end component;
    
    signal enable_out, go: std_logic;
    signal temp_byte: std_logic_vector(7 downto 0);
    signal encoded_byte_offset: std_logic_vector(3 downto 0);
    signal binary_byte_offset: std_logic_vector(1 downto 0);

begin
    shift_reg_8_1: entity work.shift_register_bit_8(structural) port map(
        go,
        clk,
        enable_out,
        encoded_byte_offset
    );

    demux: entity work.demux_1x4_8bit(structural) port map(
        mem_byte,
        binary_byte_offset,
        byte_00,
        byte_01,
        byte_10,
        byte_11
    );

    converter: entity work.one_hot_to_binary(structural) port map(
        encoded_byte_offset,
        binary_byte_offset
    );
    
   mux_1: entity work.mux_2x1(structural) port map(
        enable,
        '0',
        reset,
        go
    );
    
    byte_offset <= binary_byte_offset;
    
end structural;

