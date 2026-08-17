# Constraints file for Nexys A7-100T (xc7a100tcsg324-1)
# 2-bit Comparator Lab - Pin Mappings
# Reference: Nexys A7 Master XDC

##------------------------------------------------------------
## Switches (Inputs)
##------------------------------------------------------------

# X[0] -> SW0
set_property PACKAGE_PIN J15 [get_ports {X[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {X[0]}]

# X[1] -> SW1
set_property PACKAGE_PIN L16 [get_ports {X[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {X[1]}]

# Y[0] -> SW2
set_property PACKAGE_PIN M13 [get_ports {Y[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[0]}]

# Y[1] -> SW3
set_property PACKAGE_PIN R15 [get_ports {Y[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Y[1]}]

##------------------------------------------------------------
## LEDs (Outputs)
##------------------------------------------------------------

# Z[0] -> LED0  (LUT Primitive result)
set_property PACKAGE_PIN H17 [get_ports {Z[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Z[0]}]

# Z[1] -> LED1  (Boolean Equation result)
set_property PACKAGE_PIN K15 [get_ports {Z[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Z[1]}]

# Z[2] -> LED2  (When-Else result)
set_property PACKAGE_PIN J13 [get_ports {Z[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Z[2]}]

# Z[3] -> LED3  (If-Then-Else result)
set_property PACKAGE_PIN N14 [get_ports {Z[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {Z[3]}]
