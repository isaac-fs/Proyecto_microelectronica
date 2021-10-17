`include "rtl/micro_ucr_hash_mod.v"
`include "testbench/probador.v"

`timescale 	1ns/100ps // escala	unidad temporal (valor de "#1") / precisión

module testbench; // Testbench

	parameter NUM_BLOQUES_PARALELOS = 4; // 4 bloques por defecto

	/*AUTOWIRE*/
	// Beginning of automatic wires (for undeclared instantiated-module outputs)
	wire [95:0]	bloque_datos;		// From probador_0 of probador.v
	wire [23:0]	bounty_out;		// From micro_ucr_hash_mod_0 of micro_ucr_hash_mod.v
	wire		clk;			// From probador_0 of probador.v
	wire		inicio;			// From probador_0 of probador.v
	wire [32*NUM_BLOQUES_PARALELOS-1:0] nonce_iniciales;// From probador_0 of probador.v
	wire [7:0]	target;			// From probador_0 of probador.v
	wire		terminado_out;		// From micro_ucr_hash_mod_0 of micro_ucr_hash_mod.v
	// End of automatics


	// Descripción conductual
	micro_ucr_hash_mod micro_ucr_hash_mod_0 (	
		/*AUTOINST*/
						 // Outputs
						 .bounty_out		(bounty_out[23:0]),
						 .terminado_out		(terminado_out),
						 // Inputs
						 .clk			(clk),
						 .bloque_datos		(bloque_datos[95:0]),
						 .inicio		(inicio),
						 .nonce_iniciales	(nonce_iniciales[32*NUM_BLOQUES_PARALELOS-1:0]),
						 .target		(target[7:0]));

	// Probador: generador de señales y monitor
	probador probador_0(
		/*AUTOINST*/
			    // Outputs
			    .clk		(clk),
			    .bloque_datos	(bloque_datos[95:0]),
			    .inicio		(inicio),
			    .nonce_iniciales	(nonce_iniciales[32*NUM_BLOQUES_PARALELOS-1:0]),
			    .target		(target[7:0]),
			    // Inputs
			    .bounty_out		(bounty_out[23:0]),
			    .terminado_out	(terminado_out));
endmodule

// Local Variables:
// verilog-library-directories:("." "../rtl/" "../synthesis")
// End:
