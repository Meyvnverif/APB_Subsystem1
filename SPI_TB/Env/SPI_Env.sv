
class spi_env extends uvm_env;

`uvm_component_utils(spi_env)

apb_agent agnt;
//spi_master_agent m_agnt;
spi_scoreboard scb;
spi_slave_agent s_agnt;
spi_reg_model   spi_ral_mod;
reg2spi_adapter spi_adapter;
env_config ecfg;
function new(string name = "spi_env", uvm_component parent = null);
super.new(name,parent);
ecfg = new();
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
//if(ecfg.apb_agent==1)begin
agnt = apb_agent::type_id::create("agnt",this);
//end
scb = spi_scoreboard::type_id::create("scb",this);
s_agnt=spi_slave_agent::type_id::create("s_agnt",this);
//m_agnt=spi_master_agent::type_id::create("m_agnt",this);
spi_ral_mod=spi_reg_model::type_id::create("spi_ral_mod",this);
spi_adapter=reg2spi_adapter::type_id::create("spi_adapter",this);
spi_ral_mod.build();
    //spi_ral_mod.print();  
uvm_config_db #(spi_reg_model)::set(uvm_root::get(),"*","spi_ral_model",spi_ral_mod); 
endfunction

function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
    spi_ral_mod.default_map.set_sequencer( .sequencer(agnt.seqr), .adapter(spi_adapter) );
    spi_ral_mod.default_map.set_base_addr('h0); 
   // s_agnt.s_mntr.ap_mon.connect(spi_adapter.ap_ad);
      agnt.mntr.ap_mon.connect(scb.aip);
endfunction
endclass



