//=========================== MAIN ENVIRONMENT CLASS (COMPONENT) ===========================

class main_environment extends uvm_env;

	`uvm_component_utils(main_environment)										// ================ FACTORY REGISTRATION ==================

	apb_environment h_apb_env;													// ========== HANDLES DECLARATION ===========

	tx_mac_environment h_tx_mac_env;

	coverage h_coverage;

	tx_scoreboard h_tx_scoreboard;
	
	//config_class h_config_class;
  
  	virtual_sequencer h_virtual_sequencer;
  	


	function new(string name = "main_environment",uvm_component parent);

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);

		super.build_phase(phase);
	
		//h_config_class = config_class :: type_id ::create("h_config_class");		

		h_apb_env = apb_environment :: type_id :: create ("h_apb_env",this);

		h_tx_mac_env = tx_mac_environment :: type_id :: create ("h_tx_mac_env",this);

		h_coverage = coverage :: type_id :: create ("h_coverage",this);

		h_tx_scoreboard = tx_scoreboard :: type_id :: create ("h_tx_scoreboard",this);
      
      	h_virtual_sequencer = virtual_sequencer::type_id::create("h_virtual_sequencer",this);

		//uvm_config_db #(config_class)::set(null,"*","config_class",h_config_class);

		//uvm_config_db #(config_class)::set(null,"h_apb_env.h_tx_active_agent.*","config_class",h_config_class);
		

	
		`uvm_info("IN THE MAIN ENV CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);

	endfunction
	
	function void connect_phase(uvm_phase phase);
	
		super.connect_phase(phase);
      
      	h_apb_env.h_apb_env_export.connect(h_tx_scoreboard.tx_score_ip_imp_port);
      
      	h_tx_mac_env.h_tx_mac_env_pct_export.connect(h_tx_scoreboard.tx_score_op_imp_port);
		
		h_apb_env.h_apb_env_export_for_coverage.connect(h_coverage.h_tx_coverage_imp);
		
		h_tx_mac_env.h_tx_mac_env_act_export.connect(h_coverage.h_tx_mac_coverage_imp);
      
      	h_virtual_sequencer.h_master_sequencer = h_apb_env.h_master_active_agent.h_master_sequencer;
      
      	h_virtual_sequencer.h_slave_sequencer = h_apb_env.h_slave_active_agent.h_slave_sequencer;
      
      	h_virtual_sequencer.h_tx_mac_sequencer = h_tx_mac_env.h_tx_mac_active_agent.h_tx_mac_sequencer;
      	

		
		`uvm_info("IN THE MAIN ENV CLASS","CONNECT PHASE IS COMPLETED",UVM_DEBUG);

	
	endfunction
	
	
	
	
endclass