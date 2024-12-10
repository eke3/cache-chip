-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_4x1_2bit is
    port (
        read_data0 : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit input 0
        read_data1 : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit input 1
        read_data2 : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit input 2
        read_data3 : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit input 3
        sel        : in  STD_LOGIC_VECTOR(1 downto 0); -- 2-bit sel signal
        F          : out STD_LOGIC_VECTOR(1 downto 0) -- 2-bit output of the multiplexer
    );
end mux_4x1_2bit;
