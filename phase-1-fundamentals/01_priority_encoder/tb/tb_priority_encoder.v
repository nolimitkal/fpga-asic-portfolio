`timescale 1ns/1ps

module tb_priority_encoder;

    reg  [3:0] req;           // driven by the testbench, so reg
    wire [1:0] idx;           // driven by the DUT, so wire
    wire       valid;

    reg  [1:0] exp_idx;       // expected values from our independent model
    reg        exp_valid;

    integer i;                // loop over all input combinations
    integer j;                // loop inside the reference model
    integer errors;

    // Device Under Test
    priority_encoder dut (
        .req   (req),
        .idx   (idx),
        .valid (valid)
    );

    initial begin
        $dumpfile("sim/dump.vcd");
        $dumpvars(0, tb_priority_encoder);

        errors = 0;

        for (i = 0; i < 16; i = i + 1) begin
            req = i;          // apply one of the 16 combinations
            #10;              // let the combinational logic settle

            // Reference model: scan from bit 0 up to bit 3.
            // Later (higher) set bits overwrite earlier ones, so the
            // highest set bit wins. A different method than the RTL,
            // so a shared mistake is unlikely.
            exp_idx   = 2'b00;
            exp_valid = 1'b0;
            for (j = 0; j < 4; j = j + 1) begin
                if (req[j]) begin
                    exp_idx   = j;
                    exp_valid = 1'b1;
                end
            end

            // !== also catches x and z, which plain != would let through
            if (idx !== exp_idx || valid !== exp_valid) begin
                $display("FAIL: req=%b idx=%b (exp %b) valid=%b (exp %b)",
                         req, idx, exp_idx, valid, exp_valid);
                errors = errors + 1;
            end else begin
                $display("PASS: req=%b idx=%b valid=%b", req, idx, valid);
            end
        end

        if (errors == 0)
            $display("ALL 16 TESTS PASSED");
        else
            $display("%0d TESTS FAILED", errors);

        $finish;
    end

endmodule