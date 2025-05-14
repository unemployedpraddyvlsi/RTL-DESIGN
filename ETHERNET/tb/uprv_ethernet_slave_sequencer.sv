// ==================  SLAVE SEQUENCER CLASS (COMPONENT) =================

class slave_sequencer extends uvm_sequencer#(sequence_item);

	`uvm_component_utils(slave_sequencer)										// ============== FACTORY REGISTRATION ===============

	function new(string name = "slave_sequencer",uvm_component parent);			// ============== COMPONENT CONSTRUCTION ==============

		super.new(name,parent);

	endfunction

endclass