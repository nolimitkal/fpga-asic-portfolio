--Adder Simulation Bench
library ieee;
use ieee.std_logic_1164.all;

entity adder_sim is
end adder_sim;

architecture test_bench of adder_sim is
    constant period:time:=10ns;
    constant n:integer:= 6;
 -- Adder Definition
    component adder is
      Generic(n: integer := 6);
      Port (sel : in std_logic_vector(1 downto 0);
            a   : in std_logic_vector(n-1 downto 0);
            b   : in std_logic_vector(n-1 downto 0);
            r   : out std_logic_vector(n-1 downto 0));
    end component;
-- test bench signals
    signal sel_tb: std_logic_vector(1 downto 0);
    signal a_tb  : std_logic_vector(n-1 downto 0);
    signal b_tb  : std_logic_vector(n-1 downto 0);
    signal r_tb  : std_logic_vector(n-1 downto 0);
begin

    process
    begin
    sel_tb <= "00";
        a_tb <= "100011"; b_tb <= "111111"; wait for period;
    sel_tb <= "01";
        a_tb <= "111000"; b_tb <= "111111"; wait for period;
    sel_tb <= "10";
        a_tb <= "010111"; b_tb <= "111111"; wait for period;
    sel_tb <= "11";
        a_tb <= "000001"; b_tb <= "111111"; wait for period;
    wait;
    end process;

    uut:adder generic map(n => n)
    port map(sel => sel_tb, a => a_tb, b => b_tb, r => r_tb);

end test_bench;
