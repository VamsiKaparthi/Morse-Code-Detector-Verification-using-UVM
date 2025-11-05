class seq_item extends uvm_sequence_item;
	//Inputs
	rand logic rst;
	rand logic dot_inp, dash_inp, char_space_inp, word_space_inp;
	//Outputs
	logic sout;
	`uvm_object_utils_begin(seq_item)
	`uvm_field_int(rst, UVM_DEFAULT)
	`uvm_field_int(dot_inp, UVM_DEFAULT)
	`uvm_field_int(dash_inp, UVM_DEFAULT)
	`uvm_field_int(char_space_inp, UVM_DEFAULT)
	`uvm_field_int(word_space_inp, UVM_DEFAULT)
	`uvm_object_utils_end

	function new(string name = "seq_item");
		super.new(name);
	endfunction
	
endclass
