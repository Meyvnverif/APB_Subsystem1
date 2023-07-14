
class spi_master_agent extends uvm_agent;

`uvm_component_utils(spi_master_agent)

spi_master_driver m_drvr;
spi_master_sequencer m_seqr;
spi_master_monitor m_mntr;

function new(string name = "spi_master_agent", uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
//if(get_is_active == UVM_ACTIVE) begin
m_drvr = spi_master_driver::type_id::create("m_drvr",this);
m_seqr = spi_master_sequencer::type_id::create("m_seqr",this);
//end
m_mntr = spi_master_monitor::type_id::create("m_mntr",this);
endfunction

/*function void connect_phase(uvm_phase phase);
if(get_is_active == UVM_ACTIVE) begin
s_drvr.seq_item_port.connect(s_seqr.seq_item_export);
end
endfunction*/
function void connect_phase(uvm_phase phase);
	m_drvr.seq_item_port.connect(m_seqr.seq_item_export);
endfunction

endclass
