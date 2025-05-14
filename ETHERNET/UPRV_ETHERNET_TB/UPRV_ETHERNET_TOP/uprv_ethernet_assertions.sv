
module assertion(input bit 	pclk_i,
							MTxclk,
							prstn_i,
							pwrite_i,
							psel_i,
							penable_i,
							[31:0]paddr_i,
							[31:0]pwdata_i,
							bit m_pready_i,
							bit [31:0]m_prdata_i,
							bit [31:0]prdata_o,
							bit pready_o,
							bit m_psel_o,
							m_penable_o,
							m_pwrite_o,
							bit [31:0]m_paddr_o,
							m_pwdata_o,
							bit MCrs,
							MTxEn,
							MTxErr,
							bit [3:0]MTxD,
							bit int_o
							 );

	
  	real apb_clock_period = 10000;
  	
  	real mac_clock_period = 40000;
  	
//-------------------------------------------------------------------------------

	property clock_check (real EXP_PERIOD);

		real start_time;

		(1,start_time = $realtime) |=> ($realtime - start_time == EXP_PERIOD);

	endproperty 
	
	
	
	always @ (posedge pclk_i)

	begin
	
		

		assert property (clock_check(apb_clock_period))$display($realtime,"======================= APB CLOCK ASSERTION PASSED ===========================");
	
		else begin $warning($realtime,"============================= APB CLOCK ASSERTION FAILED ================================="); end

	end 																		//this checks clock frequency of pclk_i



	always @(posedge MTxclk)

	begin

      assert property(clock_check(mac_clock_period))$display($realtime,"===================== MAC CLOCK ASSERTION PASSED ====================");
	
		else begin $warning($realtime,"======================== MAC CLOCK ASSERTION FAILED ============================="); end


	end 																		// this would check frequency of MTxclk
	
//------------------------------------------------------------------------------


	property mtxen_check;
	
		@(posedge MTxclk) disable iff(!prstn_i)
		
		MCrs throughout MTxEn;
		 
	endproperty
	
        assert property(mtxen_check) $display("================== MTXEN ASSERTION PASSED =========");
	
	else begin $warning("================ MTXEN ASSERTION FAILED ====================="); end
	
	
//------------------------------------------------------------------------------
	
	property err_data;
	
		@(posedge MTxclk)  disable iff(MTxErr)
		
			((MCrs==1) & (MTxEn==1)) |-> MTxErr==0;
			
	endproperty
	
          assert property(err_data) $display("======================== MTXERR ASSERTION PASSED ==============================");
	
	else begin $display("================================== MTXERR ASSERTION FAILED ============================="); end
	

//------------------------------------------------------------------------------
	
	property enable_check;
	
		@(posedge pclk_i) disable iff(!prstn_i)
		
		 $rose(psel_i) |-> (penable_i==0) |=> $rose(penable_i);
		 
	endproperty

            assert property(enable_check) $display("======================= PENABLE ASSERTION PASSED ===============================");
	
	else begin $warning("========================== PENABLE ASSERTION FAILED ============================"); end

//------------------------------------------------------------------------------
	
	sequence addr;
	
		paddr_i == $past(paddr_i);
		
	endsequence
	
	sequence data;
	
		pwdata_i == $past(pwdata_i);
		
	endsequence

	property stability_check;
	
		@(posedge pclk_i) disable iff((!prstn_i) || ( (!psel_i) && penable_i) || ((!psel_i) && (!penable_i)) || ((psel_i) && (!penable_i)))
		
					addr and data ;
					
	endproperty 

      assert property(stability_check) $display("========================== PWDATA AND PADDR STABILITY ASSERTION PASSED =============================");
	
	else begin $warning("================================ PWDATA AND PADDR STABILITY ASSERTION FAILED ============================"); end
	


endmodule

