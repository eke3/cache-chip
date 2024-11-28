-- Entity: shift_register_bit_8
-- Architecture: Structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_bit_8 is
    port(
        vdd: in std_logic;
        gnd: in std_logic;
        input: in std_logic;
        clk: in std_logic;
        output: out std_logic;
        addr_en_encode: out std_logic_vector(3 downto 0)
    );
end entity shift_register_bit_8;

architecture Structural of shift_register_bit_8 is

    component dff_negedge is
        port(
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component dff_negedge;
    
    component or_2x1 is
        port(
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component or_2x1;
    
    component and_2x1 is
        port(
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC            
        );
    end component and_2x1;
    
    component nand_2x1 is
        port(
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        output : out STD_LOGIC        
        );
    end component nand_2x1;
    
    component inverter is
        port(
            input: in std_logic;
            output: out std_logic
         );
    end component inverter;

    for dff_1, dff_2, dff_3, dff_4, dff_5, dff_6, dff_7, dff_8: dff_negedge use entity work.dff_negedge(Structural);

    signal count_1, count_2, count_3, count_4, count_5, count_6, count_7, output_sig: std_logic;
    signal addr_0, addr_1, addr_2, addr_3, input_sig: std_logic;
    signal addr_0_t, addr_1_t, addr_2_t, count_3_inv, count_5_inv, count_7_inv: std_logic; 

begin

    dff_1: entity work.dff_negedge(Structural) port map(
        d => input_sig,
        clk => clk,
        q => count_1,
        qbar => open
    );

    dff_2: entity work.dff_negedge(Structural) port map(
        d => count_1,
        clk => clk,
        q => count_2,
        qbar => open
    );

    dff_3: entity work.dff_negedge(Structural) port map(
        d => count_2,
        clk => clk,
        q => count_3,
        qbar => open
    );

    dff_4: entity work.dff_negedge(Structural) port map(
        d => count_3,
        clk => clk,
        q => count_4,
        qbar => open
    );

    dff_5: entity work.dff_negedge(Structural) port map(
        d => count_4,
        clk => clk,
        q => count_5,
        qbar => open
    );

    dff_6: entity work.dff_negedge(Structural) port map(
        d => count_5,
        clk => clk,
        q => count_6,
        qbar => open
    );

    dff_7: entity work.dff_negedge(Structural) port map(
        d => count_6,
        clk => clk,
        q => count_7,
        qbar => open
    );

    dff_8: entity work.dff_negedge(Structural) port map(
        d => count_7,
        clk => clk,
        q => output_sig,
        qbar => open
    );
    
    or_1: entity work.or_2x1(Structural) port map(
        A => count_1,
        B => count_2,
        output => addr_0_t
    );
    
    or_2: entity work.or_2x1(Structural) port map(
        A => count_3,
        B => count_4,
        output => addr_1_t
    );
    
    or_3: entity work.or_2x1(Structural) port map(
        A => count_5,
        B => count_6,
        output => addr_2_t
    );
    
    or_4: entity work.or_2x1(Structural) port map(
        A => count_7,
        B => output_sig,
        output => addr_3
    );
    
    and_1: entity work.and_2x1(Structural) port map(
        A => vdd,
        B => input,
        output => input_sig
    );
    
    and_2: entity work.and_2x1(Structural) port map(
        A => addr_0_t,
        B => count_3_inv,
        output => addr_0
    );
    
    and_3: entity work.and_2x1(Structural) port map(
        A => addr_1_t,
        B => count_5_inv,
        output => addr_1
    );
    
    and_4: entity work.and_2x1(Structural) port map(
        A => addr_2_t,
        B => count_7_inv,
        output => addr_2
    );  
    
    inv_1: entity work.inverter(Structural) port map(
        input => count_3,
        output => count_3_inv
    );
    
    inv_2: entity work.inverter(Structural) port map(
        input => count_5,
        output => count_5_inv
    );  
    
    inv_3: entity work.inverter(Structural) port map(
        input => count_7,
        output => count_7_inv
    );
        
    addr_en_encode(0) <= addr_0;
    addr_en_encode(1) <= addr_1;
    addr_en_encode(2) <= addr_2;
    addr_en_encode(3) <= addr_3;
    output <= output_sig;

end Structural;