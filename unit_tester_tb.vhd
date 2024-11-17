
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity unit_tester_tb is
end unit_tester_tb;

architecture Test of unit_tester_tb is

    component concatenator
        port(
            input_a : in std_logic_vector(1 downto 0);  -- First 2-bit input
            input_b : in std_logic_vector(1 downto 0);  -- Second 2-bit input
            output  : out std_logic_vector(3 downto 0)  -- Concatenated 4-bit output
        );
    end component;
    
    component one_hot_to_binary
        port(
            one_hot : in  STD_LOGIC_VECTOR(3 downto 0); -- One-hot encoded input
            binary  : out STD_LOGIC_VECTOR(1 downto 0)  -- 2-bit binary output
        );
    end component;
    
    component decoder_2x4
    port (
        A : in  STD_LOGIC_VECTOR(1 downto 0);
        E : in  STD_LOGIC;
        Y : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;
    
    signal decoder1_out, decoder2_out : std_logic_vector(3 downto 0);
    signal input1, input2 : std_logic_vector(1 downto 0);
    signal binary1_out, binary2_out : std_logic_vector(1 downto 0);
    signal output : std_logic_vector(3 downto 0);

begin

    dec1: entity work.decoder_2x4
     port map(
        A => input1,
        E => '1',
        Y => decoder1_out
    );

    dec2: entity work.decoder_2x4
    port map(
       A => input2,
       E => '1',
       Y => decoder2_out
   );

   ohtb1: entity work.one_hot_to_binary
    port map(
       one_hot => decoder1_out,
       binary => binary1_out
   );

   ohtb2: entity work.one_hot_to_binary
   port map(
      one_hot => decoder2_out,
      binary => binary2_out
  );

  concat: entity work.concatenator
  port map(
     input_a => binary1_out,
     input_b => binary2_out,
     output => output
  );
  
stim: process
begin
  input1 <= "00";
  input2 <= "01";
  wait for 10 ns;
  input1 <= "01";
  input2 <= "10";
  wait for 10 ns;
  input1 <= "10";
  input2 <= "11";
  wait for 10 ns;
  input1 <= "11";
  input2 <= "00";
  wait for 10 ns;
  input1 <= "00";
  input2 <= "01";
  wait for 10 ns;
  input1 <= "01";
  input2 <= "10";
  wait for 10 ns;
  input1 <= "10";
  input2 <= "11";
  wait for 10 ns;
  wait;
  end process;

end architecture Test;
