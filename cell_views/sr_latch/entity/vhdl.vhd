-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 14:04:44 2024


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sr_latch is
    port (
        S  : in    std_logic; -- Set input
        R  : in    std_logic; -- Reset input
        Q  : inout std_logic; -- Output Q
        Qn : inout std_logic -- Complement of Q
    );
end sr_latch;
