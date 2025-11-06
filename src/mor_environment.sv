class env extends uvm_env;
	`uvm_component_utils(env)
	active_agent a_agent;
	passive_agent p_agent;
	function new(string name = "env", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a_agent = active_agent::type_id::create("a_agent", this);
		p_agent = passive_agent::type_id::create("p_agent", this);
	endfunction
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
	endfunction
endclass
