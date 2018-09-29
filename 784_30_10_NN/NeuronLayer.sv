module #(
	parameter dataWidth = 8,
	parameter 
	) NeuronLayer (
	input logic clk,
	input logic rst,
	input logic enable,
	input logic [dataWidth-1:0] iData [],
	output logic [dataWidth-1:0] oData []
	);
	
endmodule