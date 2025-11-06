`include "mor_interface.sv"
`include "package.sv"
import pkg::*;
`include "uvm_macros.svh"
import uvm_pkg::*;

module top;
	bit clk;
	always #5 clk = ~clk;
	mor_inf vif(clk);
	initial begin
		uvm_config_db#(virtual mor_inf)::set(null, "*", "vif", vif);
		run_test("test");
		$finish;
	end
endmodule
