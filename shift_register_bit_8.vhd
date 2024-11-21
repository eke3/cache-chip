-- Entity: shift_register_bit_8
-- Architecture: structural
-- Author:

library STD;
library IEEE;
use IEEE.std_logic_1164.all;

entity shift_register_bit_8 is
    port(
        input: in std_logic;
        clk: in std_logic;
        output: out std_logic;
        addr_en_encode: out std_logic_vector(3 downto 0)
    );
end entity shift_register_bit_8;

architecture structural of shift_register_bit_8 is

    component dff
        port(
            d    : in  std_logic;
            clk  : in  std_logic;
            q    : out std_logic;
            qbar : out std_logic
        );
    end component;
    
    component or_2x1
        port(
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC
        );
    end component;
    
    component and_2x1
        port(
            A      : in  STD_LOGIC;
            B      : in  STD_LOGIC;
            output : out STD_LOGIC            
        );
    end component;
    
    component nand_2x1
        port(
        A      : in  STD_LOGIC;
        B      : in  STD_LOGIC;
        output : out STD_LOGIC        
        );
    end component;
    
    component inverter
        port(
            input: in std_logic;
            output: out std_logic
         );
    end component;

    for dff_1, dff_2, dff_3, dff_4, dff_5, dff_6, dff_7, dff_8: dff use entity work.dff(structural);

    signal count_1, count_2, count_3, count_4, count_5, count_6, count_7, output_sig: std_logic;

    signal addr_0, addr_1, addr_2, addr_3, input_sig: std_logic;
    signal addr_0_t, addr_1_t, addr_2_t, count_2_inv, count_4_inv, count_6_inv: std_logic; 

begin

    dff_1: dff port map(
        input_sig,
        clk,
        count_1
    );

    dff_2: dff port map(
        count_1,
        clk,
        count_2
    );

    dff_3: dff port map(
        count_2,
        clk,
        count_3
    );

    dff_4: dff port map(
        count_3,
        clk,
        count_4
    );

    dff_5: dff port map(
        count_4,
        clk,
        count_5
    );

    dff_6: dff port map(
        count_5,
        clk,
        count_6
    );

    dff_7: dff port map(
        count_6,
        clk,
        count_7
    );

    dff_8: dff port map(
        count_7,
        clk,
        output_sig
    );
    
    or_1: or_2x1 port map(
        count_1,
        '0',
        addr_0_t
    );
    
    or_2: or_2x1 port map(
        count_2,
        count_3,
        addr_1_t
    );
    
    or_3: or_2x1 port map(
        count_4,
        count_5,
        addr_2_t
    );
    
    or_4: or_2x1 port map(
        count_6,
        count_7,
        addr_3
    );
    
    and_1: and_2x1 port map(
        '1',
        input,
        input_sig
    );
    
    and_2: and_2x1 port map(
        addr_0_t,
        count_2_inv,
        addr_0
    );
    
    and_3: and_2x1 port map(
        addr_1_t,
        count_4_inv,
        addr_1
    );
    
    and_4: and_2x1 port map(
        addr_2_t,
        count_6_inv,
        addr_2
    );  
    
    inv_1: inverter port map(
        count_2,
        count_2_inv
    );
    
    inv_2: inverter port map(
        count_4,
        count_4_inv
    );  
    
    inv_3:inverter port map(
        count_6,
        count_6_inv
    );
        
    addr_en_encode(0) <= addr_0;
    addr_en_encode(1) <= addr_1;
    addr_en_encode(2) <= addr_2;
    addr_en_encode(3) <= addr_3;
    output <= output_sig;

end structural;