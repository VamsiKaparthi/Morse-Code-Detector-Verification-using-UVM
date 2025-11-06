class test extends uvm_test;
	`uvm_component_utils(test)
	single_char_seq seq;
	env e1;
	function new(string name = "test", uvm_component parent = null);
		super.new(name, parent);
		seq = single_char_seq::type_id::create("seq");
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		e1 = env::type_id::create("e1", this);
	endfunction
	task run_phase(uvm_phase phase);
		phase.raise_objection(this, "Raised");
		seq.start(e1.a_agent.sqr);
		phase.drop_objection(this, "Dropped");
	endtask
endclass
