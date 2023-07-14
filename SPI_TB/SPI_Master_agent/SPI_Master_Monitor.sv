
class spi_master_monitor extends uvm_monitor;

`uvm_component_utils(spi_master_monitor)
//uvm_analysis_port#(packet)ap_mon;
virtual spi_interface mon_if;
packet pkt;
function new(string name = "spi_master_monitor", uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
//ap_mon = new("ap_mon",this);
pkt = packet::type_id::create("pkt");
uvm_config_db#(virtual spi_interface)::get(this,"","vif",mon_if);
endfunction
task run_phase(uvm_phase phase);
	forever begin
		@(mon_if.spi_mp.spi_cb);
		if(mon_if.PENABLE)begin
			if(mon_if.PWRITE)begin
	pkt.PENABLE = mon_if.spi_mp.spi_cb.PENABLE; 
	pkt.PSEL    = mon_if.spi_mp.spi_cb.PSEL;
	pkt.PADDR   = mon_if.spi_mp.spi_cb.PADDR;
	pkt.PWDATA  = mon_if.spi_mp.spi_cb.PWDATA;
        pkt.PWRITE  = mon_if.spi_mp.spi_cb.PWRITE;
	pkt.MISO    = mon_if.MISO;
        @(mon_if.spi_mp.spi_cb);
	@(mon_if.spi_mp.spi_cb);
	@(mon_if.spi_mp.spi_cb);
	`uvm_info(get_type_name(), $sformatf(" addr = 0x%0h data = 0x%0h 
         write = 0x%0h enable = %0h sel = %0h",pkt.PADDR,pkt.PWDATA,pkt.PWRITE,
		 pkt.PENABLE,pkt.PSEL),UVM_LOW); 
	`uvm_info(get_type_name(), $sformatf("MISO = %0h",pkt.MISO),UVM_LOW); 

end
end
if(!mon_if.PWRITE) begin
	@(mon_if.spi_mp.spi_cb);

        pkt.PWRITE = mon_if.spi_mp.spi_cb.PWRITE;
        pkt.PADDR = mon_if.spi_mp.spi_cb.PADDR;	
	pkt.PRDATA = mon_if.PRDATA;
	pkt.PREADY = mon_if.spi_mp.spi_cb.PREADY;
        pkt.PSLVERR = mon_if.spi_mp.spi_cb.PSLVERR;
	pkt.MOSI    = mon_if.MOSI;
     `uvm_info(get_type_name(), $sformatf(" addr = 0x%0h data = 0x%0h 
         write = 0x%0h",pkt.PADDR,pkt.PRDATA,pkt.PWRITE),UVM_LOW); 
        @(mon_if.spi_mp.spi_cb);
        @(mon_if.spi_mp.spi_cb);
`uvm_info(get_type_name(), $sformatf("MOSI = %0h",pkt.MOSI),UVM_LOW);
//ap_mon.write(pkt);
end
	end
endtask
endclass
