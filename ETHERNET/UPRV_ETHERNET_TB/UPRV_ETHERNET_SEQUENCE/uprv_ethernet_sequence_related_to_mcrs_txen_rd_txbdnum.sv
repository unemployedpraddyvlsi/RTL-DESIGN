// =================== SEQUENCE CLASS (OBJECT) =========================

class sequence_related_to_mcrs_txen_rd_txbdnum extends uvm_sequence#(sequence_item);

	`uvm_object_utils(sequence_related_to_mcrs_txen_rd_txbdnum)														//=========== FACTORY REGISTRATION ===========
	
	config_class h_config_class;
	
	int i = 1024;
	
	virtual inf h_vinf;

	function new(string name = "sequence_related_to_mcrs_txen_rd_txbdnum");											// ============== OBJECT CONSTRUCTION =============

			super.new(name);

	endfunction

	task body();
																	//============ RANDOMIZING THE STIMULUS ==========

		req = sequence_item :: type_id :: create("req");
		
		assert(uvm_config_db #(virtual inf) :: get(null,this.get_full_name,"Interface",h_vinf));
		
		assert(uvm_config_db #(config_class)::get(null,"","config_class",h_config_class));
			
		begin
		
		
			reset();
																				//============{tx_bd_num=0}

			//total_configuration('hC,0,'h0000ABCD,0,15,'h000f,'h0034c000,'h00002002);		//TX_BD_NUM_EQUL_TO_0_TXEN_TEST_1

			//total_configuration('hC,0,'h0000ABCD,0,15,0,'h0034c000,'h00002003);		//TX_BD_NUM_EQUL_TO_0_TXEN_TEST_2

																				
																				//==========={tx_bd_num=1}

			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h00344000,'h00002000);		//MCrS_TXEN_RD_TEST_1	*************in to loop*************

			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h0034c000,'h00002000);		//MCrS_TXEN_RD_TEST_2	*************in to loop*************
			
			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h00344000,'h00002002);		//MCrS_TXEN_RD_TEST_3	*************in to loop*************

			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h00344000,'h00002003);		//MCrS_TXEN_RD_TEST_4*/ *************in to loop*************

		
			
			
			total_configuration('hC,0,'h0000ABCD,10,15,'h000f,'h0041c000,'h00002002);		//MCrS_TXEN_RD_TEST_5//43040768
		
			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h0050c000,'h00002003);		//MCrS_TXEN_RD_TEST_6
		
			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h00344000,'h00002000);		//MCrS_TXEN_RD_TEST_7		*************in to loop*************
	
			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h0034c000,'h00002000);		//MCrS_TXEN_RD_TEST_8			*************in to loop*************	

			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h00344000,'h00002002);		//MCrS_TXEN_RD_TEST_9		*************in to loop*************

			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h00344000,'h00002003);		//MCrS_TXEN_RD_TEST_10

			//total_configuration('hC,0,'h0000ABCD,2,15,0,'h0034c000,'h00002002);		//MCrS_TXEN_RD_TEST_11

			//total_configuration('hC,0,'h0000ABCD,2,15,0,'h0034c000,'h00002003);		//MCrS_TXEN_RD_TEST_12

			
																				//=========={tx_bd_num>1}

			//total_configuration('hC,0,'h0000ABCD,2,15,0,'h0034c000,'h00002000);	//MCrS_TXEN_RD_TEST_13	*************in to loop*************

			//total_configuration('hC,0,'h0000ABCD,2,15,0,'h0034c000,'h00002000);	//MCrS_TXEN_RD_TEST_14	*************in to loop*************

			//total_configuration('hC,0,'h0000ABCD,2,15,0,'h00344000,'h00002002);	//MCrS_TXEN_RD_TEST_15	*************in to loop*************

			//total_configuration('hC,0,'h0000ABCD,2,15,0,'h00344000,'h00002003);	//MCrS_TXEN_RD_TEST_16	*************in to loop*************

			//total_configuration('hC,0,'h0000ABCD,2,15,0,'h00344000,'h00002002);	//MCrS_TXEN_RD_TEST_17	*************in to loop*************

			//total_configuration('hC,0,'h0000ABCD,2,15,0,'h00344000,'h00002003);	//MCrS_TXEN_RD_TEST_18*/	*************in to loop*************

				
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
		assert(req.randomize() with {prstn_i == 1; paddr_i == 4;  psel_i ==0; penable_i ==0; pwrite_i == 1; pwdata_i == p_write_data; });
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
