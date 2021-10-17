`include "rtl/micro_ucr_hash.v"
`include "testbench/probador.v"

`timescale 	1ns/100ps // escala	unidad temporal (valor de "#1") / precisión

module testbench; // Testbench


	/*AUTOWIRE*/
	// Beginning of automatic wires (for undeclared instantiated-module outputs)
	wire [95:0]	bloque_datos;		// From probador_0 of probador.v
	wire [123:0]	bounty;			// From micro_ucr_hash0 of micro_ucr_hash.v
	wire		clk;			// From probador_0 of probador.v
	wire		inicio;			// From probador_0 of probador.v
	wire [7:0]	target;			// From probador_0 of probador.v
	wire		terminado;		// From micro_ucr_hash0 of micro_ucr_hash.v
	// End of automatics


	// Descripción conductual
	micro_ucr_hash micro_ucr_hash0 (	
		/*AUTOINST*/
					// Outputs
					.bounty		(bounty[123:0]),
					.terminado	(terminado),
					// Inputs
					.clk		(clk),
					.bloque_datos	(bloque_datos[95:0]),
					.inicio		(inicio),
					.target		(target[7:0]));
	

	// Probador: generador de señales y monitor
	probador probador_0(
		/*AUTOINST*/
			    // Outputs
			    .clk		(clk),
			    .bloque_datos	(bloque_datos[95:0]),
			    .inicio		(inicio),
			    .target		(target[7:0]),
			    // Inputs
			    .bounty		(bounty[123:0]),
			    .terminado		(terminado));
endmodule

// Local Variables:
// verilog-library-directories:("." "../rtl/" "../synthesis")
// End:
