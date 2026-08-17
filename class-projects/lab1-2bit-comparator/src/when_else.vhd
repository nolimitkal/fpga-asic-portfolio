library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration
entity when_else is
    port(
        X, Y : in  std_logic_vector(1 downto 0);
        Z    : out std_logic
    );
end when_else;

-- Dataflow Architecture using When-Else
architecture dataflow of when_else is
begin
    Z <= '1' when (X = Y) else '0';
end dataflow;
