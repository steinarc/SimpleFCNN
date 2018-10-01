/* Project NTNU/Nordic Semiconductor AS
* 
*  Author: Steinar Thune Christensen
*/
module FCNN #(
	parameter NoLayers = 3,
	parameter dataWidth = 8
	)(
	input logic clk,
	input logic rst,
	input logic enable,
	input logic [783:0] w0 [29:0],
	input logic [9:0] w1 [29:0],
	input logic b0 [29:0],
	input logic b1 [9:0],
	input logic [dataWidth-1:0] iData [783:0],
	output logic [dataWidth-1:0] oData [9:0]	
	);
	
	//Weights are stored in two arrays, w0 one from input to hiddenLayer0
	//Which gives the form 30x784. w1 is of the form 10x30.	

	logic a0 [29:0];
	logic a1 [9:0];
	logic rawOutput [29:0];

	//Modules in "chronological" order
	MatrixMult #(
		.dataWidth(dataWidth),
		.NsInPrevLayer(784),
		.NsInNextLayer(30)
	) matrixMult0 (
		.clk(clk),
		.rst(rst),
		.inputWeights(w0),
		.inputActivation(iData),
		.outputActivation(a0)
		);

	NeuronLayer #(
		.NoNeurons(30), 
		.dataWidth(dataWidth)
	) hiddenLayer0 (
		.clk(clk),
		.rst(rst),
		.biases(b0),
		.iData(a0), 
		.oData(rawOutput));

	MatrixMult #(
		.dataWidth(dataWidth),
		.NsInPrevLayer(30),
		.NsInNextLayer(10)
	) matrixMult1 (
		.clk(clk),
		.rst(rst),
		.inputWeights(w1),
		.inputActivation(rawOutput),
		.outputActivation(a1)
		);

	NeuronLayer #(
		.NoNeurons(10), 
		.dataWidth(dataWidth) 
	) outputLayer (
		.clk(clk),
		.rst(rst),
		.biases(b1),
		.iData(a1), 
		.oData(oData));
	
endmodule