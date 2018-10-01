/* Project at NTNU for Nordic Semiconductor AS
* 
*  Author: Steinar Thune Christensen
*/
module FCNN #(
	parameter NoLayers = 3,
	parameter dataWidth
	)(
	input logic clk,
	input logic rst,
	input logic enable,
	input logic [29:0][783:0][dataWidth-1:0] 	w0,
	input logic [9:0][29:0][dataWidth-1:0] 		w1,
	input logic [29:0][dataWidth-1:0] 			b0,
	input logic [9:0][dataWidth-1:0] 			b1,
	input logic [783:0][dataWidth-1:0] 			iData,
	output logic [9:0][dataWidth-1:0] 			oData	
	);
	
	//Weights are stored in two arrays, w0 one from input to hiddenLayer0
	//Which gives the form 30x784. w1 is of the form 10x30.	

	logic [29:0][dataWidth-1:0] a0;
	logic [9:0][dataWidth-1:0] a1;
	logic [29:0][dataWidth-1:0] unweightedActivation;

	//Modules in "chronological" order
	MatrixMult #(
		.dataWidth(dataWidth),
		.NsInPrevLayer(784),
		.NsInNextLayer(30)
	) matrixMult0 (
		.clk(clk),
		.rst(rst),
		.enable(enable),
		.inputWeights(w0),
		.inputActivation(iData),
		.outputActivation(a0));

	NeuronLayer #(
		.NoNeurons(30), 
		.dataWidth(dataWidth)
	) hiddenLayer0 (
		.clk(clk),
		.rst(rst),
		.enable(enable),
		.biases(b0),
		.iData(a0),
		.oData(unweightedActivation));

	MatrixMult #(
		.dataWidth(dataWidth),
		.NsInPrevLayer(30),
		.NsInNextLayer(10)
	) matrixMult1 (
		.clk(clk),
		.rst(rst),
		.enable(enable),
		.inputWeights(w1),
		.inputActivation(unweightedActivation),
		.outputActivation(a1));

	NeuronLayer #(
		.NoNeurons(10), 
		.dataWidth(dataWidth) 
	) outputLayer (
		.clk(clk),
		.rst(rst),
		.enable(enable),
		.biases(b1),
		.iData(a1), 
		.oData(oData));
	
endmodule