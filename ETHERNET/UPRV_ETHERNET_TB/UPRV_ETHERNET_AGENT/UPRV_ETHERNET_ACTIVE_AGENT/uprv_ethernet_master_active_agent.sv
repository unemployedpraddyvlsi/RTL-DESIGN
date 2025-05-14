// =============================== MASTER ACTIVE_AGENT CLASS (COMPONENT) ==================================

class master_active_agent extends uvm_agent;

	`uvm_component_utils(master_active_agent)									// ================ FACTORY REGISTRATION ==================

	master_sequencer h_master_sequencer;										// ========== HANDLES DECLARATION ===========

	master_driver h_master_driver;
			
	function new(string name = "master_active_agent",uvm_component parent);		// =================== COMPONENT CONSTRUCTION ===================

		super.new(name,parent);

	endfunction

	function void build_phase (uvm_phase phase);								// ================ BUILD PHASE ==================

		super.build_phase(phase);

		h_master_sequencer = master_sequencer :: type_id :: create ("h_master_sequencer",this);

		h_master_driver = master_driver :: type_id :: create ("h_master_driver",this);

		`uvm_info("IN THE MASTER ACTIVE AGENT","BUILD PHASE IS COMPLETED",UVM_DEBUG);

	endfunction

	function void connect_phase (uvm_phase phase);								// ============= CONNECT PHASE ==============

		super.connect_phase(phase);

		h_master_driver.seq_item_port.connect(h_master_sequencer.seq_item_export);

		`uvm_info("IN THE MASTER ACTIVE AGENT","CONNECT PHASE IS COMPLETED",UVM_DEBUG);

	endfunction

endclass