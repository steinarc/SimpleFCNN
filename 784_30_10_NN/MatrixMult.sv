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


module MatrixMult2 #(
	parameter INCLUDE_MATRIXMULT2    = pa_MatrixMult2::INCLUDE_MATRIXMULT2,
	parameter dataWidth = 8,
	parameter NsInPrevLayer,
	parameter NsInNextLayer
	)(
	input logic clk,
	input logic rst,
	input logic enable,
	input logic [NsInNextLayer-1:0][NsInPrevLayer-1:0][dataWidth-1:0] inputWeights,
	input logic [NsInPrevLayer-1:0][dataWidth-1:0] inputActivation,
	output logic [NsInNextLayer-1:0][dataWidth-1:0] outputActivation
		
	);
	
	logic [dataWidth-1:0] temp;

  generate
    if (INCLUDE_MATRIXMULT2 == 1) begin : la_Include

		always_ff @(posedge clk) begin
			if (rst) begin
				for (int i = 0; i < NsInNextLayer; i++)
					outputActivation[i] <= {dataWidth{1'b0}};
			end
			else if (enable) begin
				for (int i = 0; i < NsInNextLayer; i++) begin // This is the multiplication itself
					temp = '0;
					for (int j = 0; j < NsInPrevLayer; j++) begin
						temp = temp + inputWeights[i][j] * inputActivation[j];
					end
					outputActivation[i] = temp;
				end	
			end
		end

    end
    else begin : la_LeaveOut

    end
  endgenerate

endmodule
