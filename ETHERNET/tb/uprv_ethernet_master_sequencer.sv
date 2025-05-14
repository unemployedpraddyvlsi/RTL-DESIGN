// ================== MASTER SEQUENCER CLASS (COMPONENT) =================

class master_sequencer extends uvm_sequencer#(sequence_item);

	`uvm_component_utils(master_sequencer)										// ============== FACTORY REGISTRATION ===============

	function new(string name = "master_sequencer",uvm_component parent);		// ============== COMPONENT CONSTRUCTION ==============

		super.new(name,parent);
		
	endfunction

endclass