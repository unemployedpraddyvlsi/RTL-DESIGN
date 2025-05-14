
// ==================== MASTER DRIVER CLASS (COMPONENT) ====================

class master_driver extends uvm_driver#(sequence_item);

	`uvm_component_utils(master_driver)											// ================ FACTORY REGISTRATION ==================

	sequence_item req;															// ================ HANDLE DECLARATION ================

	virtual inf h_vinf;															// VIRTUAL INTERFACE HANDLE CREATION

	function new(string name = "master_driver",uvm_component parent);			// =================== COMPONENT CONSTRUCTION ===================

			super.new(name,parent);

		endfunction
	
	function void build_phase(uvm_phase phase);									// ======================== BUILD PHASE ========================

		super.build_phase(phase);

      assert(uvm_config_db #(virtual inf) :: get(this,this.get_full_name,"Interface",h_vinf));

		`uvm_info("IN THE MASTER DRIVER CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);
      
      	req = sequence_item :: type_id :: create ("req");

		forever @(h_vinf.cb_master_driver) begin
		 
		
			seq_item_port.get_next_item(req);									// passing acknowledge to sequencer for the sequence
			         
          	h_vinf.cb_master_driver.prstn_i 	<= req.prstn_i;
	
			h_vinf.cb_master_driver.psel_i 		<= req.psel_i;
          
          	h_vinf.cb_master_driver.penable_i 	<= req.penable_i;
          	
			h_vinf.cb_master_driver.pwrite_i 	<= req.pwrite_i;

			h_vinf.cb_master_driver.paddr_i		<= req.paddr_i;
          
          	h_vinf.cb_master_driver.pwdata_i	<= req.pwdata_i;
          	
          	$display($time,"^^^^^^^^^^^^^^^^^^IN THE MASTER DRIVER ^^^^^^^^^^^^^^^^^^^^^ \n paddr_i = %d  \n pwdata_i = %d \n pwrite_i = %d ,\n psel_i = %d ,\n penable_i = %d ,\n  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^",req.paddr_i,req.pwdata_i,req.pwrite_i,req.psel_i,req.penable_i);

			seq_item_port.item_done();											// received acknowledge

		end
      
      `uvm_info("IN THE MASTER DRIVER CLASS","RUN PHASE IS COMPLETED",UVM_DEBUG);

	endtask

endclass

