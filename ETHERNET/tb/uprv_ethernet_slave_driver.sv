
// ==================== SLAVE DRIVER CLASS (COMPONENT) ====================

class slave_driver extends uvm_driver#(sequence_item);

	`uvm_component_utils(slave_driver)											// ================ FACTORY REGISTRATION ==================

	sequence_item req;															// ================ HANDLE DECLARATION ================

	virtual inf h_vinf;															// VIRTUAL INTERFACE HANDLE CREATION
  
  	bit[31:0]temp_m_paddr_o;

	function new(string name = "slave_driver",uvm_component parent);			// =================== COMPONENT CONSTRUCTION ===================

			super.new(name,parent);

	endfunction
	
	function void build_phase(uvm_phase phase);									// ======================== BUILD PHASE ========================

		super.build_phase(phase);

		req = sequence_item :: type_id :: create ("req");

		assert(uvm_config_db #(virtual inf) :: get(this,"","Interface",h_vinf));
		
		`uvm_info("IN THE SLAVE DRIVER CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);

	endfunction

	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		forever @(h_vinf.cb_slave_driver) begin
          	
          	seq_item_port.get_next_item(req);
          	
				h_vinf.cb_slave_driver.m_prdata_i <= req.m_prdata_i;
                     
				h_vinf.cb_slave_driver.m_pready_i <= req.m_pready_i;

          	seq_item_port.item_done();
                    
		end
      
      `uvm_info("IN THE SLAVE DRIVER CLASS","RUN PHASE IS COMPLETED",UVM_DEBUG);

	endtask

endclass