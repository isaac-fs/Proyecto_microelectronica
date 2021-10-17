import time
import micro_ucr_hash as hsh

# Datos iniciales
bloque = [0x39, 0x7d, 0x9f, 0x2f, 0x40, 0xca, 0x9e, 0x6c, 0x6b, 0x1f, 0x33, 0x24] # N: 0xfd 0xed 0x87 0x3c / B: 0xf1 0x89 0x73
target = 0x0a
terminado = False
inicio = True
nonce = [0x0, 0x0, 0x0, 0x0]

# Sistema
terminado, bounty, contador = hsh.sistema(bloque,inicio,target)

 # Resultados
start_time = time.time() # Función para contar el tiempo de ejecución

if(terminado == True):
    print("Se ha encontrado un bounty!")
    print("Input: ", hsh.hex_str(hsh.sistema.W_l))
    print("Target: ", hex(target))
    print("Hash: ",hsh.hex_str(bounty))
    print("Número de iteraciones: ", contador)
    print("Tiempo de ejecución: {:f} microsegundos\n".format((time.time() - start_time)*10**6))

print("Segunda prueba: Prueba de inicio = False")
terminado = False
inicio = False
print("Resultado:")
hsh.sistema(bloque,inicio,target)




    
