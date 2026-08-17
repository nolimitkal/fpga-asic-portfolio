library ieee;
use ieee.std_logic_1164.all;

-- Xilinx UNISIM library for LUT4 primitive
library UNISIM;
use UNISIM.VComponents.all;

-- Entity Declaration
entity LUT_primitive is
    port(
        X, Y : in  std_logic_vector(1 downto 0);
        Z    : out std_logic
    );
end LUT_primitive;

-- Primitive Architecture using LUT4
-- INIT value calculation for 2-bit comparator:
-- Inputs: I3=X(1), I2=X(0), I1=Y(1), I0=Y(0)
-- Output is '1' only when X = Y:
--   Row  0 (0000): 1  -> X=00, Y=00 match
--   Row  5 (0101): 1  -> X=01, Y=01 match
--   Row 10 (1010): 1  -> X=10, Y=10 match
--   Row 15 (1111): 1  -> X=11, Y=11 match
-- Bit pattern (bit15 downto bit0): 1000 0100 0010 0001 = 0x8421
architecture primitive of LUT_primitive is
begin
    LUT4_inst : LUT4
        generic map (
            INIT => X"8421"   -- 2-bit equality comparator
        )
        port map (
            O  => Z,      -- LUT output
            I0 => Y(0),   -- LUT input (LSB)
            I1 => Y(1),   -- LUT input
            I2 => X(0),   -- LUT input
            I3 => X(1)    -- LUT input (MSB)
        );
end primitive;
