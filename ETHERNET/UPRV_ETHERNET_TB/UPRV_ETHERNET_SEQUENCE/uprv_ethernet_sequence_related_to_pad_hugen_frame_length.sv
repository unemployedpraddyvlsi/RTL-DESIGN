// =================== SEQUENCE CLASS (OBJECT) =========================

class sequence_related_to_pad_hugen_frame_length extends uvm_sequence#(sequence_item);

	`uvm_object_utils(sequence_related_to_pad_hugen_frame_length)														//=========== 																									FACTORY REGISTRATION ===========
	config_class h_config_class;
	
	int i = 1024;
	
	virtual inf h_vinf;


	function new(string name = "sequence_related_to_mcrs_txen_rd_txbdnum");											// ============== OBJECT CONSTRUCTION =============

			super.new(name);

	endfunction

	task body();																//============ RANDOMIZING THE STIMULUS ==========

		req = sequence_item :: type_id :: create("req");
		
		assert(uvm_config_db #(config_class)::get(null,"","config_class",h_config_class));
		
		assert(uvm_config_db #(virtual inf) :: get(null,this.get_full_name,"Interface",h_vinf));
			
		begin

			reset();
			
			//total_configuration('hc,0,'h0000ABCD,1,15,0,'h0034c000,'h00002002);		//CORRECT_FRAME_LENGTH_TEST

			//total_configuration('hc,0,'h0000ABCD,1,15,0,'h000Ac000,'h00002002);		//FRAME_LENGTH_LESS_THAN_MIN_FRAME_LENGTH_PAD=0 _TEST

			//total_configuration('hc,0,'h0000ABCD,1,15,0,'h0028c000,49154);		//FRAME_LENGTH_LESS_THAN_MIN_FRAME_LENGTH_PAD=1 _TEST

			//total_configuration('hc,0,'h0000ABCD,1,15,0,'h05F0C000,32770);		//FRAME_LENGTH_GREATER_THAN_MAX_FRAME_LENGTH_HUGEN

			//total_configuration('hc,0,'h0000ABCD,1,15,0,'h07D0C000,49154);		//FRAME_LENGTH_GREATER_THAN_MAX_FRAME_LENGTH_HUGEN=1 _TEST

			//total_configuration('hc,0,'h0000ABCD,1,15,0,'h07D0C000,32770);		//FRAME_LENGTH_GREATER_THAN_2KB_HUGEN=0 _TEST

			//total_configuration('hc,0,'h0000ABCD,1,15,0,'h07D0C000,49154);		//FRAME_LENGTH_GREATER_THAN_2KB_HUGEN=1 _TEST
	
		end

	endtask
//--------------------------------------------------------------------------------------------------------------------------------------------------------------
																				//{	TASK TO CONFIGURE THE MODER REGISTER
	task moder_configuration(input int p_write_data);										//pass the data you are configuring into the register as argument to the task
	
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 0;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 0;  psel_i ==1; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 0;  psel_i ==1; penable_i ==1; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 0;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
	
	endtask
																				//}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------
																				//{ TASK TO CONFIGURE THE INT_MASK REGISTER
	task int_mask_configuration(input int p_write_data);									//pass the data you are configuring into the register as argument to the task
	
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 8;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 8;  psel_i ==1; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 8;  psel_i ==1; penable_i ==1; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 8;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
	
	endtask
																				//}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------																		
																				//{ TASK TO CONFIGURE THE INT_SOURCE REGISTER
	task int_source_configurationn(input int p_write_data);								//pass the data you are configuring into the register as argument to the task
	
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 4;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 4;  psel_i ==1; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 4;  psel_i ==1; penable_i ==1; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		
		wait(h_vinf.pready_o == 1)
		
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 4;  psel_i ==0; penable_i ==0; pwrite_i == 0; pwdata_i == p_write_data; });//1024 idle read
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 4;  psel_i ==1; penable_i ==0; pwrite_i == 0; pwdata_i == p_write_data; });//1024 setup
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 4;  psel_i ==1; penable_i ==1; pwrite_i == 0; pwdata_i == p_write_data; });//1024 access
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 4;  psel_i ==0; penable_i ==0; pwrite_i == 0; pwdata_i == p_write_data; });
		finish_item(req);
		
	
	endtask
																				//}																				
//--------------------------------------------------------------------------------------------------------------------------------------------------------------	
																				//{	TASK TO CONFIGURE THE MIIADDRESS REGISTER
	task miiaddress_configuration(input int p_write_data);								//pass the data you are configuring into the register as argument to the task

		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 48;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 48;  psel_i ==1; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 48;  psel_i ==1; penable_i ==1; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 48;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
	
	endtask
																				//}																			//}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------	
																				//{	TASK TO CONFIGURE THE MAC_ADDR0 REGISTER
	task mac_addr0_configuration(input int p_write_data);									//pass the data you are configuring into the register as argument to the task
	
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 64;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 64;  psel_i ==1; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 64;  psel_i ==1; penable_i ==1; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 64;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
	
	endtask
																				//}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------	
																				//{	TASK TO CONFIGURE THE MAC_ADDR1 REGISTER
	task mac_addr1_configuration(input int p_write_data);									//pass the data you are configuring into the register as argument to the task
	
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 68;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 68;  psel_i ==1; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 68;  psel_i ==1; penable_i ==1; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 68;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
	
	endtask
																				//}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------	
																				//{	TASK TO CONFIGURE THE TX_BD_NUM REGISTER
	task tx_bd_num_configuration(input int p_write_data);									//pass the data you are configuring into the register as argument to the task
	
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 32;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 32;  psel_i ==1; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 32;  psel_i ==1; penable_i ==1; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == 32;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
		finish_item(req);
	
	endtask
																				//}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------	
																				//{	TASK TO CONFIGURE THE BD's
	task bd_configuration(input int address,p_write_data);						//pass the data you are configuring into the register as argument to the task
	
		bit [31:0]temp_var;
	
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });//1024 idle write
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address;  psel_i ==1; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });//1024  setup
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address;  psel_i ==1; penable_i ==1; pwrite_i == 1; pwdata_i == p_write_data; });//1024  access
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address;  psel_i ==0; penable_i ==0; pwrite_i == 0; pwdata_i == p_write_data; });//1024 idle read
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address;  psel_i ==1; penable_i ==0; pwrite_i == 0; pwdata_i == p_write_data; });//1024 setup
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address;  psel_i ==1; penable_i ==1; pwrite_i == 0; pwdata_i == p_write_data; });//1024 access
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });//1024 idle write
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });//1024 idle write
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address+4;  psel_i ==0; penable_i ==0; pwrite_i == 1; });//1028 idle write
		temp_var = req.pwdata_i;
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address+4;  psel_i ==1; penable_i ==0; pwrite_i == 1; pwdata_i == temp_var ;});//1028 setup
		
		
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address+4;  psel_i ==1; penable_i ==1; pwrite_i == 1;pwdata_i == temp_var ;});//1028 access
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address+4;  psel_i ==0; penable_i ==0; pwrite_i == 0; pwdata_i == temp_var;});//1028 idle read
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address+4;  psel_i ==1; penable_i ==0; pwrite_i == 0; pwdata_i == temp_var;});//1028 setup
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address+4;  psel_i ==1; penable_i ==1; pwrite_i == 0; pwdata_i == temp_var;});//1028 access
		finish_item(req);
		
		wait(h_vinf.pready_o == 1)
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address+4;  psel_i ==0; penable_i ==0; pwrite_i == 0; pwdata_i == temp_var;});// idle
		finish_item(req);
		
		start_item(req);
		assert(req.randomize() with {prstn_i == 1; paddr_i == address+4;  psel_i ==0; penable_i ==0; pwrite_i == 0; pwdata_i == temp_var;});// idle
		finish_item(req);
	
	endtask
																				//}
//--------------------------------------------------------------------------------------------------------------------------------------------------------------


																				//{ TASK TO CONFIGURE ALL 	
	task total_configuration(input int miiaddress_data,mac_addr0_data,mac_addr1_data,tx_bd_num_data,int_mask_data,int_source_data,bd_data,moder_data);
	
		miiaddress_configuration(miiaddress_data);
		
		mac_addr0_configuration(mac_addr0_data);
		
		mac_addr1_configuration(mac_addr1_data);
		
		tx_bd_num_configuration(tx_bd_num_data);
		
		int_mask_configuration(int_mask_data);
		
		int_source_configurationn(int_source_data);
		
	

		repeat(h_config_class.TX_BD_NUM) begin
					
			bd_configuration(i,bd_data);										// need to give the data which you need to load into the bd's length/type(32 bit) 
			
			i = i+8 ;
		
		end
		
	
		moder_configuration(moder_data);
	
	endtask
																				//}
																				
//--------------------------------------------------------------------------------------------------------------------------------------------------------------																				

		task reset;																//checking the reset 

			start_item(req);
          	assert(req.randomize()with{prstn_i==0;});
			finish_item(req);

		endtask	
		
		
		
		
//-------------------------------------------------------------------------------------------------------------------------------------------------------------		

endclass
