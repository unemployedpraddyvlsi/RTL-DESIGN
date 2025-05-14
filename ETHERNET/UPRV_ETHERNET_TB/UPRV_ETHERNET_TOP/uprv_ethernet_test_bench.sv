// ============== TOP ==============

//---------DUT files included--------

`include "../../MCS_DV06_ETHERNET_RTL/timescale.v"
`include "../../MCS_DV06_ETHERNET_RTL/ethmac_defines.v"

`include "../../MCS_DV06_ETHERNET_RTL/apb_BDs_bridge.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_clockgen.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_crc.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_fifo.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_maccontrol.v"

`include "../../MCS_DV06_ETHERNET_RTL/eth_macstatus.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_miim.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_outputcontrol.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_random.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_receivecontrol.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_register.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_registers.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_rxaddrcheck.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_rxcounters.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_rxethmac.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_rxstatem.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_shiftreg.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_spram_256x32.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_transmitcontrol.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_txcounters.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_txethmac.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_txstatem.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_wishbone.v"
`include "../../MCS_DV06_ETHERNET_RTL/eth_top.v"




module top;

	import uvm_pkg::*;

	import pkg::*;

	bit pclk_i;
	
	always #5  pclk_i++;
	
	bit MTxclk;

	always #20  MTxclk++;

	inf h_vinf(pclk_i,MTxclk);
  
  	eth_top DUV(.pclk_i(h_vinf.pclk_i),
              .mtx_clk_pad_i(h_vinf.MTxclk),
              .mtxd_pad_o(h_vinf.MTxD),
              .mtxen_pad_o(h_vinf.MTxEn),
              .mtxerr_pad_o(h_vinf.MTxErr),
              .prstn_i(h_vinf.prstn_i),
              .paddr_i(h_vinf.paddr_i),
              .pwdata_i(h_vinf.pwdata_i),
              .prdata_o(h_vinf.prdata_o),
              .psel_i(h_vinf.psel_i),
              .penable_i(h_vinf.penable_i),
              .pwrite_i(h_vinf.pwrite_i),
              .pready_o(h_vinf.pready_o),
              .int_o(h_vinf.int_o),
              .m_prdata_i(h_vinf.m_prdata_i),
              .m_pready_i(h_vinf.m_pready_i),
              .m_paddr_o(h_vinf.m_paddr_o),
              .m_pwdata_o(h_vinf.m_pwdata_o),
              .m_psel_o(h_vinf.m_psel_o),
              .m_penable_o(h_vinf.m_penable_o),
              .m_pwrite_o(h_vinf.m_pwrite_o),
                .mrx_clk_pad_i(0), .mrxd_pad_i(0), .mrxdv_pad_i(0), .mrxerr_pad_i(0), .mcrs_pad_i (0)
              
 
             );
             
	assertion AUV(.pclk_i(h_vinf.pclk_i),
              .MTxclk(h_vinf.MTxclk),
              .MTxD(h_vinf.MTxD),
              .MTxEn(h_vinf.MTxEn),
              .MTxErr(h_vinf.MTxErr),
              .prstn_i(h_vinf.prstn_i),
              .paddr_i(h_vinf.paddr_i),
              .pwdata_i(h_vinf.pwdata_i),
              .prdata_o(h_vinf.prdata_o),
              .psel_i(h_vinf.psel_i),
              .penable_i(h_vinf.penable_i),
              .pwrite_i(h_vinf.pwrite_i),
              .pready_o(h_vinf.pready_o),
              .int_o(h_vinf.int_o),
              .m_prdata_i(h_vinf.m_prdata_i),
              .m_pready_i(h_vinf.m_pready_i),
              .m_paddr_o(h_vinf.m_paddr_o),
              .m_pwdata_o(h_vinf.m_pwdata_o),
              .m_psel_o(h_vinf.m_psel_o),
              .m_penable_o(h_vinf.m_penable_o),
              .m_pwrite_o(h_vinf.m_pwrite_o)
                );
  
/*  	bind  eth_top assertion AUV(.pclk_i(h_vinf.pclk_i),
              .MTxclk(h_vinf.MTxclk),
              .MTxD(h_vinf.MTxD),
              .MTxEn(h_vinf.MTxEn),
              .MTxErr(h_vinf.MTxErr),
              .prstn_i(h_vinf.prstn_i),
              .paddr_i(h_vinf.paddr_i),
              .pwdata_i(h_vinf.pwdata_i),
              .prdata_o(h_vinf.prdata_o),
              .psel_i(h_vinf.psel_i),
              .penable_i(h_vinf.penable_i),
              .pwrite_i(h_vinf.pwrite_i),
              .pready_o(h_vinf.pready_o),
              .int_o(h_vinf.int_o),
              .m_prdata_i(h_vinf.m_prdata_i),
              .m_pready_i(h_vinf.m_pready_i),
              .m_paddr_o(h_vinf.m_paddr_o),
              .m_pwdata_o(h_vinf.m_pwdata_o),
              .m_psel_o(h_vinf.m_psel_o),
              .m_penable_o(h_vinf.m_penable_o),
              .m_pwrite_o(h_vinf.m_pwrite_o)
                );*/
              
 
              
              //bind eth_top assertion AUV( .*);

	initial begin

		uvm_config_db #(virtual inf)::set(null,"*","Interface",h_vinf);			// setting the interface and given access to all the lower hirarchy
		
		uvm_top.run_test();

	end
		
endmodule