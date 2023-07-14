class apb_agent extends uvm_agent;

`uvm_component_utils(apb_agent)

apb_driver drvr;
apb_sequencer seqr;
apb_monitor mntr;

function new(string name = "apb_agent", uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
//if(get_is_active == UVM_ACTIVE) begin
drvr = apb_driver::type_id::create("drvr",this);
seqr = apb_sequencer::type_id::create("seqr",this);
//end
mntr = apb_monitor::type_id::create("mntr",this);
endfunction

/*function void connect_phase(uvm_phase phase);
if(get_is_active == UVM_ACTIVE) begin
s_drvr.seq_item_port.connect(s_seqr.seq_item_export);
end
endfunction*/
function void connect_phase(uvm_phase phase);
	drvr.seq_item_port.connect(seqr.seq_item_export);
endfunction

endclass
