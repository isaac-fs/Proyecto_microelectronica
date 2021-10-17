// ----------------------------------------------------------------------------------------------------------//
/*                                  Bloques generales y para desempeño                                       */                   
// ----------------------------------------------------------------------------------------------------------//
module cargar_datos (
    input clk,
    input [95:0] bloque_datos, // 96 bits son 12 bytes
    input inicio, // similar a un reset
    output reg [127:0] bloque // El bloque es de 16 bytes
    ); 

    reg [31:0] nonce; // El nonce es un array con profundidad 4 con palabras de 8 bits

    always @(posedge clk) begin
        if(~inicio) begin
            nonce <= 0; // Nonce inicial        
        end
        else begin
           if(nonce < 'hff_ff_ff_ff)
                nonce <= nonce + 1;
        end
    end

    always @(*) begin
        bloque[0 +: 32] = nonce;
        bloque[32 +: 128] = bloque_datos;
    end
endmodule

// ----------------------------------------------------------------------------------------------------------//
module generar_W (
    input [127:0] bloque, // Entrada 
    output reg [255:0] W); // Salida es el bloque con las operaciones

    integer i;
    always @(*) begin
        for (i = 0; i < 16; i = i+1) // Llenar el resto de W
            W[i*8 +: 8] = bloque[i*8 +: 8]; // Llena W comenzando en 0 y va hasta el bit 128 
            
        for (i = 16; i < 32; i = i+1) // Llenar el resto de W
            W[i*8 +: 8] = W[(i-3)*8 +: 8] | W[(i-9)*8 +: 8] ^ W[(i-14)*8 +: 8];
        
    end
endmodule
// ----------------------------------------------------------------------------------------------------------//

module algo_hash (
    input [255:0] W,
    output reg [23:0] H); // hash propuesto para verificar - 24 bits = 8 bits, 8 bits, 8 bits,

    integer i;
    reg [7:0] a, b, c, k, x_;
    reg [23:0] H_int;

    always @(*) begin
        H_int[0+:8] <= 'h01;
        H_int[8+:8] <= 'h89;
        H_int[16+:8] <= 'hFE;
        a = H_int[0+:8];
        b = H_int[8+:8];
        c = H_int[16+:8];
        i = 0;
        k = 0;
        x_ = 0;
        H = 0;

        for(i = 0; i < 32; i = i+1) begin
            if(i >= 0 && i <=16) begin
                k = 'h99;
                x_ = a ^ b;
            end
        
            else if(i >= 17 && i <= 31) begin
                k = 'hA1;
                x_ = a | b;
            end
            a = b ^ c;
            b = c << 4;
            c = x_ + k + W[i*8 +: 8];
        end

        H[0+:8] = H_int[0+:8] + a;
        H[8+:8] = H_int[8+:8] + b;
        H[16+:8] = H_int[16+:8] + c;
    end

endmodule
// ----------------------------------------------------------------------------------------------------------//

module comparador_target_hash (
    input [23:0] H,
    input [7:0] target,
    output reg [23:0] bounty,
    output reg terminado);
    
    integer i;
    always @(*) begin
            // valores por defecto
            bounty = 0;
            terminado = 0;

            if(H[8+:8] < target && H[16+:8] < target) begin // 
                terminado = 1;
                bounty = H;
            end 
            else begin
                terminado = 0;
                bounty = 0;
            end
    end
endmodule
// ----------------------------------------------------------------------------------------------------------//
