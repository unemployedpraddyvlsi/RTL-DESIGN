// =============================== TX MAC ACTIVE_AGENT CLASS (COMPONENT) ==================================

class tx_mac_active_agent extends uvm_agent;

	`uvm_component_utils(tx_mac_active_agent)									// ================ FACTORY REGISTRATION ==================

	tx_mac_sequencer h_tx_mac_sequencer;										// ========== HANDLES DECLARATION ===========

	tx_mac_driver h_tx_mac_driver;
	
	tx_mac_inputmonitor h_tx_mac_inputmonitor;
	
	uvm_analysis_export # (sequence_item) h_tx_mac_active_agent_export;
			
	function new(string name = "tx_mac_active_agent",uvm_component parent);		// =================== COMPONENT CONSTRUCTION ===================

		super.new(name,parent);
		
	endfunction

	function void build_phase (uvm_phase phase);								// ================ BUILD PHASE ==================
	
		super.build_phase(phase);

		h_tx_mac_sequencer = tx_mac_sequencer :: type_id :: create ("h_tx_mac_sequencer",this);

		h_tx_mac_driver = tx_mac_driver :: type_id :: create ("h_tx_mac_driver",this);
		
		h_tx_mac_inputmonitor = tx_mac_inputmonitor :: type_id :: create ("h_tx_mac_inputmonitor",this);
		
		h_tx_mac_active_agent_export = new("h_tx_mac_active_agent_export",this);
		
		`uvm_info("IN THE TX MAC ACTIVE_AGENT CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);
	       
	endfunction

	function void connect_phase (uvm_phase phase);								// ============= CONNECT PHASE ==============

		super.connect_phase(phase);

		h_tx_mac_driver.seq_item_port.connect(h_tx_mac_sequencer.seq_item_export);
		
		h_tx_mac_inputmonitor.h_tx_mac_inputmonitor_port.connect(this.h_tx_mac_active_agent_export);
		
		`uvm_info("IN THE TX MAC ACTIVE_AGENT CLASS","CONNECT PHASE IS COMPLETED",UVM_DEBUG);

	endfunction


endclass