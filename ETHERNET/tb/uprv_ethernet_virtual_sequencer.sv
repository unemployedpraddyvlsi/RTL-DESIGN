// ================== VIRTUAL SEQUENCER CLASS (COMPONENT) =================

class virtual_sequencer extends uvm_sequencer;

	`uvm_component_utils(virtual_sequencer)										// ============== FACTORY REGISTRATION ===============

  	master_sequencer h_master_sequencer;
  
  	slave_sequencer h_slave_sequencer;
  
  	tx_mac_sequencer h_tx_mac_sequencer;
  
  
	function new(string name = "virtual_sequencer",uvm_component parent);		// ============== COMPONENT CONSTRUCTION ==============

		super.new(name,parent);
		
	endfunction

endclass