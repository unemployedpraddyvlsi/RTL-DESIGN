// ========================================  SEQUENCE_ITEM CLASS (OBJECT) ==================================================

class sequence_item extends uvm_sequence_item ;									// extending from the base class from backend

	`uvm_object_utils(sequence_item)											//=========== FACTORY REGISTRATION ===========


																				// signals which are input to the design in the apb[host] side
	rand bit prstn_i;															
	rand bit psel_i;
	rand bit penable_i;
	rand bit pwrite_i;
	rand bit [31:0]paddr_i;
	rand bit [31:0]pwdata_i;

	rand bit m_pready_i;														
	rand bit [31:0]m_prdata_i;
	
																				// signal which are output to the design in the apb[host] side

	bit pready_o;																
	bit [31:0]prdata_o;

	bit m_psel_o;																
	bit m_penable_o;
	bit m_pwrite_o;
	bit [31:0]m_paddr_o;
	bit [31:0]m_pwdata_o;
	
	bit int_o;	
																	
																				// signals which are input to the design in the mac side
	rand bit MCrS;
		
																				// signal which are output to the design in the mac side
	bit MTxEn;																	
	bit MTxErr;
	bit [3:0]MTxD;
	
	
	
  	bit[7:0] tx_input_queue[$];													// this queue is taken for driving the final queue in inputmonitor to scoreboard
  
  	bit [7:0]tx_mac_output_queue[$];											// this queue is taken for driving the final queue in outputmonitor to scoreboard
  	
  	

	static bit [31:0] previous_write_data;

	static bit [31:0] previous_address;
																				//================= OBJECT CONSTRUCTION ===================
	function new (string name = "sequence_item");

		super.new(name);

	endfunction

/*	
	constraint registers_bd_address {
										soft paddr_i inside {'h00,'h04,'h08,'h20,'h30,'h40,'h44,['h400:'h7ff]};}
										
	constraint address_register_loading {
												(paddr_i == 'h30) -> pwdata_i == 'h0000000A;				// MII ADDRESS DATA LOADING
												(paddr_i == 'h40) -> pwdata_i == 'h00000000;				// MAC ADDRESS0 DATA LOADING
												(paddr_i == 'h44) -> pwdata_i == 'h0000ABCD;				// MAC ADDRESS1 DATA LOADING
												
										} 
										
	constraint tx_bd_number_loading{ 	(paddr_i == 'h20) -> soft pwdata_i inside {['h00000000:'h000000FF]};}
	
	constraint int_mask_data_loading{ 	(paddr_i == 'h08) -> soft pwdata_i inside {['h00000000:'h00000003]};}
	
	constraint int_source_data_loading{ (paddr_i == 'h04) -> soft pwdata_i inside {['h00000000:'h00000003]};}
	
	constraint mode_data_loading{ 		(paddr_i == 'h00) -> soft pwdata_i inside {['h00002000:'h00002007],
																					['h00006000:'h00006007],
																					['h0000A000:'h0000A007],
																					['h0000E000:'h0000E007]};}
	
*/	
	function  void post_randomize;
	
	
		if(pwrite_i == 0) begin


			if((psel_i == 1)&& (penable_i == 0)) begin

				//previous_address = paddr_i;

				previous_write_data = pwdata_i;

			end

         	if((psel_i == 1)&&(penable_i == 1)) begin
            
            	pwdata_i = previous_write_data;
            
            	//paddr_i = previous_address;
            
          	end
          
         end


	endfunction
	
	

endclass