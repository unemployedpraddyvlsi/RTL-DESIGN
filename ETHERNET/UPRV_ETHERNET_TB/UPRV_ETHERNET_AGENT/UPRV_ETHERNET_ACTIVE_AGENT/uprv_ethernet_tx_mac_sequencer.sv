// ================== TX_MAC SEQUENCER CLASS (COMPONENT) =================

class tx_mac_sequencer extends uvm_sequencer#(sequence_item);

	`uvm_component_utils(tx_mac_sequencer)										// ============== FACTORY REGISTRATION ===============

	function new(string name = "tx_mac_sequencer",uvm_component parent);		// ============== COMPONENT CONSTRUCTION ==============

		super.new(name,parent);

	endfunction

endclass