library ieee;
use ieee.std_logic_1164.all;

-- 3-to-8 decoder with active-high enable
-- Output is a single 8-bit signal (not eight separate signals)
-- When en = '0', all outputs are forced to '0'
entity decoder_3to8 is
    port (
        en   : in  std_logic;                     -- enable (active high)
        addr : in  std_logic_vector(2 downto 0);  -- 3-bit select
        dout : out std_logic_vector(7 downto 0)   -- one-hot 8-bit output
    );
end decoder_3to8;

architecture behavioral of decoder_3to8 is
begin
    process(en, addr)
    begin
        if en = '0' then
            dout <= (others => '0');              -- disabled: all outputs low
        else
            case addr is
                when "000"  => dout <= "00000001";
                when "001"  => dout <= "00000010";
                when "010"  => dout <= "00000100";
                when "011"  => dout <= "00001000";
                when "100"  => dout <= "00010000";
                when "101"  => dout <= "00100000";
                when "110"  => dout <= "01000000";
                when others => dout <= "10000000"; -- "111"
            end case;
        end if;
    end process;
end behavioral;
