// =============================== SLAVE ACTIVE_AGENT CLASS (COMPONENT) ==================================

class slave_active_agent extends uvm_agent;

	`uvm_component_utils(slave_active_agent)									// ================ FACTORY REGISTRATION ==================

	slave_sequencer h_slave_sequencer;											// ========== HANDLES DECLARATION ===========

	slave_driver h_slave_driver;
			
	function new(string name = "slave_active_agent",uvm_component parent);		// =================== COMPONENT CONSTRUCTION ===================

		super.new(name,parent);

	endfunction

	function void build_phase (uvm_phase phase);								// ================ BUILD PHASE ==================
	
		super.build_phase(phase);

		h_slave_sequencer = slave_sequencer :: type_id :: create ("h_slave_sequencer",this);

		h_slave_driver = slave_driver :: type_id :: create ("h_slave_driver",this);
		
		`uvm_info("IN THE SLAVE ACTIVE AGENT CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);
	       
	endfunction

	function void connect_phase (uvm_phase phase);	
							
		super.connect_phase(phase);

		h_slave_driver.seq_item_port.connect(h_slave_sequencer.seq_item_export);
		
		`uvm_info("IN THE SLAVE ACTIVE AGENT CLASS","CONNECT PHASE IS COMPLETED",UVM_DEBUG);
		
	endfunction


endclass