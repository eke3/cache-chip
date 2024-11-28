library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_1x16_8bit_tb is
-- No ports for a testbench
end demux_1x16_8bit_tb;

architecture Test of demux_1x16_8bit_tb is

    -- Component declaration
    component demux_1x16_8bit
        port (
            data_in     : in  STD_LOGIC_VECTOR(7 downto 0);
            sel         : in  STD_LOGIC_VECTOR(3 downto 0);
            data_out_0  : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_1  : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_2  : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_3  : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_4  : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_5  : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_6  : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_7  : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_8  : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_9  : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_10 : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_11 : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_12 : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_13 : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_14 : out STD_LOGIC_VECTOR(7 downto 0);
            data_out_15 : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    -- Testbench signals
    signal data_in     : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal sel         : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal data_out_0  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_1  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_2  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_3  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_4  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_5  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_6  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_7  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_8  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_9  : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_10 : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_11 : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_12 : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_13 : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_14 : STD_LOGIC_VECTOR(7 downto 0);
    signal data_out_15 : STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.demux_1x16_8bit(Structural)
        port map (
            data_in     => data_in,
            sel         => sel,
            data_out_0  => data_out_0,
            data_out_1  => data_out_1,
            data_out_2  => data_out_2,
            data_out_3  => data_out_3,
            data_out_4  => data_out_4,
            data_out_5  => data_out_5,
            data_out_6  => data_out_6,
            data_out_7  => data_out_7,
            data_out_8  => data_out_8,
            data_out_9  => data_out_9,
            data_out_10 => data_out_10,
            data_out_11 => data_out_11,
            data_out_12 => data_out_12,
            data_out_13 => data_out_13,
            data_out_14 => data_out_14,
            data_out_15 => data_out_15
        );

    -- Test process
    stimulus_process: process
    begin
        -- Loop through all selector values
        data_in <= "10101010";  -- Example input
        sel <= "0000";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "0001";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "0010";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "0011";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "0100";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "0101";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "0110";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "0111";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "1000";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "1001";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation

        data_in <= "10101010";  -- Example input
        sel <= "1010";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "1011";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "1100";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "1101";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "1110";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        data_in <= "10101010";  -- Example input
        sel <= "1111";  -- Select output channel
        wait for 10 ns; -- Allow time for propagation
        
        wait; -- Stop the process
    end process stimulus_process;

end architecture Test;

