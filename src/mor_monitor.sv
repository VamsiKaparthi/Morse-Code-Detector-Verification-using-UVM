class active_monitor extends uvm_monitor;
	`uvm_component_utils(active_monitor)
	uvm_analysis_port #(seq_item) item_collect_active_mon;
	virtual mor_inf vif;
	function new(string name = "monitor", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	seq_item req;
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		req = seq_item::type_id::create("req");
		item_collect_active_mon = new("icm");
		if(uvm_config_db#(virtual mor_inf)::get(this, "", "vif", vif))begin
			`uvm_error(get_type_name(), "Cannot fetch virtual interface");
		end
	endfunction

	task monitor();
		`uvm_info(get_type_name(), $sformatf("Monitor => rst = %0b | dot_inp = %0b | dash_inp = %0b | char_space_inp = %0b | word_space_inp = %0b", vif.mon_cb.rst, vif.mon_cb.dot_inp, vif.mon_cb.dash_inp, vif.mon_cb.char_space_inp, vif.mon_cb.word_space_inp), UVM_HIGH);
		req.rst = vif.mon_cb.rst;
		req.dot_inp = vif.mon_cb.dot_inp;
		req.dash_inp = vif.mon_cb.dash_inp;
		req.char_space_inp = vif.mon_cb.char_space_inp;
		req.word_space_inp = vif.mon_cb.word_space_inp;
		item_collect_active_mon.write(req);
	endtask

	task run_phase(uvm_phase phase);
		forever begin
			monitor();
		end
	endtask
endclass

class passive_monitor extends uvm_monitor;
	`uvm_component_utils(passive_monitor)
	seq_item req;
	virtual mor_inf vif;
	uvm_analysis_port #(seq_item) item_collect_p_mon;
	function new(string name = "passive_monitor", uvm_component parent = null);
		super.new(name, parent);
		item_collect_p_mon = new("icpm");
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		req = seq_item::type_id::create("req");
		if(uvm_config_db#(virtual mor_inf)::get(this, "", "vif", vif))begin
			`uvm_error(get_type_name(), "Cannot fetch virtual interface");
		end
	endfunction
	
	task monitor();
		`uvm_info(get_type_name(), $sformatf("sout = %0d", vif.sout), UVM_HIGH);
		req.sout = vif.sout;
		item_collect_p_mon.write(req);
	endtask	

	task run_phase(uvm_phase phase);
		super.run_phase(phase);
		forever begin
			monitor();
		end
	endtask
endclass
