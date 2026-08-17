--Multiplier Simulation Bench
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mult_sim is

end mult_sim;

architecture mult_tb of mult_sim is

    component mult is
    generic(n : integer := 6);
    port(sel: in std_logic;
         a:in std_logic_vector(n-1 downto 0);
         b:in std_logic_vector(n-1 downto 0);
         r:out std_logic_vector(n-1 downto 0));
    end component;

    constant period : time := 10 ns;
    constant n : integer := 6;
    signal sel_tb : std_logic;
    signal a_tb, b_tb, r_tb: std_logic_vector(n-1 downto 0);

begin
--sel 0 then r = low 6 bits of a*b
--sel 1 then r = hi  6 bits of a*b
    uut: mult
    generic map(n => n)
    port    map(sel => sel_tb,
                a => a_tb,
                b => b_tb,
                r => r_tb);

    tb: process begin
        sel_tb <= '1';
            a_tb <= "001111"; b_tb <= "000010"; wait for period;
            a_tb <= "100000"; b_tb <= "000010"; wait for period;
        sel_tb <= '0';
            a_tb <= "001111"; b_tb <= "000010"; wait for period;
            a_tb <= "100000"; b_tb <= "000010"; wait for period;
    end process tb;

end mult_tb;
