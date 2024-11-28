-- Entity: negative edge triggered D flip-flop (dff)
-- Architecture : Structural
-- Author: 

library STD;
library IEEE;                      
use IEEE.std_logic_1164.all;       

entity dff_negedge is                      
  port ( d   : in  std_logic;
         clk : in  std_logic;
         q   : out std_logic;
         qbar: out std_logic); 
end dff_negedge;                          

architecture Structural of dff_negedge is 

begin
  
  output: process                 

  begin                           
    wait until ( clk'EVENT and clk = '0' ); 
    q <= d;
    qbar <= not d ;
  end process output;        
                    
end Structural; 