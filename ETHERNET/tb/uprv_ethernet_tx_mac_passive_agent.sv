// ================= PASSIVE AGENT CLASS (COMPONENT) =================

class tx_mac_passive_agent extends uvm_agent;

	`uvm_component_utils(tx_mac_passive_agent)									// ================ FACTORY REGISTRATION ==================

	tx_mac_output_monitor h_tx_mac_outputmonitor;								// ========== HANDLES DECLARATION ===========
  
  	uvm_analysis_export#(sequence_item) h_tx_mac_passive_agent_export;
	
	
	function new(string name = "passive_agent",uvm_component parent);			// =================== COMPONENT CONSTRUCTION ===================

			super.new(name,parent);

	endfunction
		
	function void build_phase(uvm_phase phase);									// ================== BUILD PHASE ==============

		super.build_phase(phase);

		h_tx_mac_outputmonitor = tx_mac_output_monitor :: type_id :: create ("h_tx_mac_outputmonitor",this);
      
      	h_tx_mac_passive_agent_export = new("h_tx_mac_passive_agent_export",this);
		
		`uvm_info("IN THE TX MAC PASSIVE_AGENT CLASS","BUILD PHASE IS COMPLETED",UVM_DEBUG);

	endfunction
  
  
  function void connect_phase(uvm_phase phase);
    
    super.connect_phase(phase);
    
    h_tx_mac_outputmonitor.h_tx_mac_output_monitor_port.connect(this.h_tx_mac_passive_agent_export);
    
    
    
  endfunction

endclass