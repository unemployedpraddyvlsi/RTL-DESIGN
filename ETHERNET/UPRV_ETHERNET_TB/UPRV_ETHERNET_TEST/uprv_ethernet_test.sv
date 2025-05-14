// ====================== TEST CLASS (COMPONENT)=====================

class test extends uvm_test;
																				
	`uvm_component_utils(test)													// ================ FACTORY REGISTRATION ==================

	main_environment h_main_env;

  
  	virtual_sequence h_virtual_sequence;
  
  	config_class h_config_class;
																	
	function new(string name = "test",uvm_component parent);					// =================== COMPONENT CONSTRUCTION ===================

		super.new(name,parent);

	endfunction
		
																				
	function void build_phase(uvm_phase phase);									// ================ BUILD_PHASE ===============

		super.build_phase(phase);
		
		h_config_class = config_class :: type_id ::create("h_config_class");	

		h_main_env = main_environment :: type_id :: create ("h_main_env",this);
		
		uvm_config_db #(config_class)::set(null,"*","config_class",h_config_class);
		
		`uvm_info("IN THE TEST CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);
			
	endfunction

																				
	function void end_of_elaboration_phase(uvm_phase phase);					// =============== printing topology in end of elobaration phase ===============

		super.end_of_elaboration_phase(phase);

		uvm_top.print_topology();
				
		`uvm_info("IN THE TEST CLASS","END OF ELABORATION PHASE IS COMPLETED",UVM_DEBUG);

	endfunction 
																				// ===================== run phase ===============

			task run_phase (uvm_phase phase);
			
              
              	h_virtual_sequence = virtual_sequence::type_id::create("h_virtual_sequence");


				phase.raise_objection(this,"RAISE OBJECTION");
              
              		h_virtual_sequence.start(h_main_env.h_virtual_sequencer);
					
					#1000000;
					
				phase.drop_objection(this,"DROP OBJECTION");
				
				`uvm_info("IN THE TEST CLASS","RUN PHASE IS COMPLETED",UVM_DEBUG);

			endtask

														
		
endclass