class driver extends uvm_driver;
	`uvm_component_utils(driver)
	uvm_analysis_port #(seq_item) item_collect_drv;
	virtual mor_inf vif;
	function new(string name = "driver", uvm_component parent = null);
		super.new(name, parent);
	endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if(!uvm_config_db#(virtual mor_inf)::get(this, "", "vif", vif))begin
			`uvm_error(get_type(), "Could not fetch virtual interface");
		end
	endfunction

	task drive();
		`uvm_info(get_type(), $sformatf("DRIVE => rst = %0b | dot_inp = %0b | dash_inp = %0b | char_space_inp = %0b | word_space_inp = %0b", req.rst, req.dot_inp, req.dash_inp, req.char_space_inp, req.word_space_inp), UVM_HIGH);
		vif.drv_cb.rst <= req.rst;
		vif.drv_cb.dot_inp <= req.dot_inp;
		vif.drv_cb.dash_inp <= req.dash_inp;
		vif.drv_cb.char_space_inp <= req.char_space_inp;
		vif.drv_cb.word_space_inp <= req.word_space_inp;
		item_collect_drv.write(req);
	endtask
	
	task run_phase(uvm_phase phase);
		forever begin
			seq_item_port.get_next_item(req);
			drive();
			seq_item_port.item_done();
		end
	endtask
endclass
