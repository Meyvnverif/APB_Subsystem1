class env_config extends uvm_object;
//factory registration
`uvm_object_utils(env_config)
localparam string s_my_config_id = "env_config";
//data members
// env analysis components are used?
// agent is used?
bit spi_slave_agent;
bit apb_agent;
//configurations for the subcomponents
//spi_agent_config = m_agnt_cfg;
//spi_register model
//uvm_register_map spi_rm;
function new(string name = "env_config");
	super.new(name);
endfunction
endclass:env_config

