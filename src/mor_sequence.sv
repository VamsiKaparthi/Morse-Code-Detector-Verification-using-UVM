class rst_seq extends uvm_sequence;
	`uvm_object_utils(rst_seq)
	function new(string name = "rst_seq");
		super.new(name);
	endfunction
	seq_item req;
	task body();
		repeat(N)begin
			wait_for_grant();
			req = seq_item::type_id::create("req");
			req.randomize with {req.rst == 1;}
			send_request(req);
			wait_for_item_done();
		end
	endtask
endclass

class
