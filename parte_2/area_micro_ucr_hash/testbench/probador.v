module probador( 
	// Módulo probador: generador de señales y monitor de datos.
	// Entradas del monitor de datos
		// Condicional
		input [123:0] bounty,
    	input terminado,
		// Síntesis
    // Salidas del generador de señales
		output reg clk,
		output reg [95:0] bloque_datos, // 96 bits son 12 bytes
		output reg inicio, // similar a un reset
		output reg [7:0] target); 

	//checker
    integer check = 1;
    // always @(*) begin
	//check = 1;
    //     if (bounty[]) 
    //         check = 1;    
    //     else
    //         check = 0;    
    // end 

    // Reloj
	initial	clk <= 0;			// Valor inicial al reloj, sino siempre será indeterminado
	always #10 clk <= ~clk;		// Hace "toggle" cada 2*1ns

	// contador
	integer  contador;

	// Bloque de procedimiento, no sintetizable, se recorre una única vez.
	// Generalmente, los initial sólo se usan en los testbench o probadores.
	// Se recomienda siempre sincronizar con el reloj y utilizar asignaciones no bloqueantes en la generación de señales.
	initial begin
		$dumpfile("testbench/simulacion.vcd");	// Nombre de archivo del "dump"
		$dumpvars;              // Directiva para "dumpear" variables
		// Mensaje que se imprime en consola una vez
		//$display ("\t\ttime\tclk,\tcheck");
		// Mensaje que se imprime en consola cada vez que un elemento de la lista cambia
		//$monitor($time,"\t%b%d", clk, check);
        
        // Inicialización de datos
		/*
		echo "[0x39, 0x7d, 0x9f, 0x2f, 0x40, 0xca, 0x9e, 0x6c, 0x6b, 0x1f, 0x33, 0x24]" | sed s/0x/\'h/g
		*/
		bloque_datos = {8'h39, 8'h7d, 8'h9f, 8'h2f, 8'h40, 8'hca, 8'h9e, 8'h6c, 8'h6b, 8'h1f, 8'h33, 8'h24};
		inicio = 0;
		target = 'h0a;
		contador = 0;
		// Inicio de pruebas
		
		@(posedge clk); begin
			contador <= contador + 1;
			inicio <= 1;
		end

		repeat(15000) begin
			@(posedge clk) begin
				contador <= contador + 1;
			end
		end

		// Final de pruebas
		$finish; // Termina de almacenar señales
	end
endmodule
