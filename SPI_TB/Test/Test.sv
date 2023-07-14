
class base_test extends uvm_test;

`uvm_component_utils(base_test)
spi_env s_env;
spi_basic_sequence s_seq;

function new(string name = "base_test", uvm_component parent = null);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);

s_env=spi_env::type_id::create("s_env",this);
s_seq = spi_basic_sequence::type_id::create("s_seq");
endfunction

function void end_of_elaboration_phase(uvm_phase phase);
uvm_top.print_topology();
endfunction 

task run_phase(uvm_phase phase);
 phase.raise_objection(this);
 //s_seq.spi_ral = s_env.spi_ral_mod;
// s_seq.start(s_env.s_agnt.s_seqr);
 #100;
phase.drop_objection(this);
`uvm_info(get_type_name, "End of test case", UVM_LOW);

endtask

function void final_phase(uvm_phase phase);
	uvm_report_server svr_h;
	super.final_phase(phase);
	svr_h = uvm_report_server::get_server();

  if(svr_h.get_severity_count(UVM_FATAL)+svr_h.get_severity_count(UVM_ERROR)>0)
  begin
	  `uvm_info(get_type_name(),$sformatf("*************************************"),UVM_NONE)
          `uvm_info(get_type_name(),$sformatf("***********   TEST_FAIL  ************"),UVM_NONE)
          `uvm_info(get_type_name(),$sformatf("*************************************"),UVM_NONE)
  end
  else 
    begin
          `uvm_info(get_type_name(),$sformatf("*************************************"),UVM_NONE)
          `uvm_info(get_type_name(),$sformatf("***********   TEST_PASS  ************"),UVM_NONE)
          `uvm_info(get_type_name(),$sformatf("*************************************"),UVM_NONE)
        end
	  
endfunction
endclass

class spi_reg_test extends base_test;

       `uvm_component_utils(spi_reg_test)

        //for reading default values
        uvm_reg_hw_reset_seq reg_reset_seq;

	//bitbash sequence
	uvm_reg_sequence seq;

	function new(string name = "spi_reg_test", uvm_component parent = null);
	super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
	super.build_phase(phase);
        //for reading defualt values
	reg_reset_seq = uvm_reg_hw_reset_seq::type_id::create("reg_reset_seq");

	//for bitbash sequece
	seq = uvm_reg_bit_bash_seq::type_id::create("seq");

        endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
                //for reading defualt values
		reg_reset_seq.model = s_env.spi_ral_mod;
		reg_reset_seq.start(null);

                //for bitbash sequece
		seq.model = s_env.spi_ral_mod;
                seq.start(s_env.agnt.seqr);
            
		#100;
		phase.drop_objection(this);

	endtask 

endclass:spi_reg_test

class spi_reg_backdoor_test extends base_test;

       `uvm_component_utils(spi_reg_backdoor_test)

        //for backdoor access of cr1
       // spi_reg_backdoor back_seq;
        spi_reg_model spi_ral;
	function new(string name = "spi_reg_backdoor_test", uvm_component parent = null);
	super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
	super.build_phase(phase);

        //for reading defualt values
