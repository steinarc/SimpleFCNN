module Sigmoid #(
	parameter dataWidth
	)(
	input logic clk,
	input logic rst,
	input logic enable,
	input logic signed [NoNeurons-1:0][dataWidth-1:0] biases,
	input logic signed [NoNeurons-1:0][dataWidth-1:0] iData,
	output logic signed [NoNeurons-1:0][dataWidth-1:0] oData
	);
	
	logic [NoNeurons-1:0][dataWidth-1:0] unsquashedData;
	
	always_ff @(posedge clk)
		for (int i = 0; i < NoNeurons; i++)
			unsquashedData[i] <= biases[i] + iData[i];

	Sigmoid #(
		.dataWidth(dataWidth)
	)sigmoid(
		.clk(clk),
		.rst(rst),
		.enable(enable),
		.iData(unsquashedData),
		.oData(oData));

endmodule