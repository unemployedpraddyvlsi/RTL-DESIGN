// ================= PASSIVE AGENT CLASS (COMPONENT) =================

class tx_passive_agent extends uvm_agent;

	`uvm_component_utils(tx_passive_agent)									// ================ FACTORY REGISTRATION ==================

	tx_output_monitor h_tx_outputmonitor;								// ========== HANDLES DECLARATION ===========
	
	
	function new(string name = "passive_agent",uvm_component parent);			// =================== COMPONENT CONSTRUCTION ===================

			super.new(name,parent);

	endfunction
		
	function void build_phase(uvm_phase phase);									// ================== BUILD PHASE ==============

		super.build_phase(phase);

		h_tx_outputmonitor = tx_output_monitor :: type_id :: create ("h_tx_outputmonitor",this);
		
		`uvm_info("IN THE TX PASSIVE_AGENT CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);

	endfunction

endclass