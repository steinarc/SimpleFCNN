module NeuronLayer #(
	parameter dataWidth,
	parameter NoNeurons
	)(
	input logic clk,
	input logic rst,
	input logic enable,
	input logic signed [NoNeurons-1:0][dataWidth-1:0] biases,
	input logic signed [NoNeurons-1:0][dataWidth-1:0] iData,
	output logic signed [NoNeurons-1:0][dataWidth-1:0] oData
	);
	
	logic [NoNeurons-1:0][dataWidth-1:0] unsquashedData;
	
	for (int i = 0; i < NoNeurons; i++)
		unsquashedData[i] <= biases[i] + iData[i];
	
	Sigmoid #(
	.dataWidth(dataWidth)
	)sigmoid(
	.iData(unsquashedData),
	.oData(oData)
	);
	
endmodule