// =================== SEQUENCE CLASS (OBJECT) =========================

//class seq extends uvm_sequence#(master_sequence_item,slave_sequence_item,tx_mac_sequence_item);

class master_sequence extends uvm_sequence#(sequence_item);

	`uvm_object_utils(master_sequence)											//=========== FACTORY REGISTRATION ===========
  
  
	
	config_class h_config_class;
  
  
	
	sequence_related_to_apb_testcases h_sequence_related_to_apb_testcases;
	
	sequence_related_to_mcrs_txen_rd_txbdnum h_sequence_related_to_mcrs_txen_rd_txbdnum;
  
  	sequence_related_to_pad_hugen_frame_length h_sequence_related_to_pad_hugen_frame_length;
  
  	sequence_related_to_irq_tx_e_m_tx_b_m_tx_e_tx_b_int_o h_sequence_related_to_irq_tx_e_m_tx_b_m_tx_e_tx_b_int_o;
  
  	sequence_related_to_no_pre_ifg h_sequence_related_to_no_pre_ifg;
  
  

	function new(string name = "master_sequence");								// ============== OBJECT CONSTRUCTION =============

			super.new(name);

	endfunction

	task body();																//============ RANDOMIZING THE STIMULUS ==========

		req = sequence_item :: type_id :: create("req");
      
		h_sequence_related_to_apb_testcases = sequence_related_to_apb_testcases :: type_id :: create("h_sequence_related_to_apb_testcases");
		
		h_sequence_related_to_mcrs_txen_rd_txbdnum = sequence_related_to_mcrs_txen_rd_txbdnum :: type_id :: create("h_sequence_related_to_mcrs_txen_rd_txbdnum");
      
      	h_sequence_related_to_pad_hugen_frame_length = sequence_related_to_pad_hugen_frame_length :: type_id :: create("h_sequence_related_to_pad_hugen_frame_length");
      
      	h_sequence_related_to_irq_tx_e_m_tx_b_m_tx_e_tx_b_int_o = sequence_related_to_irq_tx_e_m_tx_b_m_tx_e_tx_b_int_o :: type_id :: create("h_sequence_related_to_irq_tx_e_m_tx_b_m_tx_e_tx_b_int_o");
      
      h_sequence_related_to_no_pre_ifg = sequence_related_to_no_pre_ifg :: type_id :: create("h_sequence_related_to_no_pre_ifg");
      	
		
		uvm_config_db #(config_class)::get(null,"","config_class",h_config_class);
      
      
		
		//h_sequence_related_to_apb_testcases.start(m_sequencer);				//************ check completed *******************
		
		h_sequence_related_to_mcrs_txen_rd_txbdnum.start(m_sequencer);
      
      	//h_sequence_related_to_pad_hugen_frame_length.start(m_sequencer);
      
      	//h_sequence_related_to_irq_tx_e_m_tx_b_m_tx_e_tx_b_int_o.start(m_sequencer);
      
      	//h_sequence_related_to_no_pre_ifg.start(m_sequencer);
      
	endtask
  
endclass
