class spi_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(spi_scoreboard)

	int array[int];
	int write_count;
	int read_count;
	int data_match_counter;
	int data_mismatch_counter;
	int data_x_counter;

//	packet que[$];
	
	virtual spi_interface sb_vi;
	
	//declaring analysis port handle
	uvm_analysis_imp#(packet,spi_scoreboard) aip;
	
	function new(string name = "spi_scoreboard",uvm_component parent = null);
		super.new(name,parent);		
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
			aip = new("aip", this);
	endfunction

	//write
	function void write(input packet pkt);
	if((pkt.PWRITE == 1) && (pkt.PENABLE == 1) && (pkt.PSEL == 1))
	begin
		`uvm_info(get_full_name(),$sformatf("INSIDE write"),UVM_LOW)
		pkt.print();

	array[pkt.PADDR] = pkt.PWDATA;
	foreach(array[i])begin
	`uvm_info(get_full_name(),$sformatf("PADDR = %0h, PWDATA = %0h", i, array[i]),UVM_LOW)
	write_count++;
	end
	end

	if((pkt.PWRITE == 0) && (pkt.PENABLE == 1) && (pkt.PSEL == 1))
	begin
	    `uvm_info(get_full_name(),$sformatf("inside read"),UVM_LOW)	
	    	read_count++;

	    if(array.exists(pkt.PADDR))
		    
		begin
		if(array[pkt.PADDR] == pkt.PRDATA)
		begin
			`uvm_info(get_full_name(),$sformatf("DATA Match:: PADDR = %0h, PRDATA = %0h", pkt.PADDR,pkt.PRDATA),UVM_LOW)
			data_match_counter++;
		end
	else
		
	begin
	`uvm_error(get_full_name(),$sformatf("DATA Mismatch:: PADDR = %0h, PRDATA = %0h", pkt.PADDR,pkt.PRDATA))
		data_mismatch_counter++;
	end
		end
	
       else
	begin
	if(pkt.PRDATA === 'X)
	begin
	`uvm_info(get_full_name(),$sformatf(" PADDR = %0h, PRDATA = %0h",pkt.PADDR,pkt.PRDATA),UVM_LOW)
	end
	else
	begin
	`uvm_error(get_full_name(),$sformatf("Data Unknown"))
		data_x_counter++;
	end
		end
	end

        endfunction

	  function void report_phase (uvm_phase phase);
	   super.report_phase(phase);
	     foreach(array[i])
	     `uvm_info(get_type_name(),$sformatf(" WRITE_VALUES array[%0h] = %0h",i,array[i]),UVM_LOW)
	     `uvm_info(get_type_name(),$sformatf(" -------------------------------------------" ),UVM_LOW)
	     `uvm_info(get_type_name(),$sformatf(" report---total no of  writes=%0d",write_count),UVM_LOW)
		 `uvm_info(get_type_name(),$sformatf(" report---total no of reads=%0d",read_count),UVM_LOW)
		 `uvm_info(get_type_name(),$sformatf(" report---total no of  matches=%0d",data_match_counter),UVM_LOW)
	     `uvm_info(get_type_name(),$sformatf(" report---total no of mismatches=%0d",data_mismatch_counter),UVM_LOW)
	     `uvm_info(get_type_name(),$sformatf(" report---total no of unknowns=%0d",data_x_counter),UVM_LOW)
		 `uvm_info(get_type_name(),$sformatf("  --------------------------------------------" ),UVM_LOW);
		 
	     endfunction
 endclass
  

