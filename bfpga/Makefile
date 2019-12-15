
box.bin: pll.v box.v box.pcf	
	yosys -q -p "synth_ice40 -blif box.blif" box.v pll.v
	arachne-pnr -p box.pcf box.blif -o box.txt
	icebox_explain box.txt > box.ex
	icepack box.txt box.bin

clean:
	rm -f box.blif box.txt box.ex box.bin
