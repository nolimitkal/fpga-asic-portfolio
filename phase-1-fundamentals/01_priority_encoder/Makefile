.PHONY: sim wave lint clean

sim:
	iverilog -o sim/sim.out tb/*.v rtl/*.v
	vvp sim/sim.out

wave:
	gtkwave sim/dump.vcd &

lint:
	verilator --lint-only rtl/*.v

clean:
	rm -f sim/*.out sim/*.vcd
