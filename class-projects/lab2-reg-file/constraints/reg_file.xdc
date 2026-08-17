## Clock - E3
set_property -dict { PACKAGE_PIN E3   IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { clk }];
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_IBUF]

## Reset - CPU RESET (C12)
set_property -dict { PACKAGE_PIN C12  IOSTANDARD LVCMOS33 } [get_ports { rst }];

## Write Enable - BTNL (P17)
set_property -dict { PACKAGE_PIN P17  IOSTANDARD LVCMOS33 } [get_ports { we }];

## Address - SW13, SW14, SW15 (LVCMOS33)
set_property -dict { PACKAGE_PIN U12  IOSTANDARD LVCMOS33 } [get_ports { addr[0] }];
set_property -dict { PACKAGE_PIN U11  IOSTANDARD LVCMOS33 } [get_ports { addr[1] }];
set_property -dict { PACKAGE_PIN V10  IOSTANDARD LVCMOS33 } [get_ports { addr[2] }];

## Data In - SW0, SW1, SW2, SW3
set_property -dict { PACKAGE_PIN J15  IOSTANDARD LVCMOS33 } [get_ports { din[0] }];
set_property -dict { PACKAGE_PIN L16  IOSTANDARD LVCMOS33 } [get_ports { din[1] }];
set_property -dict { PACKAGE_PIN M13  IOSTANDARD LVCMOS33 } [get_ports { din[2] }];
set_property -dict { PACKAGE_PIN R15  IOSTANDARD LVCMOS33 } [get_ports { din[3] }];

## Data Out - LED0, LED1, LED2, LED3
set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS33 } [get_ports { dout[0] }];
set_property -dict { PACKAGE_PIN K15  IOSTANDARD LVCMOS33 } [get_ports { dout[1] }];
set_property -dict { PACKAGE_PIN J13  IOSTANDARD LVCMOS33 } [get_ports { dout[2] }];
set_property -dict { PACKAGE_PIN N14  IOSTANDARD LVCMOS33 } [get_ports { dout[3] }];
