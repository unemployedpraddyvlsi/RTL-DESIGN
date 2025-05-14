// ================ TX MAC INPUTMONITOR CLASS (COMPONENT) =================

class tx_mac_inputmonitor extends uvm_monitor;
																				// ================ FACTORY REGISTRATION ==================
	`uvm_component_utils(tx_mac_inputmonitor)
																			    // ========== HANDLES DECLARATION ===========
	sequence_item req;

	virtual inf h_vinf;
	
	uvm_analysis_port #(sequence_item) h_tx_mac_inputmonitor_port;	
																				// =================== COMPONENT CONSTRUCTION ===================
	function new(string name = "tx_inputmonitor",uvm_component parent);

		super.new(name,parent);

	endfunction
																				// =============== BUILD PHASE =================
	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		req = sequence_item :: type_id :: create ("req");

		assert(uvm_config_db #(virtual inf) :: get(this,"","Interface",h_vinf));		// GETTING INTERFACE SIGNALS
		
		h_tx_mac_inputmonitor_port = new("h_tx_mac_inputmonitor_port",this);
				
		`uvm_info("IN THE TX INPUTMONITOR CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);
		
	endfunction
	
	task run_phase(uvm_phase phase);											//

		super.run_phase(phase);

		forever @(h_vinf.cb_tx_mac_monitor)begin
						
			req.MCrS 	= 	h_vinf.cb_tx_mac_monitor.MCrS ; 
			
			h_tx_mac_inputmonitor_port.write(req);
						
					
		end
      
      `uvm_info("IN THE TX MAC INPUTMONITOR CLASS","RUN PHASE IS COMPLETED",UVM_DEBUG);
		
	endtask
	
endclass