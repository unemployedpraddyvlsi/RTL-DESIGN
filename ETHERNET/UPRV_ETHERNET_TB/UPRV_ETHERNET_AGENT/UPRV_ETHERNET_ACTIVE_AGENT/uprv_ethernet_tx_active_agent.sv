// =============================== TX ACTIVE_AGENT CLASS (COMPONENT) ==================================

class tx_active_agent extends uvm_agent;

	`uvm_component_utils(tx_active_agent)										// ================ FACTORY REGISTRATION ==================

	tx_inputmonitor h_tx_inputmonitor;
	
	uvm_analysis_export # (sequence_item) h_tx_active_agent_export,h_tx_active_agent_export_for_coverage;
												// ========== HANDLES DECLARATION ===========

	function new(string name = "tx_active_agent",uvm_component parent);			// =================== COMPONENT CONSTRUCTION ===================

			super.new(name,parent);
		
	endfunction

	function void build_phase (uvm_phase phase);								// ================ BUILD PHASE ==================
	
		super.build_phase(phase);

		h_tx_inputmonitor = tx_inputmonitor:: type_id :: create ("h_tx_inputmonitor",this);
		
		h_tx_active_agent_export = new("h_tx_active_agent_export",this);
		
		h_tx_active_agent_export_for_coverage = new("h_tx_active_agent_export_for_coverage",this);
		
		`uvm_info("IN THE TX ACTIVE_AGENT CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);
				       
	endfunction
	
	function void connect_phase(uvm_phase phase);
	
		super.connect_phase(phase);
		
		h_tx_inputmonitor.h_tx_inputmonitor_port.connect(this.h_tx_active_agent_export);
		
		h_tx_inputmonitor.h_tx_inputmonitor_port_for_coverage.connect(this.h_tx_active_agent_export_for_coverage);
	
		`uvm_info("IN THE TX ACTIVE AGENT CLASS","CONNECT PHASE IS COMPLETED",UVM_DEBUG);

	
	endfunction

endclass