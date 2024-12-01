-- Entity: tb_demux_1x16_8bit
-- Architecture: Test
-- Note: Run for 200 ns

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity tb_demux_1x16_8bit is
    -- No ports for a testbench
end entity tb_demux_1x16_8bit;

architecture Test of tb_demux_1x16_8bit is

    -- Component declaration
    component demux_1x16_8bit is
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
    end component demux_1x16_8bit;

    -- Testbench signals
    signal data_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal sel     : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal data_out_0, data_out_1, data_out_2, data_out_3, data_out_4, data_out_5, data_out_6, data_out_7, data_out_8,
        data_out_9, data_out_10, data_out_11, data_out_12, data_out_13, data_out_14, data_out_15
        : STD_LOGIC_VECTOR(7 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    DUT: entity work.demux_1x16_8bit(Structural)
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
        -- Initialize inputs
        data_in <= (others => 'Z');
        sel     <= (others => 'Z');
        wait for 10 ns;

        -- Loop through all selector values
        data_in <= "10101010"; -- Example input
        sel     <= "0000";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_0 = "10101010") report "Output mismatch for selector 0000" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "0001";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_1 = "10101010") report "Output mismatch for selector 0001" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "0010";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_2 = "10101010") report "Output mismatch for selector 0010" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "0011";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_3 = "10101010") report "Output mismatch for selector 0011" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "0100";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_4 = "10101010") report "Output mismatch for selector 0100" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "0101";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_5 = "10101010") report "Output mismatch for selector 0101" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "0110";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_6 = "10101010") report "Output mismatch for selector 0110" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "0111";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_7 = "10101010") report "Output mismatch for selector 0111" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "1000";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_8 = "10101010") report "Output mismatch for selector 1000" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "1001";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_9 = "10101010") report "Output mismatch for selector 1001" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "1010";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_10 = "10101010") report "Output mismatch for selector 1010" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "1011";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_11 = "10101010") report "Output mismatch for selector 1011" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "1100";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_12 = "10101010") report "Output mismatch for selector 1100" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "1101";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_13 = "10101010") report "Output mismatch for selector 1101" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "1110";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_14 = "10101010") report "Output mismatch for selector 1110" severity failure;

        data_in <= "10101010"; -- Example input
        sel     <= "1111";     -- Select output channel
        wait for 10 ns;        -- Allow time for propagation
        assert (data_out_15 = "10101010") report "Output mismatch for selector 1111" severity failure;

        report "Testbench completed.";
        wait;                  -- Stop the process
    end process stimulus_process;

end architecture Test;
