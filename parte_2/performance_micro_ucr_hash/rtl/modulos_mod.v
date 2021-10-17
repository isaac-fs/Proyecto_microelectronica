// ----------------------------------------------------------------------------------------------------------//
/*                                  Bloque para optimizar desempeño                                          */  
// ----------------------------------------------------------------------------------------------------------//
module cargar_datos_mod #(
    parameter NUM_BLOQUES_PARALELOS = 4 // 4 bloques por defecto
)(
    input clk,
    input [95:0] bloque_datos, // 96 bits son 12 bytes
    input inicio, // similar a un reset
    input [31:0] nonce_inicial,
    output reg [127:0] bloque// El bloque es de 16 bytes
    ); 

    reg [31:0] nonce; // El nonce es un array con profundidad 4 con palabras de 8 bits

    always @(posedge clk)  begin
        if(~inicio) begin
            nonce <= nonce_inicial;
        end
        else begin
            if(nonce < 'hff_ff_ff_ff - NUM_BLOQUES_PARALELOS)
                nonce <= nonce + NUM_BLOQUES_PARALELOS;
        end
    end

    always @(*) begin
        bloque[0 +: 32] = nonce;
        bloque[32 +: 128] = bloque_datos;
    end
        
        
    
endmodule

// ----------------------------------------------------------------------------------------------------------//

module control_bounty #(
    parameter NUM_BLOQUES_PARALELOS = 4 // 4 bloques por defecto
)(
    input clk,
    input inicio,
    input [24*NUM_BLOQUES_PARALELOS - 1:0] bounty, // Cada bounty tiene 24 bits
    input [NUM_BLOQUES_PARALELOS-1:0] terminado, // Vector de entrada
    output reg [23:0] bounty_out, // salida
    output reg terminado_out);
    
    integer i;

    always @(*) begin
        
        bounty_out = 0;
        terminado_out = 0;
    
        for(i = 0; i < NUM_BLOQUES_PARALELOS; i = i+1) begin
            if(terminado[i] == 1) begin
                terminado_out = 1;
                bounty_out = bounty[i*24 +: 24]; //
            end
        end
        
    end
endmodule

// ----------------------------------------------------------------------------------------------------------//