

class tx_mac_sequence extends uvm_sequence#(sequence_item);

	`uvm_object_utils(tx_mac_sequence)														//=========== FACTORY REGISTRATION ===========
	
	config_class h_config_class;	
  
  	virtual inf h_vinf;

	function new(string name = "tx_mac_sequence");											// ============== OBJECT CONSTRUCTION =============

			super.new(name);

	endfunction

	task body();																			//============ RANDOMIZING THE STIMULUS ==========
      
      
      	bit[31:0] pop_var,temp_pointer;
      
      	bit [31:0] temp_var;
      
      	bit [15:0] lenght_value ;
      
      	

		req = sequence_item :: type_id :: create("req");
		
		assert(uvm_config_db #(config_class)::get(null,"","config_class",h_config_class));
      
      	assert(uvm_config_db #(virtual inf) :: get(null,"","Interface",h_vinf));					// GETTING INTERFACE SIGNALS
      	      
      	begin
          
          	pop_var = h_config_class.bd_length_type_queue_tx_mac_sequence.pop_back();       // *** need to write the condition for rd in bd,s for multiple bd;s
          	
          	temp_pointer = h_config_class.bd_length_type_queue_tx_mac_sequence.pop_back();
          
          	lenght_value = pop_var[31:16];
        
        	temp_var =((52+(lenght_value*2)) +1);
        	
        	wait(h_vinf.MTxEn == 1)
          
			repeat(temp_var) begin
          
          		start_item(req);
      
              		assert(req.randomize()with {MCrS == 1;} );
      
              	finish_item(req);
          
        	end
        
      	end
      
      
      	begin
          
          	start_item(req);
      
          		assert(req.randomize()with {MCrS == 0;} );
      
      		finish_item(req);
      		
      	end
		
		
	endtask
  

endclass