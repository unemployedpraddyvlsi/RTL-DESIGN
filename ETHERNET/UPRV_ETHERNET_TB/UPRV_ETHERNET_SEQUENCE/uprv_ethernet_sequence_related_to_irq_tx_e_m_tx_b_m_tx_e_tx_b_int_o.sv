// =================== SEQUENCE CLASS (OBJECT) =========================

class sequence_related_to_irq_tx_e_m_tx_b_m_tx_e_tx_b_int_o extends uvm_sequence#(sequence_item);

	`uvm_object_utils(sequence_related_to_irq_tx_e_m_tx_b_m_tx_e_tx_b_int_o)														//=========== 																			FACTORY REGISTRATION ===========
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

	//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>GOOD FRAME STIMULUS PASSING<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
	
	
	//***************************************** in to loop when the len is divisible by 4 ********************************************************

			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h0033C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_1

			//total_configuration('hC,0,'h0000ABCD,1,15,1,'h0037C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_2

			//total_configuration('hC,0,'h0000ABCD,1,15,2,'h0035C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_3

			//total_configuration('hC,0,'h0000ABCD,1,15,3,'h0101C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_4
	
			//total_configuration('hC,0,'h0000ABCD,1,14,0,'h0041C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_5	

			//total_configuration('hC,0,'h0000ABCD,1,14,1,'h0103C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_6	

			//total_configuration('hC,0,'h0000ABCD,1,14,2,'h0057C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_7	

			//total_configuration('hC,0,'h0000ABCD,1,14,3,'h0059C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_8	

			//total_configuration('hC,0,'h0000ABCD,1,13,0,'h0033C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_9	

			//total_configuration('hC,0,'h0000ABCD,1,13,1,'h004BC000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_10

			//total_configuration('hC,0,'h0000ABCD,1,13,2,'h004DC000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_11			

			//total_configuration('hC,0,'h0000ABCD,1,13,3,'h0031C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_12

			//total_configuration('hC,0,'h0000ABCD,1,12,0,'h0069C000,49154);  //GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_13

			//total_configuration('hC,0,'h0000ABCD,1,12,1,'h0069C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_14			

			//total_configuration('hC,0,'h0000ABCD,1,12,2,'h0043C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_15	

			//total_configuration('hC,0,'h0000ABCD,1,12,3,'h0059C000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_16
	
			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h003D8000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_17	
	
			//total_configuration('hC,0,'h0000ABCD,1,15,1,'h002D8000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_18
		
			//total_configuration('hC,0,'h0000ABCD,1,15,2,'h00358000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_19	

			//total_configuration('hC,0,'h0000ABCD,1,15,3,'h007D8000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_20		

			//total_configuration('hC,0,'h0000ABCD,1,14,0,'h00638000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_21	

			//total_configuration('hC,0,'h0000ABCD,1,14,1,'h009B8000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_22

			//total_configuration('hC,0,'h0000ABCD,1,14,2,'h00638000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_23	

			//total_configuration('hC,0,'h0000ABCD,1,14,3,'h00538000,49154);  //GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_24

			//total_configuration('hC,0,'h0000ABCD,1,13,0,'h00718000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_25

			//total_configuration('hC,0,'h0000ABCD,1,13,1,'h00318000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_26	

			//total_configuration('hC,0,'h0000ABCD,1,13,2,'h00418000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_27

			//total_configuration('hC,0,'h0000ABCD,1,13,3,'h00328000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_28

			//total_configuration('hC,0,'h0000ABCD,1,12,0,'h002D8000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_29		

			//total_configuration('hC,0,'h0000ABCD,1,12,1,'h00358000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_30	

			//total_configuration('hC,0,'h0000ABCD,1,12,2,'h00468000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_31	

			//total_configuration('hC,0,'h0000ABCD,1,12,3,'h00738000,49154);	//GOOD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_32	*/

	
    //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>BAD FRAME STIMULUS PASSING<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

			//total_configuration('hC,0,'h0000ABCD,1,15,0,'h0029C000,'h00002002);	//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_1
		
			//total_configuration('hC,0,'h0000ABCD,1,15,1,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_2
		
			//total_configuration('hC,0,'h0000ABCD,1,15,2,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_3
		  
			//total_configuration('hC,0,'h0000ABCD,1,15,3,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_4
		
			//total_configuration('hC,0,'h0000ABCD,1,14,0,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_5	
	
			//total_configuration('hC,0,'h0000ABCD,1,14,0,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_6
		
			/*total_configuration('hC,0,'h0000ABCD,1,14,2,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_7
		
			total_configuration('hC,0,'h0000ABCD,1,14,3,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_8	*/
	
			//total_configuration('hC,0,'h0000ABCD,1,13,0,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_9	
	
			//total_configuration('hC,0,'h0000ABCD,1,13,0,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_10

			//total_configuration('hC,0,'h0000ABCD,1,13,1,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_11
		
			/*total_configuration('hC,0,'h0000ABCD,1,13,2,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_12
		
			total_configuration('hC,0,'h0000ABCD,1,12,3,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_13
		
			total_configuration('hC,0,'h0000ABCD,1,12,0,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_14 */
		
			//total_configuration('hC,0,'h0000ABCD,1,12,1,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_15
		
			//total_configuration('hC,0,'h0000ABCD,1,12,2,'h0029C000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_16
		
			//total_configuration('hC,0,'h0000ABCD,1,15,3,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_17
		
			/*total_configuration('hC,0,'h0000ABCD,1,15,0,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_18
		
			total_configuration('hC,0,'h0000ABCD,1,15,1,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_19
	
			total_configuration('hC,0,'h0000ABCD,1,15,2,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_20
		
			total_configuration('hC,0,'h0000ABCD,1,14,3,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_21
		
			total_configuration('hC,0,'h0000ABCD,1,14,0,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_22
		
			total_configuration('hC,0,'h0000ABCD,1,14,2,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_23*/
		
		//	total_configuration('hC,0,'h0000ABCD,1,14,3,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_24
		
			/*total_configuration('hC,0,'h0000ABCD,1,13,0,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_25
		
			total_configuration('hC,0,'h0000ABCD,1,13,1,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_26
		
			total_configuration('hC,0,'h0000ABCD,1,13,2,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_27
		
			total_configuration('hC,0,'h0000ABCD,1,13,3,'h00298000,'h00002002);	//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_28

			total_configuration('hC,0,'h0000ABCD,1,12,0,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_29	

			total_configuration('hC,0,'h0000ABCD,1,12,1,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_30

			total_configuration('hC,0,'h0000ABCD,1,12,2,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_31

			total_configuration('hC,0,'h0000ABCD,1,12,3,'h00298000,'h00002002);//BAD_FRAME_TRANSMISSION_INTERRUPT_SOURCE_CHECK_32*/
			
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
