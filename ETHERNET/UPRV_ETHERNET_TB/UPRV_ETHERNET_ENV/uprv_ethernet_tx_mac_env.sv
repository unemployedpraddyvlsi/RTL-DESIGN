//=========================== TX MAC ENVIRONMENT CLASS (COMPONENT) ===========================

class tx_mac_environment extends uvm_env;

	`uvm_component_utils(tx_mac_environment)

	tx_mac_active_agent h_tx_mac_active_agent;									// ========== HANDLES DECLARATION ===========

	tx_mac_passive_agent h_tx_mac_passive_agent;
	
  	uvm_analysis_export # (sequence_item) h_tx_mac_env_act_export;
  
  	uvm_analysis_export # (sequence_item) h_tx_mac_env_pct_export;

	function new(string name = "tx_mac_environment",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
	
		h_tx_mac_active_agent = tx_mac_active_agent :: type_id :: create ("h_tx_mac_active_agent",this);

		h_tx_mac_passive_agent = tx_mac_passive_agent :: type_id :: create ("h_tx_mac_passive_agent",this);
		
		h_tx_mac_env_act_export = new ("h_tx_mac_env_act_export",this);
      
      	h_tx_mac_env_pct_export = new ("h_tx_mac_env_pct_export",this);
		
		`uvm_info("IN THE TX MAC  ENV CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);
				
	endfunction
	
	function void connect_phase(uvm_phase phase);
	
		super.connect_phase(phase);
		
		h_tx_mac_active_agent.h_tx_mac_active_agent_export.connect(this.h_tx_mac_env_act_export);
      
      	h_tx_mac_passive_agent.h_tx_mac_passive_agent_export.connect(this.h_tx_mac_env_pct_export);
	
		`uvm_info("IN THE TX MAC ENV CLASS","CONNECT PHASE IS COMPLETED",UVM_DEBUG);

	
	endfunction

	
endclass