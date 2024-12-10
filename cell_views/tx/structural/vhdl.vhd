-- Created by @(#)$CDS: vhdlin version 6.1.8-64b 06/22/2022 16:17 (sjfhw317) $
-- on Tue Dec  3 13:58:21 2024


architecture Structural of tx is

begin

    txprocess: process (sel, selnot, input)
    begin
        if (sel = '1' and selnot = '0') then
            output <= input;
        else
            output <= 'Z';
        end if;
    end process txprocess;

end Structural;
