
//====================== COVERAGE CLASS (COMPONENT) ===========================

class coverage extends uvm_component;

	`uvm_component_utils(coverage)												// ================ FACTORY REGISTRATION ==================

	sequence_item req,req2;														// ========== HANDLES DECLARATION ===========
		
	`uvm_analysis_imp_decl(_i_mon)                                        		// declaring the user defined analysis implement because of we are connecting the two monitors for scoreboard

	uvm_analysis_imp_i_mon#(sequence_item,coverage)h_tx_coverage_imp;        	// handle creation for the coverage input tx monitor amalysis implement

	uvm_analysis_imp#(sequence_item,coverage) h_tx_mac_coverage_imp;            // handle creation for the coverage input tx mac  monitor amalysis implement
		
	virtual inf h_vinf;
		

	covergroup cov_group_at_apb_side;
		
		

		
		
		s_mcrs:	coverpoint	h_vinf.MCrS;										// === Mcrs bins ==
			
			
		
																				//{========== SINGLE BIT WIDTH ===========
		s_preset : 	coverpoint 	h_vinf.prstn_i;
			
		s_pselect: 	coverpoint	h_vinf.psel_i	iff(h_vinf.prstn_i==1){ bins psel_0 = {0}; bins  psel_1 = {1};}
			
		s_penable: 	coverpoint	h_vinf.penable_i	iff(h_vinf.prstn_i==1){bins penable_0 = {0}; bins penable_1 = {1};}
			
		s_pwrite: 	coverpoint	h_vinf.pwrite_i	iff(h_vinf.prstn_i==1);
			
		s_mpready: 	coverpoint	h_vinf.m_pready_i	iff(h_vinf.prstn_i==1); 
																				//}
																					
																				//{ ========== MULTI BIT WIDTH ===========
																					
		m_paddress: coverpoint	h_vinf.paddr_i		iff((h_vinf.prstn_i==1)) {
			
				bins  m_paddress1 = {0};										// 	MODER address bin
				
				bins  m_paddress2 = {4};										// INT_SOURCE address bin
				
				bins  m_paddress3 = {8};										// INT_MASK address bin 
				
				bins  m_paddress4 = {32};										// TX_BD_NUM address bin
				
				bins  m_paddress5 = {48};										//MIIADDRESSS address bin
				
				bins  m_paddress6 = {64};										//MAC_ADDR0
				
				bins  m_paddress7 = {68};										//MAC_ADDR1
				
				bins bd_address[] = {[1024:2047]};  				
				
		}

		m_pwdata: 	coverpoint	h_vinf.pwdata_i	iff((h_vinf.prstn_i==1) && (h_vinf.psel_i==1)) { 
			
				bins  m_pwdata1 = {0};											// all bits zeroes
				
				bins  m_pwdata2 = {1431655765};									// alternate zeros and ones 
				
				bins  m_pwdata3 = {2863311530};									// alternate ones and zeroes
				
				bins  m_pwdata4 = {4294967295};									// all ones

		}
				 
		m_pwdata_moder: coverpoint h_vinf.pwdata_i 	iff((h_vinf.prstn_i==1) && (h_vinf.paddr_i==0)) {
																				// MODER DATA RELATED BINS
			
				bins basic 				= {'h00000200};
				bins tx_enable 			= {'h00000202};
				bins nopre_enable 		= {'h00000206};
				bins ifg_enable 		= {'h00000282};
				bins pad_enable 		= {'h00008202};
				bins higen_enable 		= {'h00004202};
				bins pad_hugen_enable 	= {'h0000C202};
				bins tx_rx_both_enable 	= {'h00000203};
				
		}
			
		m_pwdata_int_source: coverpoint h_vinf.pwdata_i 	iff((h_vinf.prstn_i==1) && (h_vinf.paddr_i==4)) {
																				// INT SOURCE DATA RELATED BINS
			
				bins txe_txb_not_enable 	= {'h00000000};
				bins txb_enable 			= {'h00000001};
				bins txe_enable 			= {'h00000002};
				bins txe_txb_both_enable 	= {'h00000003};
				
		}
			
		m_pwdata_int_mask: coverpoint h_vinf.pwdata_i 	iff((h_vinf.prstn_i==1) && (h_vinf.paddr_i==8)) {
																				// INT MASK DATA RELATED BINS
			
				bins m_txe_m_txb_not_enable 	= {'h00000000};
				bins m_txb_enable 				= {'h00000001};
				bins m_txe_enable 				= {'h00000002};
				bins m_txe_m_txb_both_enable 	= {'h00000003};
				
		}
			
		m_pwdata_tx_bd_num: coverpoint h_vinf.pwdata_i 	iff((h_vinf.prstn_i==1) && (h_vinf.paddr_i==32)) {
																				// TX_BD_NUM DATA RELATED BINS
			
				bins bd_numbers = {['h00000000:'h0000007F]};
				
		}
				
		m_pwdata_mii_address: coverpoint h_vinf.pwdata_i 	iff((h_vinf.prstn_i==1) && (h_vinf.paddr_i==48)) {
																				// TX_BD_NUM DATA RELATED BINS
			
				bins mii_add = {'h0000000c};
				
		}
				
		m_pwdata_mac0_address: coverpoint h_vinf.pwdata_i 	iff((h_vinf.prstn_i==1) && (h_vinf.paddr_i==64)) {
																				// TX_BD_NUM DATA RELATED BINS
			
				bins mac0_add = {'h00000000};
				
		}
				
		m_pwdata_mac1_address: coverpoint h_vinf.pwdata_i 	iff((h_vinf.prstn_i==1) && (h_vinf.paddr_i==68)) {
																				// TX_BD_NUM DATA RELATED BINS
			
          bins mac_1add= {'h0000ABCD};
				
		}
			
			
		m_mprdata :	coverpoint	h_vinf.m_prdata_i	iff(h_vinf.prstn_i==1) {
				
				bins  m_mprdata1 	= {0};										// all bits zeroes
				
				bins  m_mprdata2 	= {1431655765};								// alternate zeros and ones 
				
				bins  m_mprdata3 	= {2863311530};								// alternate ones and zeroes
				
				bins  m_mprdata4 	= {4294967295};								// all ones
				
				bins  m_mprdata5[10] = {[0         : 429496729],
										[429496730 : 858993459],
										[858993460 : 1288490188],
										[1288490189: 1717986918 ],
										[1717986919: 2147483647],
										[2147483648: 2576980377 ],
										[2576980378: 3006477106],
										[3006477107: 3435973836 ],
										[3435973837: 3865470565],
										[3865470566: 4294967295]};
				
		}												
				

																				
																				//}
																					
																				//{========== TRANSITION BINS ===========
																					
																				//}
																					
																					
																				//{========== CROSS BINS ===========
																					
			c_pselect_penable : cross s_pselect,s_penable iff(h_vinf.prstn_i==1){
			
              ignore_bins ig_bin1 = binsof(s_pselect.psel_0) && binsof(s_penable.penable_1);}
								
																					
																				//}
																					
																					
																				

		endgroup

		function new(string name ="coverage",uvm_component parent);					// =================== COMPONENT CONSTRUCTION ===================

			super.new(name,parent);

			cov_group_at_apb_side = new();

		endfunction

		function void build_phase(uvm_phase phase);

			super.build_phase(phase);

			req  = sequence_item :: type_id :: create ("req");
			
			req2 = sequence_item :: type_id :: create ("req2");
			
			h_tx_coverage_imp     = new("h_tx_coverage_imp",this);
			      
			h_tx_mac_coverage_imp = new("h_tx_mac_coverage_imp",this);
			
			uvm_config_db #(virtual inf) :: get(this,"","Interface",h_vinf);
			
			`uvm_info("IN THE  COVERAGE CLASS","BUILD PHASE IS DONE",UVM_DEBUG)

		endfunction
		
		function write_i_mon(input sequence_item req);

			this.req = req;                                             		// assigning the data from input monitor packet 
																				//handle  to the COVERAGE packet handle 

		endfunction
		
		function write(input sequence_item req2);

			this.req2 = req2;                                             		// assigning the data from input monitor packet 
																				//shandle  to the COVERAGE packet handle 

		endfunction
		
		task run_phase(uvm_phase phase);
	    
	    	super.run_phase(phase);

			forever @(h_vinf.cb_monitor)begin
	    
	    		cov_group_at_apb_side.sample();
	    		
	    		$display($time,"@@@@@@@@@@@@@@@@@@@@@@@@@@@ apb side coverage == %f @@@@@@@@@@@@@@@@@@@@@@@@@",cov_group_at_apb_side.get_coverage());

			end 
	    
	    	`uvm_info("IN THE  COVERAGE CLASS","RUN PHASE IS DONE",UVM_DEBUG)
	    
	  	endtask

		

	endclass

			
