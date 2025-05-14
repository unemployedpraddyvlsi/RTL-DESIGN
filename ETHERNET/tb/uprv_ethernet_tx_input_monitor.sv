// ================ TX INPUTMONITOR CLASS (COMPONENT) =================

class tx_inputmonitor extends uvm_monitor;
																				// ================ FACTORY REGISTRATION ==================
	`uvm_component_utils(tx_inputmonitor)
																			    // ========== HANDLES DECLARATION ===========
	sequence_item req;

	virtual inf h_vinf;

	config_class h_config_class;
	
    bit[7:0] final_queue[$];
    
    bit input_trigger;													//final_queue(contains frame that is expected data)which is passed to scoreboard
	
	uvm_analysis_port #(sequence_item) h_tx_inputmonitor_port,h_tx_inputmonitor_port_for_coverage;					// ANALYSIS PORT DECLARATION 

																				// =================== COMPONENT CONSTRUCTION ===================
	function new(string name = "tx_inputmonitor",uvm_component parent);

		super.new(name,parent);
		
	endfunction
																				// =============== BUILD PHASE =================
	function void build_phase(uvm_phase phase);

		super.build_phase(phase);

		req = sequence_item :: type_id :: create ("req");

		assert(uvm_config_db #(virtual inf) :: get(this,"","Interface",h_vinf));				// GETTING INTERFACE SIGNALS

		assert(uvm_config_db #(config_class)::get(this,"","config_class",h_config_class));		// getting the information from config class
		
		h_tx_inputmonitor_port = new("h_tx_inputmonitor_port",this);							// analysis port memory creation
		
		h_tx_inputmonitor_port_for_coverage = new("h_tx_inputmonitor_port_for_coverage",this);
		
		`uvm_info("IN THE TX INPUTMONITOR CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);
						
	endfunction

	task run_phase(uvm_phase phase);											// =============== RUN PHASE ==================

		super.run_phase(phase);

		forever @(h_vinf.cb_monitor)begin
				
			req.prstn_i 	= 	h_vinf.cb_monitor.prstn_i ; 					// taking values from interface to monitor
	
			req.psel_i  	= 	h_vinf.cb_monitor.psel_i ;

			req.pwrite_i 	= 	h_vinf.cb_monitor.pwrite_i 	;

			req.paddr_i		= 	h_vinf.cb_monitor.paddr_i	;

			req.penable_i 	= 	h_vinf.cb_monitor.penable_i ;

			req.pwdata_i 	=	h_vinf.cb_monitor.pwdata_i	;
	
		 	req.m_pready_i	=	h_vinf.cb_monitor.m_pready_i ;

			req.m_prdata_i	= 	h_vinf.cb_monitor.m_prdata_i ;
			
			h_tx_inputmonitor_port_for_coverage.write(req);
			
			total_configuration();												// calling task which configures the registers and BD'S which are in the config class
			
			$display("***********************************************************************************************************************************");
			
			$display($time,"***THE REGISTERS ARE CONFIGURED IN TO THE CONFIG CLASS FROM THE INPUT MONITOR IS :: \n MIIADDRESS = %0d MAC_ADDR1 = %0d MAC_ADDR0 = %0d TX_BD_NUM = %0d INT_MASK = %0d INT_SOURCE = %0d MODER = %0d *** ",h_config_class.MIIADDRESS,h_config_class.MAC_ADDR1,h_config_class.MAC_ADDR0,h_config_class.TX_BD_NUM,h_config_class.INT_MASK,h_config_class.INT_SOURCE,h_config_class.MODER);

			//$display($time,"THE LENGTH_TYPE AND POINTER STORING IN TO THE QUEUES WHICH ARE IN THE CONFIG CLASS :: \n bd_length_type_queue = %p\n bd_length_type_queue_drop = %p\n bd_length_type_queue_mac = %p \n bd_length_type_queue_tx_mac_sequence = %p \n bd_length_type_queue_slave_sequence = %p",h_config_class.bd_length_type_queue,h_config_class.bd_length_type_queue_drop,h_config_class.bd_length_type_queue_mac,h_config_class.bd_length_type_queue_tx_mac_sequence,h_config_class.bd_length_type_queue_slave_sequence);
		
			//$display($time," THE MEMORY DATA LOADING IN TO A QUEUE WHICH IS IN THE CONFIG CLASS :: \n payload_queue = %p",h_config_class.payload_data_queue);

			$display("***********************************************************************************************************************************");
																				// the frame is generated on the updation of the flags in config class
			frame();
					
		end
      
      `uvm_info("IN THE TX INPUTMONITOR CLASS","RUN PHASE IS COMPLETED",UVM_DEBUG);
		
	endtask
	
	
//******************************************************************************
// TASK WHICH CONFIGURE THE REGISTERS IN THE CONFIG CLASS
//******************************************************************************

	task register_configuration;												// task is for register configuration 

		case (req.paddr_i)
																				// Based on given address the particular 
																				//data is stored in specified registers in config class 
																				
			0	:	h_config_class.MODER = req.pwdata_i;						// MODER

			4	:	h_config_class.INT_SOURCE = req.pwdata_i;					// INT_SOURCE

			8	:	h_config_class.INT_MASK = req.pwdata_i;						// INT_MASK

			32	:	h_config_class.TX_BD_NUM = req.pwdata_i;					// TX_BD_NUM 

			48	:	h_config_class.MIIADDRESS = req.pwdata_i;					//MIIADDRESS (DESTINATION ADDRESS)

			64	:	h_config_class.MAC_ADDR0 = req.pwdata_i;					//MAC_ADDR0	(SOURCE ADDRESS LEAST LSB 4 BYTES)
		
			68 	:	h_config_class.MAC_ADDR1 = req.pwdata_i;					//MAC_ADDR1	(SOURCE ADDRESS LAST MSB 2 BYTES)

		//default :	

		endcase

	endtask
	
//******************************************************************************
// TASK WHICH CONFIGURE THE BD'S  LENGTH_TYPE AND POINTER IN TO A QUEUE WHICH IS IN THE CONFIG CLASS
//******************************************************************************

	task bd_configuration;														// BD'S CONFIGURATION
		
		
		
		if(((1023 < h_vinf.paddr_i) && (h_vinf.paddr_i < 2047))&&(h_vinf.psel_i == 1)&&(h_vinf.penable_i == 1)&&(h_vinf.pready_o == 1))
		
		begin																	// starting from 1024 to 2047 limits
		
																				// when address is in the limits and in the access state the length _type  
																				//and pointer values of a bd is stored in to the queues 
																				//which are i the config class
			h_config_class.bd_length_type_queue.push_front(req.pwdata_i);
					
			h_config_class.bd_length_type_queue_drop.push_front(req.pwdata_i);
					
			h_config_class.bd_length_type_queue_mac.push_front(req.pwdata_i);
          
          	h_config_class.bd_length_type_queue_tx_mac_sequence.push_front(req.pwdata_i);
          
          	h_config_class.bd_length_type_queue_slave_sequence.push_front(req.pwdata_i);
          			
			
		end
      
      
	endtask
	
//******************************************************************************
// TASK WHICH CONFIGURE THE MEMORY DATA IN TO QUEUE WHICH IS  IN THE CONFIG CLASS
//******************************************************************************

	task payload_data_loading;													
																				// whenever the design apb master is in the access state 
																				//and if the m_ready_i is 1 then the memory data is 
																				//loding in to the queue which is in the config  class

	//	if((req.m_pready_i==1) && (req.m_psel_o == 1 ) && (req.m_penable_o == 1 ))	begin
		if((req.m_pready_i==1))	begin	
		
			h_config_class.payload_data_queue.push_front(req.m_prdata_i);
						
		end
		
	endtask
	
//******************************************************************************
// TASK WHICH CALLS THE REGISTERS,BD'S AND MEMORY(PAYLOAD)  DATA CONFIGURE TASKS
//******************************************************************************
	
	task total_configuration;	
	
		fork 																	// calling the call tasks of configuration purpose 
	
			register_configuration();
						
			bd_configuration();
				
			payload_data_loading();
		
		join
		
		//input_trigger =1;
	
	endtask
	
//******************************************************************************
// TASK WHICH STORES THE DESTINATION ADDRESS IN TO THE FINAL QUEUE 
//******************************************************************************
			
	task destination_address;													
																				// taking the destination address from config class and 
																				//storing it in to final queue which is used to store the frame 
																				//and passed to scoreboard
	
		final_queue.push_front(h_config_class.MIIADDRESS[7:0]);
		
		final_queue.push_front(h_config_class.MIIADDRESS[15:8]);
		
		final_queue.push_front(h_config_class.MIIADDRESS[23:16]);
		
		final_queue.push_front(h_config_class.MIIADDRESS[31:24]);
		
		final_queue.push_front(8'd0);
		
		final_queue.push_front(8'd0);	
		
		//$display("FINAL QUEUE PREPARED IN THE INPUT MONITOR WITH DESTINATION ADDRESS = %p",final_queue);	
	
	endtask
	
//******************************************************************************
// TASK WHICH STORES THE SOURCE ADDRESS IN TO THE FINAL QUEUE 
//******************************************************************************
	
	task source_address;														
																				// taking the source address from config class and 
																				//storing it in to final queue which is used to store the frame 
																				//and passed to scoreboard
		final_queue.push_front(h_config_class.MAC_ADDR1[15:8]);
		
		final_queue.push_front(h_config_class.MAC_ADDR1[7:0]);
	
		final_queue.push_front(h_config_class.MAC_ADDR0[31:24]);
	
		final_queue.push_front(h_config_class.MAC_ADDR0[23:16]);
	
		final_queue.push_front(h_config_class.MAC_ADDR0[15:8]);
	
		final_queue.push_front(h_config_class.MAC_ADDR0[7:0]);
		
		//$display("FINAL QUEUE PREPARED IN THE INPUT MONITOR WITH  SA,DA = %p",final_queue);
	
	endtask
	
//******************************************************************************
// TASK WHICH STORES THE LENGTHE OR TYPE  IN TO THE FINAL QUEUE 
//******************************************************************************

	task length_type_field;														
																				// taking the length or type from config class and 
																				//storing it in to final queue which is used to store the frame 
																				//and passed to scoreboard
	
		bit[31:0] temp_length,temp_pointer;
		
		temp_length = h_config_class.bd_length_type_queue.pop_back();
		
		temp_pointer = h_config_class.bd_length_type_queue.pop_back();
		
		
	
		final_queue.push_front(temp_length[23:16]);
		
		final_queue.push_front(temp_length[31:24]);
		
		//$display("FINAL QUEUE PREPARED IN THE INPUT MONITOR WITH  L/T,SA,DA = %p",final_queue);
		
	endtask
	
//******************************************************************************
// TASK WHICH STORES THE PAYLOAD  IN TO THE FINAL QUEUE 
//******************************************************************************

	task payload_data;															
																				// taking the payload from config class and 
																				//storing it in to final queue which is used to store the frame 
																				//and passed to scoreboard
	
		bit[31:0] temp_storage_int_value;
		
		while ((h_config_class.payload_data_queue.size()) != 0)	begin
			
				temp_storage_int_value = h_config_class.payload_data_queue.pop_back();	
			
				final_queue.push_front(temp_storage_int_value[7:0]);
			
				final_queue.push_front(temp_storage_int_value[15:8]);
			
				final_queue.push_front(temp_storage_int_value[23:16]);
			
				final_queue.push_front(temp_storage_int_value[31:24]);
										
		end
		
		$display("FINAL QUEUE PREPARED IN THE INPUT MONITOR WITH  \n PAYLOAD,L/T,SA,DA = %p",final_queue);
							
	endtask
	
//******************************************************************************
// TASK WHICH CALLS THE DATA LOADING TASKS IN TO THE FINAL QUEUE 
//******************************************************************************

	task final_call;															// calling tasks for forming a frame 
	
		begin
			
			destination_address();
			
			source_address();
			
			length_type_field();
				
			payload_data();
                    				
			req.tx_input_queue = final_queue;
          
          	h_tx_inputmonitor_port.write(req);
          	
          	h_config_class.scoreboard_compare_trigger_flag_from_input = 1;      // indicates that the queue writing is compeletd 
          																		//in the input monitor to scoreboard
            
            final_queue.delete();
	
		end
		
	endtask
	
	//-----------------------------------------------------------------------------------------------------------------------------------------------------
	
	task frame;
	
		bit[31:0] temp_length_drop,temp_pointer;
		
		bit[15:0] temp;
		
		if(h_config_class.register_configuration_completed == 1 && h_config_class.flag == 0)  begin
		
			temp_length_drop = h_config_class.bd_length_type_queue_drop.pop_back();
		
			temp_pointer = h_config_class.bd_length_type_queue_drop.pop_back();
		
			temp = temp_length_drop[31:16];						
			
			h_config_class.trigger = 1;											// indicates that drop frame check condition is started
		
			if(((temp < 46 ) && (h_config_class.MODER[15]==0)) || ((temp > 1500) && (h_config_class.MODER[14]==0)) ||
		((temp > 2048 ) && (h_config_class.MODER[14]==1) ) ) begin
		
				h_config_class.drop_conditions = 1;								//indicates that the present frame is a drop frame 
			
        		final_call();
        
        	end
        	
        	else  begin
        
        		h_config_class.drop_conditions = 0;								// indicates that the present frame is a good frame
        		
        		h_config_class.flag = 1;
        
      			if(h_config_class.checking == 1)begin
      			
        			final_call();
        			
        		end
        		
        	end
        
      	end
			
		
	endtask
	
	//-----------------------------------------------------------------------------------------------------------------------------------------------------

endclass