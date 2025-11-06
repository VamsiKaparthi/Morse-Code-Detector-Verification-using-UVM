class passive_agent extends uvm_agent;
	`uvm_component_utils(passive_agent)
	passive_monitor p_mon;
	function new(string name = "passive_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		p_mon = passive_monitor::type_id::create("p_mon", this);
	endfunction	
endclass

class active_agent extends uvm_agent;
	`uvm_component_utils(active_agent)
	active_monitor a_mon;
	driver drv;
	sequencer sqr;
	function new(string name = "active_agent", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_mon = active_monitor::type_id::create("p_mon", this);
		drv = driver::type_id::create("drv", this);
		sqr = sequencer::type_id::create("sqr", this);
	endfunction
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
	endfunction
endclass

