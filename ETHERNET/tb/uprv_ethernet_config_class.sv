								

class config_class extends uvm_object;											// CONFIG CLASS (OBJECT) 
							
	`uvm_object_utils(config_class)												// FACTORY REGISTRATION 

																				// REGISTERS DECLARATION

	bit [31:0] MIIADDRESS;														//MIIADDRESS (DESTINATION ADDRESS)
	
	bit [31:0] MAC_ADDR1;														//MAC_ADDR1	(SOURCE ADDRESS LAST MSB 2 BYTES)
	
	bit [31:0] MAC_ADDR0;														//MAC_ADDR0	(SOURCE ADDRESS LEAST LSB 4 BYTES)
		
	bit [31:0] TX_BD_NUM;														//TX_BD_NUM
	
	bit [31:0] INT_MASK;														//INT_MASK
						
	bit [31:0] INT_SOURCE;														//INT_SOURCE
				
	bit [31:0] MODER;															// MODER 									
  
  
	
	bit preamble_sfd_crc_check_fail;

	bit preamble_sfd_crc_check_pass;
  
  
  	
  

  	bit[31:0] bd_length_type_queue[$:256];
  
  	bit[31:0] bd_length_type_queue_drop[$:256];
  
  	bit[31:0] bd_length_type_queue_mac[$:256];
  
  	bit[31:0] bd_length_type_queue_tx_mac_sequence[$:256];
  
  	bit[31:0] bd_length_type_queue_slave_sequence[$:256];
  
	
	bit[31:0] payload_data_queue[$];
	
	bit register_configuration_completed;
	
	bit drop_conditions;
  
  
  	bit  preamble_check_pass_flag;
  	bit  preamble_check_fail_flag;
  
  	bit  sfd_check_pass_flag;
  	bit  sfd_check_fail_flag;
  
  	bit  crc_check_pass_flag;
  	bit  crc_check_fail_flag;
  
  	bit drop_check_fail;
  	bit drop_check_pass;
  	
  	bit scoreboard_compare_trigger_flag_from_input;
  	bit scoreboard_compare_trigger_flag_from_output;
  	
  	bit flag;
  	
  	bit trigger;
  	
  	bit checking;
  
  						
	function new(string name = "config_class");									// OBJECT CONSTRUCTION 

		super.new(name);

	endfunction
	

endclass
