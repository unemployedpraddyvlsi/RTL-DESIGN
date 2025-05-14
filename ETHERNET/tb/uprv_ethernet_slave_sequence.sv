

class slave_sequence extends uvm_sequence#(sequence_item);

	`uvm_object_utils(slave_sequence)														//=========== FACTORY REGISTRATION ===========
	
	config_class h_config_class;	
  
  	virtual inf h_vinf;

	function new(string name = "slave_sequence");											// ============== OBJECT CONSTRUCTION =============

			super.new(name);

	endfunction

	task body();																//============ RANDOMIZING THE STIMULUS ==========
      
      	bit [31:0] temp_var;
      
      	bit[31:0] pop_var,temp_pointer;
      
      	bit [15:0] lenght_value;
      
      	bit[31:0] quotient;

		req = sequence_item :: type_id :: create("req");
		
		assert(uvm_config_db #(config_class)::get(null,"","config_class",h_config_class));
      
      	assert(uvm_config_db #(virtual inf) :: get(null,"","Interface",h_vinf));
      
      	begin
          
          	pop_var = h_config_class.bd_length_type_queue_slave_sequence.pop_back();       // *** need to write the condition for rd in bd,s for multiple bd;s
          	
          	temp_pointer = h_config_class.bd_length_type_queue_slave_sequence.pop_back();     
          
          	lenght_value = pop_var[31:16];
          
          	if((lenght_value%4) == 0) begin
            
            	quotient = ((lenght_value/4));
            
            	repeat(quotient) begin
            	
            		wait((h_vinf.m_psel_o    == 1)&&(h_vinf.m_penable_o == 1))
            		
            		@(h_vinf.cb_slave_driver)
              
              			start_item(req);
              			
                  			assert(req.randomize()with {m_pready_i == 1;} );
      
      					finish_item(req);
      			
      				
      				@(h_vinf.cb_slave_driver)
      				
      					
      					start_item(req);
      
                  			assert(req.randomize()with {m_pready_i == 0;} );
      
      					finish_item(req);
      					
            	end

          	end
          
          	else begin
              
              quotient = ((lenght_value/4) +1);
              
            	repeat(quotient) begin
            		
            		wait((h_vinf.m_psel_o    == 1)&&(h_vinf.m_penable_o == 1))
            		
            		@(h_vinf.cb_slave_driver)
              
              			start_item(req);
              			
                  			assert(req.randomize()with {m_pready_i == 1;} );
      
      					finish_item(req);
      			
      				
      				@(h_vinf.cb_slave_driver)
      				
      					
      					start_item(req);
      
                  			assert(req.randomize()with {m_pready_i == 0;} );
      
      					finish_item(req);
      					
      					
            	end
            	
            end
            
          
        end
        
        
        begin
        
        start_item(req);
      
             assert(req.randomize()with {m_pready_i == 0;} );
      
      	finish_item(req);
        
        
        
        end
      
	endtask
  
endclass