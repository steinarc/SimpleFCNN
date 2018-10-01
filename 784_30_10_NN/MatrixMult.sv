//====================================================================
//        Copyright (c) 2018 Nordic Semiconductor ASA, Norway
//====================================================================
// Created       : stch at 2018-10-01
// Modified      : $Author$ $Date$
// Version       : $Revision$ $HeadURL$
//====================================================================

// This should contain a very brief description of what this IP does.
//
// You can have multiple lines, but there should not be too many.
// Make sure there is ONE empty line after the copyright header
//
// Please replace all of this text TODO
// The following lines contain metadata for the IP:
//
// type: <Type of the IP> TODO  [required field]
// owner: <username of the IP owner> TODO
// pcgc_masters: <number_of_PCGC_masters> TODO
// pcgc_slaves: <number_of_PCGC_slaves> TODO
// ppi: <no or yes> TODO
// easydma: <no or yes> TODO
// clock_frequency: <frequency_in_mhz> MHz TODO


module MatrixMult #(
	parameter dataWidth,
	parameter NsInPrevLayer,
	parameter NsInNextLayer
	)(
	input logic clk,
	input logic rst,
	input logic enable,
	input logic signed [NsInNextLayer-1:0][NsInPrevLayer-1:0][dataWidth-1:0] inputWeights,
	input logic signed [NsInPrevLayer-1:0][dataWidth-1:0] inputActivation,
	output logic signed [NsInNextLayer-1:0][dataWidth-1:0] outputActivation
	);
	
	logic signed [NsInPrevLayer-1:0][NsInNextLayer-1:0][dataWidth-1:0] outputActivation2D
	
	logic [dataWidth-1:0] temp;

	always_comb begin
		for (int i = 0; i < NsInNextLayer; i++) begin
			for (int j = 0; j < NsInPrevLayer; j++) begin
				outputActivation[i] = outputActivation2D[i][j];
			end // Nå ble jeg litt forvirret ..... JObb mer på torsdag
		end
	end
	
	always_ff @(posedge clk) begin
		if (rst) begin
				outputActivation = '0;
		end
		else if (enable) begin
				for (int i = 0; j < NsInPrevLayer; j++) begin
					for () begin
						outputActivation2D[0][0] <=  inputWeights[0][0] * inputActivation[0];
						outputActivation2D[0]]1] <= inputWeights[0][1] * inputActivation[1];
					
					end	
				end
		end
	end

endmodule
