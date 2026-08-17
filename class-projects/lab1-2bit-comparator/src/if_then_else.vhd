library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration
entity if_then_else is
    port(
        X, Y : in  std_logic_vector(1 downto 0);
        Z    : out std_logic
    );
end if_then_else;

-- Behavioral Architecture using If-Then-Else
architecture behavioral of if_then_else is
begin
    P1: process(X, Y)
    begin
        if (X = Y) then
            Z <= '1';
        else
            Z <= '0';
        end if;
    end process;
end behavioral;
