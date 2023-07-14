class spi_master_sequencer extends uvm_sequencer#(packet);

`uvm_component_utils(spi_master_sequencer)

//Default constructor
  function new(string name = "spi_master_sequencer", uvm_component parent = null);
	super.new(name,parent);
  endfunction

//build phase
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
  endfunction

endclass
