`timescale 1ns / 1ps

module tb();
    integer file = 0;
    integer i = 0;

    reg [6: 0] mem[51: 0];
    reg [6: 0] arr1[25: 0];
    reg [6: 0] arr2[25: 0];

    initial begin
        /// open a file
        file = $fopen("H:/Xilinx/PROJECTS/file_write/file_write.srcs/sim_1/imports/Desktop/data.txt","w");
        // location & type of operation

        /// write operation
        for (i = 0; i < 25; i = i + 1) begin
            $fdisplay(file, "%x\t %x\t", i, 5*i);
            // file_id & format_spec & src_of_data
            // %x (hexadecimal) %b (binary)
        end

        /// close file
        $fclose(file);

        ///////////////////////////////////////////////
        /// open a file
        file = $fopen("H:/Xilinx/PROJECTS/file_write/file_write.srcs/sim_1/imports/Desktop/data.txt","r");
        // location & type of operation

        /// read operation
        $readmemh("H:/Xilinx/PROJECTS/file_write/file_write.srcs/sim_1/imports/Desktop/data.txt", mem);
        // location & array
        //$readmemb(); read binary file

        /// close file
        $fclose(file);

        for (i = 0; i < 25; i = i + 1) begin
            arr1[i] = mem[2 * i] ; /// 0, 2, 4, 6, 8 ...
            arr2[i] = mem[2 * i + 1] ; /// 1, 3, 5, 7, 9 ...
        end
        
        for (i = 0; i < 25; i = i + 1) begin
            $display("%0d\t %d", arr1[i], arr2[i]); 
        end
    end
endmodule
