module priority_encoder (
    input wire [3:0] req,   // 3 request lines, req[3:0] has highest priority
    output reg [1:0] idx,   // index of the winning request
    output reg valid        // 1 when at least one request is active
);

    always @(*) begin
        // Default values: gurantee every output is assigned on every path.
        // Without these two lines, the paths taht match no branch would leave
        // the outputs unassigned and synthesis would infer latches.

        idx = 2'b00;
        valid = 1'b0;


        // Checked top to bottom: the first true condition wins. 
        // That ordering IS the priority. 
        if (req[3]) begin
            idx = 2'b11;
            valid = 1'b1;
        end else if (req[2]) begin
            idx = 2'b10;
            valid = 1'b1;
        end else if (req[1]) begin
            idx = 2'b01;
            valid = 1'b1;
        end else if (req[0]) begin
            idx = 2'b00;
            valid = 1'b1;
        end
    end

endmodule