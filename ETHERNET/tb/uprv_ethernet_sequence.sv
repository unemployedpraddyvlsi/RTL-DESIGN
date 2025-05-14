// =================== SEQUENCE CLASS (OBJECT) =========================

//class seq extends uvm_sequence#(master_sequence_item,slave_sequence_item,tx_mac_sequence_item);

class seq extends uvm_sequence#(sequence_item);

	`uvm_object_utils(seq)														//=========== FACTORY REGISTRATION ===========
	
	config_class h_config_class;
	
	sequence_related_to_apb_testcases h_sequence_related_to_apb_testcases;
	
	sequence_related_to_mcrs_txen_rd_txbdnum h_sequence_related_to_mcrs_txen_rd_txbdnum;	

	function new(string name = "seq");											// ============== OBJECT CONSTRUCTION =============

			super.new(name);

	endfunction

	task body();																//============ RANDOMIZING THE STIMULUS ==========

		req = sequence_item :: type_id :: create("req");
		
		h_sequence_related_to_apb_testcases = sequence_related_to_apb_testcases :: type_id :: create("h_sequence_related_to_apb_testcases");
		
		h_sequence_related_to_mcrs_txen_rd_txbdnum = sequence_related_to_mcrs_txen_rd_txbdnum :: type_id :: create("h_sequence_related_to_mcrs_txen_rd_txbdnum");
		
		uvm_config_db #(config_class)::get(null,"","config_class",h_config_class);
		
		//h_sequence_related_to_apb_testcases.start(m_sequencer);
		
		//h_sequence_related_to_mcrs_txen_rd_txbdnum.start(m_sequencer);
			
		basic_test;
      
	endtask
  
  	task basic_test;
      
      	start_item(req);
      
      assert(req.randomize()with {pwrite_i ==1; paddr_i ==48 ; pwdata_i == 'hC;} );   // mii add
      
      finish_item(req);
      
      
      
      start_item(req);
      
      assert(req.randomize()with {pwrite_i ==1; paddr_i ==64 ; pwdata_i == 0;} );   // mac_addr0 
      
		finish_item(req);
      
      
      
      start_item(req);
      
      assert(req.randomize()with {pwrite_i ==1; paddr_i ==68 ; pwdata_i == 'hABCD;} );  // mac_addr1
      
		finish_item(req);
      
      
      
      start_item(req);

      assert(req.randomize()with {pwrite_i ==1; paddr_i ==32 ; pwdata_i ==1 ;} );  // tx_bd_num
      
		finish_item(req);
      
      
      
      start_item(req);
      
      assert(req.randomize()with {pwrite_i ==1; paddr_i ==4 ; pwdata_i == 15;} );  //  int_mask
      
		finish_item(req);
      
      
      
      start_item(req);
      
      assert(req.randomize()with {pwrite_i ==1; paddr_i ==8 ; pwdata_i ==0 ;} );  //int_asource
      
		finish_item(req);
      
      
      
      start_item(req);
      
      assert(req.randomize()with {pwrite_i ==1; paddr_i ==1024 ; pwdata_i == 43040768;} );  // offset+0
      
		finish_item(req);
      
      
      
      start_item(req);
      
      assert(req.randomize()with {pwrite_i ==1; paddr_i ==1028 ;} );   // offect +4
      
		finish_item(req);
      
      
      
      start_item(req);
      
      assert(req.randomize()with {pwrite_i ==1; paddr_i ==0 ; pwdata_i == 49154;} );  //moder
      
		finish_item(req);
      
      	
      
    endtask

																				
//--------------------------------------------------------------------------------------------------------------------------------------------------------------																				
	
		
		
		
		
		

endclass
