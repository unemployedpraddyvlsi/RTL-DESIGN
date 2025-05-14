//=========================== APB ENVIRONMENT CLASS (COMPONENT) ===========================

class apb_environment extends uvm_env;											

	`uvm_component_utils(apb_environment)										// ============== FACTORY REGISTRATION ===============
																													
																				// ============== HANDLES DECLARATION ================
	master_active_agent h_master_active_agent;									

	slave_active_agent h_slave_active_agent;

	tx_active_agent h_tx_active_agent;
	
	tx_passive_agent h_tx_passive_agent;
	
	uvm_analysis_export # (sequence_item) h_apb_env_export,h_apb_env_export_for_coverage;

	function new(string name = "apb_environment",uvm_component parent);			// ============== COMPONENT CONSTRUCTION ==============

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);									// ========== BUILD PHASE ==========

		super.build_phase(phase);
	
		h_master_active_agent = master_active_agent :: type_id :: create ("h_master_active_agent",this);

		h_slave_active_agent = slave_active_agent :: type_id :: create ("h_slave_active_agent",this);

		h_tx_active_agent = tx_active_agent :: type_id :: create ("h_tx_active_agent",this);
		
		h_tx_passive_agent = tx_passive_agent :: type_id :: create ("h_tx_passive_agent",this);
		
		h_apb_env_export = new ("h_apb_env_export",this);
		
		h_apb_env_export_for_coverage = new("h_apb_env_export_for_coverage",this);
		
		`uvm_info("IN THE APB ENV CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);
		
	endfunction
	
	function void connect_phase(uvm_phase phase);
	
		super.connect_phase(phase);
		
		h_tx_active_agent.h_tx_active_agent_export.connect(this.h_apb_env_export);
		
		h_tx_active_agent.h_tx_active_agent_export_for_coverage.connect(this.h_apb_env_export_for_coverage);
	
		`uvm_info("IN THE APB ENV CLASS","CONNECT PHASE IS COMPLETED",UVM_DEBUG);

	
	endfunction
	
endclass