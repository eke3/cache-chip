-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:55:16 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux_2x1_2bit is
    port (
        A      : in  STD_LOGIC_VECTOR(1 downto 0); -- Input 0
        B      : in  STD_LOGIC_VECTOR(1 downto 0); -- Input 1
        sel    : in  STD_LOGIC; -- sel signal
        output : out STD_LOGIC_VECTOR(1 downto 0) -- Output of the multiplexer
    );
end mux_2x1_2bit;
