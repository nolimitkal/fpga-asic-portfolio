library ieee;
use ieee.std_logic_1164.all;

-- Parameterized register of n bits
-- Rising edge triggered, asynchronous active-low reset
entity reg_module is
    generic (
        n : integer := 4          -- word size in bits
    );
    port (
        clk  : in  std_logic;
        rst  : in  std_logic;     -- async active-low reset
        we   : in  std_logic;     -- write enable (active high)
        din  : in  std_logic_vector(n-1 downto 0);
        dout : out std_logic_vector(n-1 downto 0)
    );
end reg_module;

architecture behavioral of reg_module is
begin
    process(clk, rst)
    begin
        if rst = '0' then                      -- asynchronous active-low reset
            dout <= (others => '0');
        elsif rising_edge(clk) then
            if we = '1' then
                dout <= din;
            end if;
        end if;
    end process;
end behavioral;
