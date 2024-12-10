-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 11:57:48 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity or_16x1 is
    port (
        input0  : in  STD_LOGIC; -- Input 0
        input1  : in  STD_LOGIC; -- Input 1
        input2  : in  STD_LOGIC; -- Input 2
        input3  : in  STD_LOGIC; -- Input 3
        input4  : in  STD_LOGIC; -- Input 4
        input5  : in  STD_LOGIC; -- Input 5
        input6  : in  STD_LOGIC; -- Input 6
        input7  : in  STD_LOGIC; -- Input 7
        input8  : in  STD_LOGIC; -- Input 8
        input9  : in  STD_LOGIC; -- Input 9
        input10 : in  STD_LOGIC; -- Input 10
        input11 : in  STD_LOGIC; -- Input 11
        input12 : in  STD_LOGIC; -- Input 12
        input13 : in  STD_LOGIC; -- Input 13
        input14 : in  STD_LOGIC; -- Input 14
        input15 : in  STD_LOGIC; -- Input 15
        output  : out STD_LOGIC -- Single OR output
    );
end or_16x1;
