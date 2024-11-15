-- Entity: chip
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity chip is
    port(   cpu_add     : in std_logic_vector(5 downto 0);
            cpu_data    : in std_logic_vector(7 downto 0);
            start       : in std_logic;
            busy        : in std_logic;
            rw          : in std_logic;
            reset       : in std_logic;
            clk         : in std_logic;
            mem_data    : in std_logic_vector(7 downto 0);
            mem_add     : out std_logic_vector(7 downto 0);
            enable      : out std_logic);
            
end chip;
            
architecture structural of chip is 

    component comparator
        port();
    end component;

    component decoder
        port();
    end component;

    component block_cache
        port();
    end component;

    component valid_cache
        port();
    end component;

    component tag_cache
        port();
    end component;

begin

    output: process
    begin
        
    end process output;

end structural;
