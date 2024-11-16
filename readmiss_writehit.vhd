-- Entity: readmiss_writehit
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity readmiss_writehit is
    port(
        hit_miss: in std_logic;
        R_W: in std_logic;
        enable_cache_write: out std_logic
    );
end readmiss_writehit;

architecture structural of readmiss_writehit is

    component xnor_2x1
        port (
            A      : in  STD_LOGIC; -- Input 0
            B      : in  STD_LOGIC; -- Input 1
            output : out STD_LOGIC  -- Output of the XNOR gate
        );
    end component;

    component inverter
        port(
            input  : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;

    for inv_1, inv_2: inverter use entity work.inverter(structural);

    for xnor_1: xnor_2x1 use entity work.xnor_2x1(structural);
    
    signal hit_miss_inv, out_inv: std_logic;

begin
    --and_1: and_2x1 port map (enable_cache_write, R_W, check_read);

    xnor_1: xnor_2x1 port map (hit_miss_inv, R_W, out_inv);

    inv_1: inverter port map (hit_miss, hit_miss_inv);
    
    inv_2: inverter port map (out_inv, enable_cache_write);

end structural;
