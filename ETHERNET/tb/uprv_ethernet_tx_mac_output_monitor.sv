// ==================== OUTPUT MONITOR ====================

class tx_mac_output_monitor extends uvm_monitor;

	`uvm_component_utils(tx_mac_output_monitor)									// ================ FACTORY REGISTRATION ==================

	sequence_item req;															// ========== HANDLES DECLARATION ===========

	virtual inf h_vinf;	
														
	config_class h_config_class;

  	uvm_analysis_port#(sequence_item) h_tx_mac_output_monitor_port;

  	bit [3:0]fixed_preamble_1[$:13] = {10,10,10,10,10,10,10,10,10,10,10,10,10,10};
  
  	bit [3:0]fixed_preamble_2[$:13] = {5,5,5,5,5,5,5,5,5,5,5,5,5,5};
  
  	bit [3:0]fixed_sfd[$:1] = {13,5};
  
  	bit [31:0]fixed_crc= 'hC704DD7B;    										// need to fixed the crc with given magic number
  
  	bit [3:0]nibble_queue[$];
  
  	bit[7:0] byte_queue[$];
  
  	bit trigger_flag;
  	
  	bit [3:0] data;
  	
	bit [31:0] crc_variable = 32'hffff_ffff; 									// initializing the variable
	
	bit [31:0] crc_next;
	 
	bit [31:0] calculated_magic_number;
	
	int nibble_size;
	
	bit [3:0] nibble_crc[$];
	
	function new(string name = "tx_mac_outputmonitor",uvm_component parent);	// =================== COMPONENT CONSTRUCTION ===================

		super.new(name,parent);

	endfunction

	function void build_phase(uvm_phase phase);									// =============== BUILD PHASE =================

		super.build_phase(phase);

		req = sequence_item :: type_id :: create ("req");
      
        h_tx_mac_output_monitor_port = new("h_tx_mac_output_monitor_port",this);

		assert(uvm_config_db #(virtual inf) :: get(this,"","Interface",h_vinf));

      	assert(uvm_config_db #(config_class)::get(this,"","config_class",h_config_class));
		
		`uvm_info("IN THE TX MAC OUTPUT MONITOR CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);

	endfunction
	
	task run_phase(uvm_phase phase);

		super.run_phase(phase);

		forever @(h_vinf.cb_tx_mac_monitor)begin
          
          	new_nibble_task();
            
            check_task();
            
            drop_condition_task();
            			
		end
		
		`uvm_info("IN THE TX MAC OUTPUT MONITOR CLASS","RUN PHASE IS COMPLETED",UVM_DEBUG);

	endtask
  
//------------------------------------------------------------------------------
// TASK TO LOAD THE NIBBLE DATA INTO THE NIBBLE QUEUE WHICH IS GIVEN 
//BY DUV AND TO TRIGGER THE CHECKING TASK
//------------------------------------------------------------------------------

 	task new_nibble_task;
 
 		bit[31:0] pop_var,temp_pointer;
      
     	bit [15:0] lenght_value;
      
      	bit[31:0] temp_var;

      	if(h_vinf.MTxEn == 1) begin												// if the first enable is seen then the the nibble loading starts 
      																			//and this loading is repeated for the temp_var times
        
        	pop_var = h_config_class.bd_length_type_queue_mac.pop_back();       
        
        	temp_pointer = h_config_class.bd_length_type_queue_mac.pop_back();
        
        	lenght_value = pop_var[31:16];
        
        	temp_var =(52+(lenght_value*2));
        
        	repeat(temp_var) begin
         
          		nibble_queue.push_front(h_vinf.MTxD);
          		
          		nibble_crc.push_front(h_vinf.MTxD);
          
          		@(h_vinf.cb_tx_mac_monitor) 
          
          		$display("");
          
        	end
        
        	$display($time,"THE NIBBLE QUEUE FORMED BY THE DATA GIVEN BY DUV \n nibble_queue = %p",nibble_queue);
        
        	trigger_flag = 1;
        	 
      	end
      
 endtask
  
//------------------------------------------------------------------------------
// TASK TO CHECK PREAMBLE WHICH IS GIVEN BY DUV
//------------------------------------------------------------------------------

  	task preamble_check;
    
    	bit [3:0] temp_preamble_queue [$:13];
    
    	bit[3:0]temp_var;
    
    	repeat(14) begin														// popping the preamble data from the nibble queue to a temp_preamble_queue 
    																			//to compare with the fixed preamble queue
          
         	temp_var = nibble_queue.pop_back();
      
         	temp_preamble_queue.push_front(temp_var);
      
   		end
   	
   		$display($time,"THE PREAMBLE QUEUES ONE FROM DUV AND ONE IS FIXED IN THE OUTPUT MONITOR :: \n temp_preamble_queue = %p; \n fixed_preamble_1    = %p;",temp_preamble_queue,fixed_preamble_1);
    
    	if((temp_preamble_queue == fixed_preamble_1) || (temp_preamble_queue == fixed_preamble_2) ) begin
      
      		h_config_class.preamble_check_pass_flag = 1;
      
      		h_config_class.preamble_check_fail_flag = 0;
      
    	end
    
    	else begin
      
      		h_config_class.preamble_check_fail_flag = 1;
      
      		h_config_class.preamble_check_pass_flag = 0;
      
    	end
 
  	endtask
  
//------------------------------------------------------------------------------
// TASK TO CHECK SFD WHICH IS GIVEN BY DUV
//------------------------------------------------------------------------------

  	task sfd_check;
    
    	bit [3:0] temp_sfd_queue [$:1];
    
    	bit[3:0]temp_var;
    
    	repeat(2) begin															// popping the sfd data from the nibble queue to a temp_sfd_queue 
    																			//to compare with the fixed sfd queue
          
          
         	temp_var = nibble_queue.pop_back();
      
         	temp_sfd_queue.push_front(temp_var);
      
   		end
   	
   		$display($time,"THE SFD QUEUES ONE FROM DUV AND ONE IS FIXED IN THE OUTPUT MONITOR :: \n temp_sfd_queue = %p; \n fixed_sfd      = %p;",temp_sfd_queue,fixed_sfd);
    
    	if((temp_sfd_queue == fixed_sfd) ) begin
            
      		h_config_class.sfd_check_pass_flag = 1;
      
      		h_config_class.sfd_check_fail_flag = 0;
            
    	end
    
    	else begin
      
      		h_config_class.sfd_check_fail_flag = 1;
      
      		h_config_class.sfd_check_pass_flag = 0;
      
    	end
    
    
    
  endtask
  
//------------------------------------------------------------------------------
// TASK TO CHECK CRC WHICH IS GIVEN BY DUV
//------------------------------------------------------------------------------

  	task crc_check;
    
    	bit [3:0] temp_crc_queue [$:7];
    
    	bit[3:0]temp_var;
    
    	repeat(8) begin															// popping the crc data from the nibble queue to a temp_sfd_queue 
    																			//to compare with the fixed sfd queue
          
          
         	temp_var = nibble_queue.pop_front();
      
         	temp_crc_queue.push_front(temp_var);
      
   		end
   	
   		
   		
   		magic_check();
   		
   		$display($time,"THE CRC QUEUES ONE FROM DUV AND ONE IS FIXED IN THE OUTPUT MONITOR :: \n calculated_magic_number = %p; \n fixed_crc      = %p;",calculated_magic_number,fixed_crc);
    
    	if((calculated_magic_number == fixed_crc) ) begin
      
      		h_config_class.crc_check_pass_flag = 1;
      
      		h_config_class.crc_check_fail_flag = 0;
      
    	end
    
    	else begin
      
      		h_config_class.crc_check_fail_flag = 1;
      
      		h_config_class.crc_check_pass_flag = 0;
      
    	end 
    
  	endtask
//------------------------------------------------------------------------------
// TASK TO CONVERT THE FRAME NIBBLE QUEUE TO THE FRAME BYTE QUEUE
//------------------------------------------------------------------------------
 
  	task byte_queue_preparation;
    
    	bit[3:0] a,b;
    	
    	bit[7:0] c;   
    	
    	$display($time,"THE NIBBLE QUEUE WHICH CONTAINS THE FRAME DATA ONLY INTHE OUTPUT MONITOR \n nibble_queue = %p",nibble_queue); 
    
    	while(nibble_queue.size() != 0) begin									// until the queue empty the data is popped out the data 
    																			//and pushed into the byte queue									
      
      		a = nibble_queue.pop_back();
      
      		b = nibble_queue.pop_back();
      
      		c = {b,a};
      
      		byte_queue.push_front(c);
     
    	end
    	
    	$display($time,"THE BYTE QUEUE WHICH CONTAINS THE FRAME DATA ONLY INTHE OUTPUT MONITOR \n byte_queue   = %p",byte_queue);
    
    	req.tx_mac_output_queue = byte_queue;
    
    	h_tx_mac_output_monitor_port.write(req);
    
    	h_config_class.scoreboard_compare_trigger_flag_from_output = 1;         // indicates that the byte queue writing from output monitor 
    																			//to scoreboard is completed
    
    	byte_queue.delete();
 
  	endtask
  
//------------------------------------------------------------------------------
// TASK TO CALL THE PREAMBLE ,SFD,CRC CHECK AND THE BYTE QUEUE PREPARATION TASK
//------------------------------------------------------------------------------
 
  	task  check_task;
    
    	if(trigger_flag == 1) begin 											// after the total nibble queue preparation then only 
    																			//checking tasks are going to active
          	
    		preamble_check();
    
    		sfd_check();
    
    		crc_check();
    
      		if((h_config_class.preamble_check_pass_flag == 1) &&(h_config_class.preamble_check_fail_flag == 0)&&
         		(h_config_class.sfd_check_pass_flag == 1)&&(h_config_class.sfd_check_fail_flag==0)&&
         		(h_config_class.crc_check_pass_flag == 1)&&(h_config_class.crc_check_fail_flag == 0)) begin
      
      			h_config_class.preamble_sfd_crc_check_pass = 1;
      
      			h_config_class.preamble_sfd_crc_check_fail = 0;
 
    		end
    
    		else begin
      
      			h_config_class.preamble_sfd_crc_check_pass = 0;
      
      			h_config_class.preamble_sfd_crc_check_fail = 1;
 
    		end
    
    		byte_queue_preparation();
    		
    		trigger_flag = 0;
    
    	end
	
  	endtask
  
//------------------------------------------------------------------------------
// TASK TO CHECK THE DROP CASES OF THE FRAME
//------------------------------------------------------------------------------
  
  	task drop_condition_task;
  	
  		bit[31:0] pop_var,temp_pointer;
    
    	if(h_config_class.drop_conditions == 1) begin							// if the drop condition flag which is raised by the input monitor 
    																			//based on the input stimulus then checking the output side will trigger 
      		
      			if(h_vinf.MTxEn == 1) begin
        
        			h_config_class.drop_check_fail = 1;
        
        			h_config_class.drop_check_pass = 0;
        			      
      			end
      
      			else begin
        
        			h_config_class.drop_check_pass = 1;
        
        			h_config_class.drop_check_fail = 0;
        			
        			pop_var = h_config_class.bd_length_type_queue_mac.pop_back();       
        
        			temp_pointer = h_config_class.bd_length_type_queue_mac.pop_back();
        
        			h_config_class.scoreboard_compare_trigger_flag_from_output = 1;
        			
      			end
            
    	end
    
  	endtask
  
//------------------------------------------------------------------------------
// TAK TO CALUCULATE MAGIC NUMBER FROM THE FRAME GIVEN BY THE DUV
//------------------------------------------------------------------------------



task magic_check();
		
		
		nibble_size = nibble_crc.size;
	
			for(int i=0;i<nibble_size;i++) 
			begin
			data = nibble_crc.pop_front;
			data = {<<{data}}; 

			crc_next[0] =    (data[0] ^ crc_variable[28]); 
			crc_next[1] =    (data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29]); 
			crc_next[2] =    (data[2] ^ data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29] ^ crc_variable[30]); 
			crc_next[3] =    (data[3] ^ data[2] ^ data[1] ^ crc_variable[29] ^ crc_variable[30] ^ crc_variable[31]); 
			crc_next[4] =    (data[3] ^ data[2] ^ data[0] ^ crc_variable[28] ^ crc_variable[30] ^ crc_variable[31]) ^ crc_variable[0]; 
			crc_next[5] =    (data[3] ^ data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29] ^ crc_variable[31]) ^ crc_variable[1]; 
			crc_next[6] =    (data[2] ^ data[1] ^ crc_variable[29] ^ crc_variable[30]) ^ crc_variable[2]; 
			crc_next[7] =    (data[3] ^ data[2] ^ data[0] ^ crc_variable[28] ^ crc_variable[30] ^ crc_variable[31]) ^ crc_variable[3]; 
			crc_next[8] =    (data[3] ^ data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29] ^ crc_variable[31]) ^ crc_variable[4]; 
			crc_next[9] =    (data[2] ^ data[1] ^ crc_variable[29] ^ crc_variable[30]) ^ crc_variable[5]; 
			crc_next[10] =    (data[3] ^ data[2] ^ data[0] ^ crc_variable[28] ^ crc_variable[30] ^ crc_variable[31]) ^ crc_variable[6]; 
			crc_next[11] =    (data[3] ^ data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29] ^ crc_variable[31]) ^ crc_variable[7]; 
			crc_next[12] =    (data[2] ^ data[1] ^ data[0] ^ crc_variable[28] ^ crc_variable[29] ^ crc_variable[30]) ^ crc_variable[8]; 
			crc_next[13] =    (data[3] ^ data[2] ^ data[1] ^ crc_variable[29] ^ crc_variable[30] ^ crc_variable[31]) ^ crc_variable[9]; 
			crc_next[14] =    (data[3] ^ data[2] ^ crc_variable[30] ^ crc_variable[31]) ^ crc_variable[10]; 
			crc_next[15] =    (data[3] ^ crc_variable[31]) ^ crc_variable[11]; 
			crc_next[16] =    (data[0] ^ crc_variable[28]) ^ crc_variable[12]; 
			crc_next[17] =    (data[1] ^ crc_variable[29]) ^ crc_variable[13]; 
			crc_next[18] =    (data[2] ^ crc_variable[30]) ^ crc_variable[14]; 
			crc_next[19] =    (data[3] ^ crc_variable[31]) ^ crc_variable[15]; 
			crc_next[20] = 	  crc_variable[16]; 
			crc_next[21] =    crc_variable[17]; 
			crc_next[22] =    (data[0] ^ crc_variable[28]) ^ crc_variable[18]; 
			crc_next[23] =    (data[1] ^ data[0] ^ crc_variable[29] ^ crc_variable[28]) ^ crc_variable[19]; 
			crc_next[24] =    (data[2] ^ data[1] ^ crc_variable[30] ^ crc_variable[29]) ^ crc_variable[20]; 
			crc_next[25] =    (data[3] ^ data[2] ^ crc_variable[31] ^ crc_variable[30]) ^ crc_variable[21]; 
			crc_next[26] =    (data[3] ^ data[0] ^ crc_variable[31] ^ crc_variable[28]) ^ crc_variable[22]; 
			crc_next[27] =    (data[1] ^ crc_variable[29]) ^ crc_variable[23]; 
			crc_next[28] =    (data[2] ^ crc_variable[30]) ^ crc_variable[24]; 
			crc_next[29] =    (data[3] ^ crc_variable[31]) ^ crc_variable[25]; 
			crc_next[30] =    crc_variable[26]; 
			crc_next[31] =    crc_variable[27]; 

			crc_variable = crc_next;

			end
		
		calculated_magic_number = crc_variable;
		
	endtask
	
	
	// Ethernet CRC logic //
	//After calling this task, compare the calculated_magic_number with actual_magic_number
	
  
endclass