//	back_seq = spi_reg_backdoor ::type_id::create("back_seq");
        endfunction

	task run_phase(uvm_phase phase);
             uvm_status_e status;
             bit [31:0]PRDATA;
		phase.raise_objection(this);
		#50
               // uvm_config_db#(ral_sys_traffic)::get(null, "uvm_test_top", "m_ral_model", m_ral_model);
		uvm_config_db #(spi_reg_model)::get(uvm_root::get(),"*","spi_ral_model",spi_ral); 
		//backdoor access of cr1
		`uvm_info(get_type_name(),$sformatf("In side backdoor test"),UVM_NONE)
		//back_seq.spi_ral = s_env.spi_ral_mod;
          //      back_seq.start(s_env.s_agnt.s_seqr);
	         spi_ral.mod_reg.spi_cr1.write(status,16'h0AB,UVM_BACKDOOR);
		 `uvm_info ("REG",$sformatf("status = %s",status),UVM_LOW)
		 #50
		 uvm_hdl_force("top.dut.top.apb_slave.SPI_CR1",'h03c7);
	        //force top.dut.top.apb_slave.SPI_CR1=16'h03c7; 
 	        //spi_ral.mod_reg.spi_cr1.read(status,PRDATA);
   
		#100;
		phase.drop_objection(this);

	endtask 

endclass


class spi_Full_duplex_Rx_test extends base_test;

	`uvm_component_utils(spi_Full_duplex_Rx_test)
        //Reg sequence for fullduplex Config
	spi_CR1_reg CR1_seq;
        spi_CR2_reg CR2_seq;

	//Reg sequence for Receieve
        spi_DR_RD_reg DR_RD_seq;
        //sequence for MISO transmission
        spi_fd_sequence seq;
	function new(string name = "spi_Full_duplex_Rx_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	//MISO tx sequence
        seq = spi_fd_sequence::type_id::create("seq");
	CR1_seq = spi_CR1_reg::type_id::create("CR1_seq");
	CR2_seq = spi_CR2_reg::type_id::create("CR2_seq");
	DR_RD_seq = spi_DR_RD_reg::type_id::create("DR_RD_seq");
        endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);                
		//loading data in TX buffer
            
		//full duplex Rx sequence
		seq.start(s_env.s_agnt.s_seqr);

		//Configuring the register for full duplex
		CR2_seq.spi_ral = s_env.spi_ral_mod;
                CR2_seq.start(s_env.agnt.seqr);
		
	        CR1_seq.spi_ral = s_env.spi_ral_mod;
                CR1_seq.start(s_env.agnt.seqr);
                
		//Reading RX buffer
		DR_RD_seq.spi_ral = s_env.spi_ral_mod;
                DR_RD_seq.start(s_env.agnt.seqr);

		phase.phase_done.set_drain_time(this, 220ns);
		phase.drop_objection(this);

	endtask 

endclass 


class spi_Full_duplex_Tx_test extends base_test;

	`uvm_component_utils(spi_Full_duplex_Tx_test)
        //Reg sequence for fullduplex Config
	spi_CR1_reg CR1_seq;
	spi_CR2_reg CR2_seq;

	//Reg sequence for Transmission
	spi_DR_WR_reg DR_WR_seq;

	function new(string name = "spi_Full_duplex_Tx_test", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
	super.build_phase(phase);
      	
	CR1_seq = spi_CR1_reg::type_id::create("CR1_seq");
	CR2_seq = spi_CR2_reg::type_id::create("CR2_seq");
	DR_WR_seq = spi_DR_WR_reg::type_id::create("DR_WR_seq");
        endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
	                
		//loading data in TX buffer
                DR_WR_seq.spi_ral = s_env.spi_ral_mod;
                DR_WR_seq.start(s_env.agnt.seqr);

		//Configuring the register for full duplex
		CR2_seq.spi_ral = s_env.spi_ral_mod;
                CR2_seq.start(s_env.agnt.seqr);
		
	        CR1_seq.spi_ral = s_env.spi_ral_mod;
                CR1_seq.start(s_env.agnt.seqr);
                
		phase.phase_done.set_drain_time(this, 220ns);
		phase.drop_objection(this);

	endtask 

endclass 



class spi_all_reg extends base_test;

       `uvm_component_utils(spi_all_reg)

        spi_basic_sequence bseq;
	spi_CR1_reg CR1_seq;
	spi_DR_WR_reg DR_WR_seq;
        spi_DR_RD_reg DR_RD_seq;
	spi_CR2_reg  CR2_seq;
	spi_SR_reg   SR_seq;
        spi_reset   rst;
	function new(string name = "spi_all_reg", uvm_component parent = null);
	super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	CR1_seq = spi_CR1_reg::type_id::create("CR1_seq");
	CR2_seq = spi_CR2_reg::type_id::create("CR2_seq");
	SR_seq = spi_SR_reg::type_id::create("SR_seq");
	DR_WR_seq = spi_DR_WR_reg::type_id::create("DR_WR_seq");
        DR_RD_seq = spi_DR_RD_reg::type_id::create("DR_RD_seq");
        bseq = spi_basic_sequence::type_id::create("bseq");
        rst = spi_reset::type_id::create("rst");
        endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
                bseq.start(s_env.agnt.seqr);
                CR1_seq.spi_ral = s_env.spi_ral_mod;
                CR1_seq.start(s_env.agnt.seqr);
		rst.start(s_env.agnt.seqr);
                CR2_seq.spi_ral = s_env.spi_ral_mod;
                CR2_seq.start(s_env.agnt.seqr);
                SR_seq.spi_ral = s_env.spi_ral_mod;
                SR_seq.start(s_env.agnt.seqr);
                DR_WR_seq.spi_ral = s_env.spi_ral_mod;
                DR_WR_seq.start(s_env.agnt.seqr);
		rst.start(s_env.agnt.seqr);
		DR_RD_seq.spi_ral = s_env.spi_ral_mod;
                DR_RD_seq.start(s_env.agnt.seqr);
            
		phase.drop_objection(this);

	endtask 

endclass


class spi_FD_TX_lsb_dff extends base_test;

	`uvm_component_utils(spi_FD_TX_lsb_dff)
         //00 seq
	 spi_dff0_lsb0 seq00;
        //01
         spi_dff0_lsb1 seq01;
	//10
	spi_dff1_lsb0 seq10;
	//11
	spi_dff1_lsb1 seq11;
	//dr
        spi_DR_WR_reg DR_WR_seq;
        //sequence for MISO transmission
        spi_fd_sequence seq;
	function new(string name = "spi_FD_TX_lsb_dff", uvm_component parent = null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
	super.build_phase(phase);
        seq00 = spi_dff0_lsb0::type_id::create("seq00");
        seq01 = spi_dff0_lsb1::type_id::create("seq01");
	seq10 = spi_dff1_lsb0::type_id::create("seq10");
	seq11 = spi_dff1_lsb1::type_id::create("seq11");


	DR_WR_seq = spi_DR_WR_reg::type_id::create("DR_WR_seq");
        endfunction

	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
		seq00.spi_ral = s_env.spi_ral_mod;
		seq00.start(s_env.agnt.seqr);
		DR_WR_seq.spi_ral = s_env.spi_ral_mod;
                DR_WR_seq.start(s_env.agnt.seqr);
                #610;

		seq01.spi_ral = s_env.spi_ral_mod;
		seq01.start(s_env.agnt.seqr);
		DR_WR_seq.spi_ral = s_env.spi_ral_mod;
                DR_WR_seq.start(s_env.agnt.seqr);
                #610;

		seq10.spi_ral = s_env.spi_ral_mod;
		seq10.start(s_env.agnt.seqr);
		DR_WR_seq.spi_ral = s_env.spi_ral_mod;
                DR_WR_seq.start(s_env.agnt.seqr);
		#1220;

		seq11.spi_ral = s_env.spi_ral_mod;
		seq11.start(s_env.agnt.seqr);
		DR_WR_seq.spi_ral = s_env.spi_ral_mod;
                DR_WR_seq.start(s_env.agnt.seqr);
		#1200;

		phase.phase_done.set_drain_time(this, 610ns);
		phase.drop_objection(this);

	endtask 

endclass 

