
class virtual_sequence extends uvm_sequence#(sequence_item);
  
  	`uvm_object_utils(virtual_sequence)
  
  	`uvm_declare_p_sequencer(virtual_sequencer)
  
  	master_sequence h_master_sequence;
  
  	slave_sequence h_slave_sequence;
  
  	tx_mac_sequence h_tx_mac_sequence;
  	
  	into_sequence h_into_sequence;
  	
  	config_class h_config_class;
  	
  	virtual inf h_vinf;
  	
  	bit[31:0] pop_var_1,temp_pointer_1,pop_var_2,temp_pointer_2;
  
  	function new(string name = "virtual_sequence");								// ============== OBJECT CONSTRUCTION =============

			super.new(name);

	endfunction
  
  	task body();
  
  		assert(uvm_config_db #(config_class)::get(null,"","config_class",h_config_class));
  		
  		assert(uvm_config_db #(virtual inf) :: get(null,"","Interface",h_vinf));
    
    	h_master_sequence = master_sequence::type_id::create("h_master_sequence");
    
    	h_slave_sequence = slave_sequence::type_id::create("h_slave_sequence");
    
    	h_tx_mac_sequence = tx_mac_sequence::type_id::create("h_tx_mac_sequence");
    	
    	h_into_sequence = into_sequence::type_id::create("h_into_sequence");
        
       
      	h_master_sequence.start(p_sequencer.h_master_sequencer);
      
      	h_config_class.register_configuration_completed = 1;					// indication for the completion of register configuration
      
      
      	repeat(h_config_class.TX_BD_NUM) begin
            
      		wait(h_config_class.trigger == 1)      		
      		
      		if(h_config_class.drop_conditions == 0) begin	
      
      			fork
      		
         			wait((h_vinf.m_psel_o == 1) && (h_vinf.m_penable_o == 0))
      	
      				h_slave_sequence.start(p_sequencer.h_slave_sequencer);
      
      				h_tx_mac_sequence.start(p_sequencer.h_tx_mac_sequencer);
      			
      			join
      			
      			h_config_class.checking = 1;									//indicates that all the drivings are over start the queue preparation 
      																			//in the input monitor to drive to scoreboard
      		
       			wait(h_vinf.int_o == 1)
       	
       			h_into_sequence.start(p_sequencer.h_master_sequencer);
       		
       			h_config_class.flag = 0;
       		
       			h_config_class.register_configuration_completed = 1;
       			
     		end
     		
     		else begin
     	
     			pop_var_1 = h_config_class.bd_length_type_queue_slave_sequence.pop_back();                       
          	
          		temp_pointer_1 = h_config_class.bd_length_type_queue_slave_sequence.pop_back();
          	
          	  	pop_var_2 = h_config_class.bd_length_type_queue_tx_mac_sequence.pop_back();                       
          	
          		temp_pointer_2 = h_config_class.bd_length_type_queue_tx_mac_sequence.pop_back();
          	
          		wait(h_vinf.int_o == 1)
          	
          		h_into_sequence.start(p_sequencer.h_master_sequencer);
          	
          		h_config_class.flag = 0;
       		
       			h_config_class.register_configuration_completed = 1;
     	
     		end
     	
		end 
    
  	endtask
  
endclass