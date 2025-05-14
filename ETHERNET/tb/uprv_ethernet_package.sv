package pkg;

	import uvm_pkg::*;

	`include "uvm_macros.svh"

	`include "uprv_ethernet_config_class.sv"

	`include "uprv_ethernet_sequence_item.sv"

	`include "uprv_ethernet_sequence_related_to_apb_testcases.sv"

	`include "uprv_ethernet_sequence_related_to_mcrs_txen_rd_txbdnum.sv"

	`include "uprv_ethernet_sequence_related_to_pad_hugen_frame_length.sv"

	`include "uprv_ethernet_sequence_related_to_irq_tx_e_m_tx_b_m_tx_e_tx_b_int_o.sv.sv.sv"
	

	`include "uprv_ethernet_sequence_related_to_no_pre_ifg.sv"



	`include "uprv_ethernet_master_sequencer.sv"

 	`include "uprv_ethernet_slave_sequencer.sv"

	`include "uprv_ethernet_tx_mac_sequencer.sv"

	//`include "uprv_ethernet_into_sequence.sv"

	



	

	`include "uprv_ethernet_master_sequence.sv"

	`include "uprv_ethernet_slave_sequence.sv"

	`include "uprv_ethernet_tx_mac__sequence.sv"

	`include "uprv_ethernet_virtual_sequencer.sv"

	`include "uprv_ethernet_virtual_sequence.sv"


 	`include "uprv_ethernet_master_driver.sv"

 	`include "uprv_ethernet_slave_driver.sv"

	`include "uprv_ethernet_tx_mac_driver.sv"



 	`include "uprv_ethernet_tx_input_monitor.sv"

	`include "uprv_ethernet_tx_mac_input_monitor.sv"



	`include "uprv_ethernet_tx_output_monitor.sv"

	`include "uprv_ethernet_tx_mac_output_monitor.sv"



 	`include "uprv_ethernet_master_active_agent.sv"

 	`include "uprv_ethernet_slave_active_agent.sv"

	`include "uprv_ethernet_tx_active_agent.sv"

	`include "uprv_ethernet_tx_mac_active_agent.sv"


	
	`include "uprv_ethernet_tx_passive_agent.sv"

	`include "uprv_ethernet_tx_mac_passive_agent.sv"


	`include "uprv_ethernet_tx_scroeboard.sv"

	`include "uprv_ethernet_coverage.sv"


	`include "uprv_ethernet_apb_env.sv"

	`include "uprv_ethernet_tx_mac_env.sv"

	`include "uprv_ethernet_main_env.sv"


	
	
	`include "uprv_ethernet_test.sv"



endpackage
