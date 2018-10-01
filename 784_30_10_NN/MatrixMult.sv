module MatrixMult  #(
	parameter dataWidth = 8,
	parameter NsInPrevLayer,
	parameter NsInNextLayer
	)(
	input logic clk,
	input logic rst,
	input logic enable,
	input logic [NsInPrevLayer-1:0] inputWeights [NsInNextLayer-1:0],
	input logic [dataWidth-1:0] inputActivation [NsInPrevLayer-1:0],
	output logic [dataWidth-1:0] outputActivation [NsInNextLayer-1:0]
		
	);
	
	always_ff @(posedge clk) begin
		if (rst) begin
			for (int i = 0; i < NsInNextLayer; i++)
				outputActivation[i] <= {dataWidth{1'b0}}; //Not sure if this works in SystemVerilog
		end
		else if (enable) begin
			for (int i = 0; i < NsInNextLayer; i++) begin // This is the multiplication itself, not sure about this accumulating approach, 	blocking/non-blocking assignment etc.
				for (int j = 0; j < NsInPrevLayer; j++) begin
					outputActivation[i] = outputActivation[i] + inputWeights[i][j] * inputActivation[j];
				end
			end	
		end
	end
	
endmodule