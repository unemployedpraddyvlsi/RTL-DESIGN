// =================== SEQUENCE CLASS (OBJECT) =========================

class sequence_related_to_apb_testcases extends uvm_sequence#(sequence_item);
		
	`uvm_object_utils(sequence_related_to_apb_testcases)														//=========== FACTORY REGISTRATION ===========
  
  	virtual inf h_vinf;

	function new(string name = "sequence_related_to_apb_testcases");										// ============== OBJECT CONSTRUCTION =============

		super.new(name);

	endfunction
			
	task body();
      
      assert(uvm_config_db #(virtual inf) :: get(null,this.get_full_name,"Interface",h_vinf));

			req = sequence_item :: type_id :: create("req");
					
			begin

				reset();

				every_register_write_read();
              
              	reset();

				every_register_read_write_read();
              
              	reset();

				every_bd_write_read();
              
              	reset();

				every_bd_read_write_read();
			
			end

		endtask

//*********************************************************************************************************************************************************************



//------------------------------------------------------------------------------------------------------------------------------------------------------------------

																				//{combination of arguments passing to randomize the signals

		task input_combination1(input reset,input[31:0]address,input write,select,enable);

			start_item(req);
			assert(req.randomize()with{prstn_i==reset; paddr_i==address;  psel_i==select; penable_i==enable; pwrite_i == write;});
			finish_item(req);

		
		endtask
																				//}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------			
	
																				//{write read operation to be performed

		task write_read(input [31:0] address);												// passing the address as an argument						

		  
          	input_combination1(1,address,1,0,0);                     			
	
	
          	input_combination1(1,address,1,1,0);								// write_operation stimulus
						
          	input_combination1(1,address,1,1,1);
          	
          	
          	wait(h_vinf.pready_o == 1)
          	
          	input_combination1(1,address,0,0,0);
		
					
          	input_combination1(1,address,0,1,0);								//read operation stimulus
							
          	input_combination1(1,address,0,1,1);
						
			wait(h_vinf.pready_o == 1)
          	
          	input_combination1(1,address,0,0,0);

		endtask
																				//}
//------------------------------------------------------------------------------------------------------------------------------------------------------------------

																				//{ read write read operation to be performed
		task read_write_read(input [31:0]address);											//passing the address as an argument

          input_combination1(1,address,0,0,0); 								
						

          input_combination1(1,address,0,1,0);								//read operation stimulus
					
          input_combination1(1,address,0,1,1);

			wait(h_vinf.pready_o == 1)
          
          
          input_combination1(1,address,0,0,0);
						
          input_combination1(1,address,1,1,0);								// write_operation stimulus
					
          input_combination1(1,address,1,1,1);
          
          wait(h_vinf.pready_o == 1)
          
			
          input_combination1(1,address,0,0,0);
				
          input_combination1(1,address,0,1,0);								//read operation stimulus
						
          input_combination1(1,address,0,1,1);
          
          wait(h_vinf.pready_o == 1)
					

          input_combination1(1,address,0,0,0);


		endtask
																				//}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------

																				//{write read operation to be performed for every register
		task every_register_write_read();

			write_read(0);														// moder register write read stimulus passing

			write_read(4);														// Int source register write read stimulus passing

			write_read(8);														// Int mask register write read stimulus passing

			write_read(32);														// TX_BD_NUM register write read stimulus passing

			write_read(48);														// MIIADDRESS register write read stimulus passing

			write_read(64);														// MAC_ADDR0 register write read stimulus passing

			write_read(68);														// MAC_ADDR1 register write read stimulus passing


		endtask

																				//}
//------------------------------------------------------------------------------------------------------------------------------------------------------------------

																				//{read write read operation to be performed for every register
		task every_register_read_write_read();


			read_write_read(0);													// moder register read write read stimulus passing

			read_write_read(4);													// Int source register read write read stimulus passing	

			read_write_read(8);													// Int mask register read write read stimulus passing

			read_write_read(32);												// TX_BD_NUM register read write read stimulus passing

			read_write_read(48);												// MIIADDRESS register read write read stimulus passing

			read_write_read(64);												// MAC_ADDR0 register read write read stimulus passing

			read_write_read(68);												// MAC_ADDR1 register read write read stimulus passing


		endtask
																				//}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------

																				//{write read operation to be performed
		task every_bd_write_read();

			for (int i =1024;i<=2047;i= i+4) begin

				write_read(i);

			end
                                                                                                                                   
		endtask
																				//}

//------------------------------------------------------------------------------------------------------------------------------------------------------------------

																				//{read write read operation to be performed
		task every_bd_read_write_read();

			for (int i =1024;i<=2047;i= i+4) begin

				read_write_read(i);

			end
                                                                                                                                   
		endtask
																				//}	

//------------------------------------------------------------------------------------------------------------------------------------------------------------------

		task reset;																//checking the reset 

			start_item(req);
          	assert(req.randomize()with{prstn_i==0;});
			finish_item(req);

		endtask

//------------------------------------------------------------------------------------------------------------------------------------------------------------------


endclass