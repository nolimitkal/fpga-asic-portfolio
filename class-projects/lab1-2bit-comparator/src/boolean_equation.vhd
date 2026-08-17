library ieee;
use ieee.std_logic_1164.all;

-- Entity Declaration
entity boolean_equation is
    port(
        X, Y : in  std_logic_vector(1 downto 0);
        Z    : out std_logic
    );
end boolean_equation;

-- Dataflow Architecture using Boolean Equations
-- Z = 1 when X = Y, i.e., when both bits match:
--   (X1=0,X0=0,Y1=0,Y0=0) OR (X1=0,X0=1,Y1=0,Y0=1)
--   OR (X1=1,X0=0,Y1=1,Y0=0) OR (X1=1,X0=1,Y1=1,Y0=1)
architecture dataflow of boolean_equation is
    signal temp : std_logic_vector(3 downto 0);
begin
    temp(3) <= (not X(1)) and (not X(0)) and (not Y(1)) and (not Y(0));
    temp(2) <= (not X(1)) and      X(0)  and (not Y(1)) and      Y(0);
    temp(1) <=      X(1)  and (not X(0)) and      Y(1)  and (not Y(0));
    temp(0) <=      X(1)  and      X(0)  and      Y(1)  and      Y(0);
    Z <= temp(3) or temp(2) or temp(1) or temp(0);
end dataflow;
