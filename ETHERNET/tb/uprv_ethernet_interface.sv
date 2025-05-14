// ================== INTERFACE ==================

interface inf(input pclk_i,MTxclk);


    logic prstn_i;																// =============== MASTER DRIVING SIGNALS FROM TB TO DUV ============
	logic psel_i;
	logic penable_i;
	logic pwrite_i;
	logic [31:0]paddr_i;
	logic [31:0]pwdata_i;


	logic pready_o;															    // ============== OUTPUT SIGNALS UPDATED FROM SLAVE IN DUT TO TB ==============
	logic [31:0]prdata_o;

	

	logic m_pready_i;															// =============== SLAVE DRIVING SIGNALS FROM TB TO DUV  ============
	logic [31:0]m_prdata_i;


	logic m_psel_o;																// ==============  OUTPUT SIGNALS UPDATED FROM MASTER IN DUT TO THE TB ===========
	logic m_penable_o;
	logic m_pwrite_o;
	logic [31:0]m_paddr_o;
	logic [31:0]m_pwdata_o;
	

	logic MCrS;																	// ========================= DRIVING TO TxMAC FROM TB  =====================


	logic MTxEn;																// ==============  OUTPUT SIGNALS UPDATED FROM TXMAC IN DUT TO TB==============
	logic MTxErr;
	logic [3:0]MTxD;
		
 
	logic int_o;																// ============== OUTPUT SIGNAL FROM DUT =================


  
	clocking cb_master_driver @(posedge pclk_i);								//--------------- clocking block for master driver class -----------------

		input pready_o,prdata_o;

    	output prstn_i,psel_i,penable_i,pwrite_i,paddr_i,pwdata_i;

  	endclocking

 
  	clocking cb_slave_driver @(posedge pclk_i);									//----------------- clocking block for slave driver-----------------------

    	input m_psel_o,m_penable_o,m_pwrite_o,m_paddr_o,m_pwdata_o;

		output m_pready_i,m_prdata_i;

  	endclocking



  	clocking cb_tx_mac_driver @(posedge MTxclk);								//----------------- clocking block for tx_mac driver-----------------------

		input MTxEn,MTxErr,MTxD;
		
    	output MCrS;

  	endclocking



  	clocking cb_tx_mac_monitor @(posedge MTxclk);								//----------------- clocking block for tx_mac outputmonitor-----------------

    	input MTxEn,MTxErr,MTxD,MCrS;

  	endclocking



  	clocking cb_monitor @(posedge pclk_i);										//----------------- clocking block for monitor-------------------------

    	input pready_o,prdata_o;

    	input prstn_i,psel_i,penable_i,pwrite_i,paddr_i,pwdata_i;
    	
    	input m_psel_o,m_penable_o,m_pwrite_o,m_paddr_o,m_pwdata_o;

		input m_pready_i,m_prdata_i;


  	endclocking
  	
  	
  	//always@(posedge pclk_i) $display("---------------------------------------------------------------------",$time,"-----------------------------------------------------------------------------");

	always@(posedge pclk_i) $display($time,"----------------IN THE INTERFACE------------------------> \n m_paddr_o = %d , \n m_pwdata_o = %d , \n m_pwrite_o = %d , \n m_psel_o = %0d  \n m_penable_o = %0d  \n m_pready_i = %0d \n m_prdata_i = %0d ----------------------------------------------------",m_paddr_o,m_pwdata_o,m_pwrite_o,m_psel_o,m_penable_o,m_pready_i,m_prdata_i);
	
	always@(posedge pclk_i) $display($time,"^^^^^^^^^^^^^^^^^^IN THE INTERFACE^^^^^^^^^^^^^^^^^^^^^ \n paddr_i = %d  \n pwdata_i = %d \n pwrite_i = %d ,\n psel_i = %d ,\n penable_i = %d ,\n pready_o = %d ,\n prdata_o = %d  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^",paddr_i,pwdata_i,pwrite_i,psel_i,penable_i,pready_o,prdata_o);
	
	always@(posedge pclk_i) $display($time,"&&&&&&&&&&&&&&&&&&&&&&IN THE INTERFACE &&&&&&&&&&&&&&&&&&&&&&&&& \nint_o \n = %d",int_o);
	
	always@(posedge MTxclk) $display($time,"******************IN THE INTERFACE********************** \n MCrS = %0d \n MTxEn = %d \n MTxD = %d \n MTxErr = %0d ************************************************",MCrS,MTxEn,MTxD,MTxErr);

endinterface



