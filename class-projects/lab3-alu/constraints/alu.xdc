# Constraints for Nexys A7-100T (xc7a100tcsg324-1)
# ALU Lab: sel=SW15-12, a=SW11-6, b=SW5-0, r=LED5-0

##------------------------------------------------------------
## sel - SW15, SW14, SW13, SW12
## SW15-SW12 are in bank 34 (1.8V) → LVCMOS18
##------------------------------------------------------------
set_property -dict { PACKAGE_PIN V10  IOSTANDARD LVCMOS33 } [get_ports { sel[3] }];
set_property -dict { PACKAGE_PIN U11  IOSTANDARD LVCMOS33 } [get_ports { sel[2] }];
set_property -dict { PACKAGE_PIN U12  IOSTANDARD LVCMOS33 } [get_ports { sel[1] }];
set_property -dict { PACKAGE_PIN H6   IOSTANDARD LVCMOS33 } [get_ports { sel[0] }];

##------------------------------------------------------------
## a - SW11, SW10, SW9, SW8, SW7, SW6
## SW8-SW11 bank 34 (LVCMOS18), SW6-SW7 bank 14 (LVCMOS33)
##------------------------------------------------------------
set_property -dict { PACKAGE_PIN T13  IOSTANDARD LVCMOS33 } [get_ports { a[5] }];
set_property -dict { PACKAGE_PIN R16  IOSTANDARD LVCMOS33 } [get_ports { a[4] }];
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports { a[3] }];
set_property -dict { PACKAGE_PIN T8   IOSTANDARD LVCMOS33 } [get_ports { a[2] }];
set_property -dict { PACKAGE_PIN R13  IOSTANDARD LVCMOS33 } [get_ports { a[1] }];
set_property -dict { PACKAGE_PIN U18  IOSTANDARD LVCMOS33 } [get_ports { a[0] }];

##------------------------------------------------------------
## b - SW5, SW4, SW3, SW2, SW1, SW0 (all bank 14/15 LVCMOS33)
##------------------------------------------------------------
set_property -dict { PACKAGE_PIN T18  IOSTANDARD LVCMOS33 } [get_ports { b[5] }];
set_property -dict { PACKAGE_PIN R17  IOSTANDARD LVCMOS33 } [get_ports { b[4] }];
set_property -dict { PACKAGE_PIN R15  IOSTANDARD LVCMOS33 } [get_ports { b[3] }];
set_property -dict { PACKAGE_PIN M13  IOSTANDARD LVCMOS33 } [get_ports { b[2] }];
set_property -dict { PACKAGE_PIN L16  IOSTANDARD LVCMOS33 } [get_ports { b[1] }];
set_property -dict { PACKAGE_PIN J15  IOSTANDARD LVCMOS33 } [get_ports { b[0] }];

##------------------------------------------------------------
## r - LED5, LED4, LED3, LED2, LED1, LED0
##------------------------------------------------------------
set_property -dict { PACKAGE_PIN V17  IOSTANDARD LVCMOS33 } [get_ports { r[5] }];
set_property -dict { PACKAGE_PIN U17  IOSTANDARD LVCMOS33 } [get_ports { r[4] }];
set_property -dict { PACKAGE_PIN N14  IOSTANDARD LVCMOS33 } [get_ports { r[3] }];
set_property -dict { PACKAGE_PIN J13  IOSTANDARD LVCMOS33 } [get_ports { r[2] }];
set_property -dict { PACKAGE_PIN K15  IOSTANDARD LVCMOS33 } [get_ports { r[1] }];
set_property -dict { PACKAGE_PIN H17  IOSTANDARD LVCMOS33 } [get_ports { r[0] }];
