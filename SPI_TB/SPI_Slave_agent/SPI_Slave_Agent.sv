class spi_slave_agent extends uvm_agent;

`uvm_component_utils(spi_slave_agent)

spi_slave_driver s_drvr;
spi_slave_sequencer s_seqr;
spi_slave_monitor s_mntr;

function new(string name = "spi_slave_agent", uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
//if(get_is_active == UVM_ACTIVE) begin
s_drvr = spi_slave_driver::type_id::create("s_drvr",this);
s_seqr = spi_slave_sequencer::type_id::create("s_seqr",this);
//end
s_mntr = spi_slave_monitor::type_id::create("s_mntr",this);
endfunction

/*function void connect_phase(uvm_phase phase);
if(get_is_active == UVM_ACTIVE) begin
s_drvr.seq_item_port.connect(s_seqr.seq_item_export);
end
endfunction*/
function void connect_phase(uvm_phase phase);
	s_drvr.seq_item_port.connect(s_seqr.seq_item_export);
endfunction

endclass
