// ==================== TX MAC DRIVER CLASS (COMPONENT) ====================

class tx_mac_driver extends uvm_driver#(sequence_item);

	`uvm_component_utils(tx_mac_driver)											// ================ FACTORY REGISTRATION ==================

	sequence_item req;															// ================ HANDLE DECLARATION ================

	virtual inf h_vinf;															// VIRTUAL INTERFACE HANDLE CREATION

	function new(string name = "tx_mac_driver",uvm_component parent);			// =================== COMPONENT CONSTRUCTION ===================

		super.new(name,parent);

	endfunction
	
	function void build_phase(uvm_phase phase);									// ======================== BUILD PHASE ========================

		super.build_phase(phase);

		req = sequence_item :: type_id :: create ("req");

		assert(uvm_config_db #(virtual inf) :: get(this,"","Interface",h_vinf));
		
		`uvm_info("IN THE TX MAC DRIVER CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);

	endfunction
	
	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		forever @(h_vinf.cb_tx_mac_driver) begin
		
			seq_item_port.get_next_item(req);										// passing acknowledge to sequencer for the sequence

					h_vinf.cb_tx_mac_driver.MCrS <= req.MCrS ;
					
			seq_item_port.item_done();												// received acknowledge
			

		end
      
      `uvm_info("IN THE TX MAC DRIVER CLASS","RUN PHASE IS COMPLETED",UVM_DEBUG);

	endtask

endclass