																				// ==================== OUTPUT MONITOR ====================

class tx_output_monitor extends uvm_monitor;

	`uvm_component_utils(tx_output_monitor)										// ================ FACTORY REGISTRATION ==================
	
																				// ========== HANDLES DECLARATION ===========
	sequence_item req;
	
	virtual inf h_vinf;
																				// =================== COMPONENT CONSTRUCTION ===================
	function new(string name = "tx_outputmonitor",uvm_component parent);
		
		super.new(name,parent);
			
	endfunction
																				// =============== BUILD PHASE =================
	function void build_phase(uvm_phase phase);
		
		super.build_phase(phase);
			
		req = sequence_item :: type_id :: create ("req");
			
		assert(uvm_config_db #(virtual inf) :: get(this,"","Interface",h_vinf));
			
		`uvm_info("IN THE TX OUTPUT MONITOR CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);		
			
	endfunction
																				// ============== RUN PHASE ================
	
	task run_phase(uvm_phase phase);
		
		super.run_phase(phase);
			
		forever @(h_vinf.cb_monitor)begin
			
			
			if(h_vinf.pready_o == 1) begin
			
		  		req.pready_o    = h_vinf.cb_monitor.pready_o;					// =============== OUTPUT SIGNALS =================
			  		
		  		req.prdata_o 	= h_vinf.cb_monitor.prdata_o; 
		  		
		  		$display($time,"+++++++++++++++++++++++++THE DATA GIVEN BY DUV = %d++++++++++++++++++++++++++++",req.prdata_o);
		  		
		  	end
		  			
		end
          	
		`uvm_info("IN THE TX OUTPUT MONITOR CLASS","RUN PHASE IS COMPLETED",UVM_DEBUG);		
          	
	endtask

endclass