`include "rtl/modulos.v"
module micro_ucr_hash (
    input clk,
    input [95:0] bloque_datos, // 96 bits son 12 bytes
    input inicio, // similar a un reset
    input [7:0] target,
    output [123:0] bounty,
    output terminado);

    /*AUTOWIRE*/
    // Beginning of automatic wires (for undeclared instantiated-module outputs)
    wire [23:0]		H;			// From algo_hash_0 of algo_hash.v
    wire [255:0]	W;			// From generar_W_0 of generar_W.v
    wire [127:0]	bloque;			// From cargar_datos_0 of cargar_datos.v
    // End of automatics

    cargar_datos cargar_datos_0(/*AUTOINST*/
				// Outputs
				.bloque		(bloque[127:0]),
				// Inputs
				.clk		(clk),
				.bloque_datos	(bloque_datos[95:0]),
				.inicio		(inicio));

    generar_W generar_W_0(/*AUTOINST*/
			  // Outputs
			  .W			(W[255:0]),
			  // Inputs
			  .bloque		(bloque[127:0]));

    algo_hash algo_hash_0(/*AUTOINST*/
			  // Outputs
			  .H			(H[23:0]),
			  // Inputs
			  .W			(W[255:0]));

    comparador_target_hash comparador_target_hash_0(/*AUTOINST*/
						    // Outputs
						    .bounty		(bounty[23:0]),
						    .terminado		(terminado),
						    // Inputs
						    .H			(H[23:0]),
						    .target		(target[7:0]));

endmodule
// Local Variables:
// verilog-library-files:("modulos.v")
// End:
