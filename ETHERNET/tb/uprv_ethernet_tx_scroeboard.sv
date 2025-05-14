// =============== SCOREBOARD CLASS (COMPONENT) ===============

class tx_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(tx_scoreboard)

	`uvm_analysis_imp_decl(_i_mon)												//Macro to declare an implementation port to input monitor to 
																				//differentiate the output and input monitor

	uvm_analysis_imp_i_mon#(sequence_item,tx_scoreboard)tx_score_ip_imp_port;   
		 																		//---implementation port for input monitor

	uvm_analysis_imp#(sequence_item,tx_scoreboard)tx_score_op_imp_port;   		//---implementation port for output monitor
		
	sequence_item req1,req2;
  
  	config_class h_config_class;
  		
  		
  	bit[7:0] verification_da_queue[$:5];										// temparory queues to compare the data from input and output monitor
  		
  	bit[7:0] design_da_queue[$:5];
  		
  	bit[7:0] verification_sa_queue[$:5];
  		
  	bit[7:0] design_sa_queue[$:5];
  		
  	bit[7:0] verification_l_t_queue[$:1];
  		
  	bit[7:0] design_l_t_queue[$:1];
  		
  	bit[7:0] verification_payload_queue[$];
  		
  	bit[7:0] design_payload_queue[$];
			
	virtual inf h_vinf;	
	
	function new(string name = "tx_scoreboard",uvm_component parent);
		
		super.new(name,parent);
			
	endfunction
		 
  	function void build_phase(uvm_phase phase);
    
    	super.build_phase(phase);
    
   		assert( uvm_config_db #(config_class)::get(this,"","config_class",h_config_class));
    
    	assert(uvm_config_db #(virtual inf) :: get(this,"","Interface",h_vinf));
    
    	tx_score_op_imp_port = new("tx_score_op_imp_port",this);
    
		tx_score_ip_imp_port = new("tx_score_ip_imp_port",this);
    
    	req1 = sequence_item::type_id::create("req1");
    
    	req2 = sequence_item::type_id::create("req2");
    
    
  	endfunction
	

	function write_i_mon(input sequence_item req1);
	
		this.req1=req1;
		
	endfunction

  	function write(input sequence_item req2);
  	
		this.req2=req2;
		
	endfunction

																				//============== task run phase 

	task run_phase(uvm_phase phase);
	
		super.run_phase(phase);
      
		forever begin
			
			#5000;
																				//if the input and output monitors completes the queue writing(preparation) 
																				//then only scoreboard comparion will be started
																				
			if((h_config_class.scoreboard_compare_trigger_flag_from_input == 1 )&&(h_config_class.scoreboard_compare_trigger_flag_from_output == 1)) begin
			
              	drop_frame_display();
              
              	good_frame_display();
              
              	h_config_class.scoreboard_compare_trigger_flag_from_input = 0;
              
              	h_config_class.scoreboard_compare_trigger_flag_from_output = 0;
              
       
              end
             			
		end
		
	endtask
	
////////////////////////////////////////////////////////////////////////////////
// TASK TO CHECK THE DROP FRAME SEQUENCES 
//////////////////////////////////////////////////////////////////////////////// 

	task drop_frame_display;
      
      
      	if((h_config_class.drop_check_pass == 1) && (h_config_class.drop_check_fail == 0)) begin
      
			`uvm_info("IN THE SCOREBOARD","=======PASS=======THE DESIGN IS WORKED CORRECTLY THE FRAME IS DROPPED IN THE DESIGN WHEN DROP FRAME IS GIVEN AS INPUT============",UVM_HIGH)
        
        	resetting_the_flags();
 
      	end
      
      	else if((h_config_class.drop_check_pass == 0) && (h_config_class.drop_check_fail == 1)) begin
        
        	`uvm_info("IN THE SCOREBOARD","========FAIL======THE DESIGN IS NOT WORKED CORRECTLY THE FRAME IS NOT DROPPED IN THE DESIGN WHEN DROP FRAME IS GIVEN AS INPUT============",UVM_HIGH)
        
        	resetting_the_flags();
        
      	end
      
    endtask
    
////////////////////////////////////////////////////////////////////////////////
// TASK TO CHECK TRANSMITT FRAME BY THE DESIGN
////////////////////////////////////////////////////////////////////////////////
  
  	task good_frame_display();
  	
    
    	if((h_config_class.preamble_sfd_crc_check_pass == 1) &&(h_config_class.preamble_sfd_crc_check_fail == 0)) begin
      
      		$display("---------------------------------------------------------",$time,"-----------------------------------------------------------");
      
      		`uvm_info("IN THE SCOREBOARD","---------------PASS----------------PREAMBLE SFD CRC MATCHED------------------------------------------",UVM_HIGH)
      		
      		$display($time,"==============BATCH_PAYLOAD================== \n tx_input_queue      = %p; \n tx_mac_output_queue = %p;",req1.tx_input_queue,req2.tx_mac_output_queue,);
      
      		main_retreive();                                     				//calling the task to make the queues for da,sa,l/t,payload seaparately 
      																			//by taking the data from the queues which are given 
      																			//from the input and output monitors
      																			
      
      		
      		
      																			// 	comparing the input and output destination address queues
      
      		if(verification_da_queue == design_da_queue) begin
      		
      			$display($time,"==============IN THE SCOREBOARD  DA==================\n verification_da_queue = %p; \n design_da_queue       = %p;",verification_da_queue,design_da_queue);
 		       
 		       `uvm_info("IN THE SCOREBOARD","========PASS======DESTINATON ADDRESS MATCHED============",UVM_HIGH)
 		       
			end
			
 		   	else begin
 		   
 		   		$display($time,"==============IN THE SCOREBOARD  DA================== \n verification_da_queue = %p; \n design_da_queue       = %p;",verification_da_queue,design_da_queue);
 		     
 		     	`uvm_info("IN THE SCOREBOARD","========FAIL======DESTINATON ADDRESS MISMATCHED============",UVM_HIGH)
 		     
 		   	end
 		   
 		   
      																			// 	comparing the input and output source address queues 		   
 		   
 		   	if(verification_sa_queue == design_sa_queue) begin
 		   
 		   		$display($time,"==============IN THE SCOREBOARD  SA==================\n verification_sa_queue = %p; \n design_sa_queue       = %p;",verification_sa_queue,design_sa_queue);
 		       
 		     	`uvm_info("IN THE SCOREBOARD","========PASS======SOURCE ADDRESS MATCHED============",UVM_HIGH)
 		       
 		       
			end
		
 		   	else begin
 		   
 		   		$display($time,"==============IN THE SCOREBOARD  SA================== \n verification_sa_queue = %p; \n design_sa_queue       = %p;",verification_sa_queue,design_sa_queue);
 		     
 		     	`uvm_info("IN THE SCOREBOARD","========FAIL======SOURCE ADDRESS MISMATCHED============",UVM_HIGH)
 		     
 		   	end
 		   
 		   
      																			// 	comparing the input and output length or type queues 		   
 		   
 		   	if(verification_l_t_queue == design_l_t_queue) begin
 		   
 		   		$display($time,"==============IN THE SCOREBOARD  LENGTH_TYPE================== \n verification_l_t_queue = %p; \n design_l_t_queue       = %p;",verification_l_t_queue,design_l_t_queue);
 		       
 		     	`uvm_info("IN THE SCOREBOARD","========PASS======= LENGTHE/TYPE  MATCHED============",UVM_HIGH)
 		         
 		     end
		
 		   	else begin
 		   
 		   		$display($time,"==============IN THE SCOREBOARD  LENGTH_TYPE================== \n verification_l_t_queue = %p; \n design_l_t_queue       = %p;",verification_l_t_queue,design_l_t_queue);
 		     
 		     	`uvm_info("IN THE SCOREBOARD","========FAIL======LENGTH/TYPE  MISMATCHED============",UVM_HIGH)
 		     
 		   	end
 		   
 		   
      																			// 	comparing the input and output payload queues 		   
 		   
 		   	if(verification_payload_queue == design_payload_queue) begin
 		   
 		   		$display($time,"==============IN THE SCOREBOARD  PAYLOAD================== \n verification_payload_queue = %p; \n design_payload_queue       = %p; \n  verification_payload_queue_size = %0d, \n design_payload_queue_size = %0d",verification_payload_queue,design_payload_queue,verification_payload_queue.size(),design_payload_queue.size());
 		       
 		     	`uvm_info("IN THE SCOREBOARD","========PASS======PAYLOAD  MATCHED============",UVM_HIGH)
 		       
 		       
 		     end
 		
 		   	else begin
 		   
 		   		$display($time,"==============IN THE SCOREBOARD  PAYLOAD================== \n verification_payload_queue = %p; \n design_payload_queue       = %p;",verification_payload_queue,design_payload_queue);
 		       
 		     
 		     	`uvm_info("IN THE SCOREBOARD","========FAIL======PAYLOAD  MISMATCHED============",UVM_HIGH)
 		     
 		   	end
      
      
      		resetting_the_flags();												// calling the resetting task after complition of the comparision
      
      
    	end
    
    
    
    	else if((h_config_class.preamble_sfd_crc_check_pass == 0) &&(h_config_class.preamble_sfd_crc_check_fail == 1))begin 
    
    		$display("---------------------------------------------------------",$time,"-----------------------------------------------------------");
      
      		`uvm_info("IN THE SCOREBOARD","------------FAIL-------------------PREAMBLE SFD CRC MISMATCHED------------------------------------------",UVM_HIGH)
      
      
      																			// checking the preamble flags to find the duv given preamble is 
      																			//matched with the fixed preamble or not
      																			
      		if((h_config_class.preamble_check_pass_flag == 1) && (h_config_class.preamble_check_fail_flag == 0)) begin
        
        		`uvm_info("IN THE SCOREBOARD","=======PASS=======PREAMBLE MATCHED============",UVM_HIGH)
        
       		end
      
      		else if((h_config_class.preamble_check_pass_flag == 0) && (h_config_class.preamble_check_fail_flag == 1)) begin
        
        		`uvm_info("IN THE SCOREBOARD","========FAIL======PREAMBLE MISMATCHED============",UVM_HIGH)
        
      		end
      
      																			// checking the sfd flags to find the duv given sfd is 
      																			//matched with the fixed preamble or not
      
      		if((h_config_class.sfd_check_pass_flag == 1) && (h_config_class.sfd_check_fail_flag == 0)) begin
        
        		`uvm_info("IN THE SCOREBOARD","=======PASS=======SFD MATCHED============",UVM_HIGH)
         
      		end
      
      		else if((h_config_class.sfd_check_pass_flag == 0) && (h_config_class.sfd_check_fail_flag == 1)) begin
        
        		`uvm_info("IN THE SCOREBOARD","========FAIL======SFD MISMATCHED============",UVM_HIGH)
        
      		end
      
      																			// checking the crc flags to find the duv given crc is 
      																			//matched with the fixed preamble or not
      
      		if((h_config_class.crc_check_pass_flag == 1) && (h_config_class.crc_check_fail_flag == 0)) begin
        
        		`uvm_info("IN THE SCOREBOARD","=======PASS=======CRC MATCHED============",UVM_HIGH)
        
      		end
      
      		else if((h_config_class.crc_check_pass_flag == 0) && (h_config_class.crc_check_fail_flag == 1)) begin
        
        		`uvm_info("IN THE SCOREBOARD","========FAIL======CRC MISMATCHED============",UVM_HIGH)
        
      		end
      
      
      		resetting_the_flags();												// calling the resetting task after complition of the comparision
      
    	end
           
  	endtask
  	
////////////////////////////////////////////////////////////////////////////////
// TASK TO RESET ALL THE FLAGS
////////////////////////////////////////////////////////////////////////////////
  
  	task resetting_the_flags;
    
    	h_config_class.preamble_check_pass_flag = 0;
  	 	h_config_class.preamble_check_fail_flag = 0;
 
  	 	h_config_class.sfd_check_pass_flag = 0;
  	 	h_config_class.sfd_check_fail_flag = 0;
  
  	 	h_config_class.crc_check_pass_flag = 0;
  	 	h_config_class.crc_check_fail_flag = 0;
  
  	 	h_config_class.drop_check_fail = 0;
  	 	h_config_class.drop_check_pass = 0;
    
    	h_config_class.preamble_sfd_crc_check_pass = 0;
    	h_config_class.preamble_sfd_crc_check_fail = 0;
    	
    	h_config_class.register_configuration_completed = 0;
    	
    	h_config_class.drop_conditions = 0;
      	
      	h_config_class.trigger  = 0;
      	
      	h_config_class.checking = 0;
    	
    
  	endtask
  
////////////////////////////////////////////////////////////////////////////////
// TASK TO RETRIVE THE DESTINATION ADDRESS FROM THE INPUT AND OUTPUT QUEUES
////////////////////////////////////////////////////////////////////////////////
  
	task da_retreive;
  
  	bit[7:0]temp_v_byte,temp_d_byte;
  
  
  		repeat(6) begin
      
      		temp_v_byte = req1.tx_input_queue.pop_back();
      
      		verification_da_queue.push_front(temp_v_byte);
      
      		temp_d_byte = req2.tx_mac_output_queue.pop_back();
      
      		design_da_queue.push_front(temp_d_byte);
      
      	end
  
  
  	endtask
  	
////////////////////////////////////////////////////////////////////////////////
// TASK TO RETRIVE THE SOURCE ADDRESS FROM THE INPUT AND OUTPUT QUEUES
////////////////////////////////////////////////////////////////////////////////
   
	task sa_retreive;
  
  	bit[7:0]temp_v_byte,temp_d_byte;
  
  
  		repeat(6) begin
      
      		temp_v_byte = req1.tx_input_queue.pop_back();
      
      		verification_sa_queue.push_front(temp_v_byte);
      
      		temp_d_byte = req2.tx_mac_output_queue.pop_back();
      
      		design_sa_queue.push_front(temp_d_byte);
      
      	end
  
  
  	endtask
  	
////////////////////////////////////////////////////////////////////////////////
// TASK TO RETRIVE THE LENGTH OR TYPE	 FROM THE INPUT AND OUTPUT QUEUES
////////////////////////////////////////////////////////////////////////////////
   
	task l_t_retreive;
  
  	bit[7:0]temp_v_byte,temp_d_byte;
  
  
  		repeat(2) begin
      
      		temp_v_byte = req1.tx_input_queue.pop_back();
      
      		verification_l_t_queue.push_front(temp_v_byte);
      
      		temp_d_byte = req2.tx_mac_output_queue.pop_back();
      
      		design_l_t_queue.push_front(temp_d_byte);
      
      	end
  
  
  	endtask
  	
  	
////////////////////////////////////////////////////////////////////////////////
// TASK TO RETRIVE THE PAYLOAD FROM THE INPUT AND OUTPUT QUEUES
////////////////////////////////////////////////////////////////////////////////
   
	task payload_retreive;
  
  	bit[7:0]temp_v_byte,temp_d_byte;
  	
  	bit[7:0] temp_verify_queue[$];

  	bit[7:0] temp_design_queue[$];
  	
  	temp_verify_queue = req1.tx_input_queue;
  	
  	temp_design_queue = req2.tx_mac_output_queue;
  
  
  		while((temp_design_queue.size()) != 0) begin
      
      		temp_v_byte = temp_verify_queue.pop_back();
      
      		verification_payload_queue.push_front(temp_v_byte);
      
      		temp_d_byte = temp_design_queue.pop_back();
      
      		design_payload_queue.push_front(temp_d_byte);
      
      	end
  
  
  	endtask
  	
////////////////////////////////////////////////////////////////////////////////
// TASK TO CALL DATA RETRIVEING TASKS 
////////////////////////////////////////////////////////////////////////////////
    	
  	task main_retreive;
  	
  		da_retreive();
  	
  		sa_retreive();
  		
  		l_t_retreive();
  		
  		payload_retreive();
  		
  		
  	endtask  	
 	  
endclass