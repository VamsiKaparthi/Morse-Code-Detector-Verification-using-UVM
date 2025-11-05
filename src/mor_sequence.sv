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
			assert(req.randomize with {req.rst == 1;});
			send_request(req);
			wait_for_item_done();
		end
	endtask
endclass


string morse_table[string] = {
	"A" : ".-",
	"B" : "-...",
	"C" : "-.-.",
	"D" : "-..",
	"E" : ".",
	"F" : "..-.",
	"G" : "--.",
	"H" : "....",
	"I" : "..",
	"J" : ".---",
	"K" : "-.-",
	"L" : ".-..",
	"M" : "--",
	"N" : "-.",
	"O" : "---",
	"P" : ".--.",
	"Q" : "--.-",
	"R" : ".-.",
	"S" : "...",
	"T" : "-",
	"U" : "..-",
	"V" : "...-",
	"W" : ".--",
	"X" : "-..-",
	"Y" : "-.--",
	"Z" : "--..",
	"1" : ".----",
	"2" : "..---",
	"3" : "...--",
	"4" : "....-",
	"5" : ".....",
	"6" : "-....",
	"7" : "--...",
	"8" : "---..",
	"9" : "----.",
	"0" : "-----"
};



class single_char_test extends uvm_sequence;
	`uvm_object_utils(single_char_test)
	function new(string name = "single_char_test");
		super.new(name);
	endfunction
	seq_item req;
	task body();
		foreach(morse_table[i])begin
			wait_for_grant();
			req = seq_item::type_id::create("req");
			req.rst = 0;
			foreach(morse_table[i][j])begin
				if(morse_table[i][j] == ".")begin
					req.dot_inp = 1;
					req.dash_inp = 0;
				end
				if(morse_table[i][j] == "-")begin
					req.dot_inp = 0;
					req.dash_inp = 1;
				end
			end
		end
	endtask
endclass
