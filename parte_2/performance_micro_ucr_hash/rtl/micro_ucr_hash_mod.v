`include "rtl/modulos.v"
`include "rtl/modulos_mod.v"
// ----------------------------------------------------------------------------------------------------------//
module micro_ucr_hash_mod_module #(
    parameter NUM_BLOQUES_PARALELOS = 4 // 4 bloques por defecto
)(
    input clk,
    input [95:0] bloque_datos, // 96 bits son 12 bytes
    input inicio, // similar a un reset
	input [31:0] nonce_inicial,
    input [7:0] target,
    output [23:0] bounty,
    output terminado);

	wire [23:0]		H;
    wire [255:0]	W;
    wire [127:0]	bloque;

    cargar_datos_mod #(
    	.NUM_BLOQUES_PARALELOS (NUM_BLOQUES_PARALELOS)
	) cargar_datos_mod_0( 
			// Outputs
			.bloque		(bloque[127:0]),
			// Inputs
			.clk		(clk),
			.bloque_datos	(bloque_datos[95:0]),
			.inicio		(inicio),
			.nonce_inicial	(nonce_inicial[31:0]));

    generar_W generar_W_0( 
			// Outputs
			.W			(W[255:0]),
			// Inputs
			.bloque		(bloque[127:0]));

    algo_hash algo_hash_0( 
			// Outputs
			.H			(H[23:0]),
			// Inputs
			.W			(W[255:0]));


    comparador_target_hash comparador_target_hash_0(
			// Outputs
			.bounty		(bounty[23:0]),
			.terminado		(terminado),
			// Inputs
			.H			(H[23:0]),
			.target		(target[7:0]));

endmodule
// ----------------------------------------------------------------------------------------------------------//

module micro_ucr_hash_mod #(
    parameter NUM_BLOQUES_PARALELOS = 4 // 4 bloques por defecto
)(
    input clk,
    input [95:0] bloque_datos, // 96 bits son 12 bytes
    input inicio, // similar a un reset
	input [32*NUM_BLOQUES_PARALELOS-1:0] nonce_iniciales,
    input [7:0] target,
    output [23:0] bounty_out,
    output terminado_out);
/*..............................................................................................................*/	
	wire [24*NUM_BLOQUES_PARALELOS-1:0]		bounty;
	wire [NUM_BLOQUES_PARALELOS-1:0] 	    terminado;
	wire [23:0] H_0, H_1, H_2, H_3;
/*..............................................................................................................*/	
	micro_ucr_hash_mod_module #(
    .NUM_BLOQUES_PARALELOS (NUM_BLOQUES_PARALELOS)
) module_0(
	   // Outputs
	   .bounty			(bounty[0+:24]),
	   .terminado			(terminado[0]),
	   // Inputs
	   .clk				(clk),
	   .bloque_datos		(bloque_datos[95:0]),
	   .inicio			(inicio),
	   .nonce_inicial		(nonce_iniciales[0+:32]),
	   .target			(target[7:0]));
/*..............................................................................................................*/
	micro_ucr_hash_mod_module #(
    .NUM_BLOQUES_PARALELOS (NUM_BLOQUES_PARALELOS)
) module_1(
	   // Outputs
	   .bounty			(bounty[24+:24]),
	   .terminado			(terminado[1]),
	   // Inputs
	   .clk				(clk),
	   .bloque_datos		(bloque_datos[95:0]),
	   .inicio			(inicio),
	   .nonce_inicial		(nonce_iniciales[32+:32]),
	   .target			(target[7:0]));
/*..............................................................................................................*/	
	micro_ucr_hash_mod_module #(
    .NUM_BLOQUES_PARALELOS (NUM_BLOQUES_PARALELOS)
) module_2(
	   // Outputs
	   .bounty			(bounty[48+:24]),
	   .terminado			(terminado[2]),
	   // Inputs
	   .clk				(clk),
	   .bloque_datos		(bloque_datos[95:0]),
	   .inicio			(inicio),
	   .nonce_inicial		(nonce_iniciales[64+:32]),
	   .target			(target[7:0]));
/*..............................................................................................................*/	
	micro_ucr_hash_mod_module #(
    .NUM_BLOQUES_PARALELOS (NUM_BLOQUES_PARALELOS)
) module_3(
	   // Outputs
	   .bounty			(bounty[72+:24]),
	   .terminado			(terminado[3]),
	   // Inputs
	   .clk				(clk),
	   .bloque_datos		(bloque_datos[95:0]),
	   .inicio			(inicio),
	   .nonce_inicial		(nonce_iniciales[96+:32]),
	   .target			(target[7:0]));
/*..............................................................................................................*/	
	control_bounty #(
    .NUM_BLOQUES_PARALELOS (NUM_BLOQUES_PARALELOS)
) control_bounty_0(
		   // Outputs
		   .bounty_out		(bounty_out[23:0]),
		   .terminado_out	(terminado_out),
		   // Inputs
		   .clk			(clk),
		   .inicio		(inicio),
		   .bounty		(bounty[24*NUM_BLOQUES_PARALELOS-1:0]),
		   .terminado		(terminado[NUM_BLOQUES_PARALELOS-1:0]));
/*..............................................................................................................*/
endmodule
// Local Variables:
// verilog-library-files:("modulos.v" "modulos_mod.v")
// End:
