interface mor_inf(input bit clk);
	//Inputs to DUT
	logic rst, dot_inp, dash_inp, char_space_inp, word_space_inp;
	//Output from DUT
	logic sout;

	clocking drv_cb@(posedge clk);
		default input #0 output #0;
		output rst, dot_inp, dash_inp, char_space_inp, word_space_inp;
	endclocking

	clocking active_mon_cb@(posedge clk);
		default input #0 output #0;
		input rst, dot_inp, dash_inp, char_space_inp, word_space_inp;
	endclocking

	clocking passive_mon_cb@(posedge clk);
		default input #0 output #0;
		input sout;
	endclocking

endinterface
