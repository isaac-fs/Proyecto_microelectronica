import numpy as np

def cargar_datos(bloque, inicio, nonce):
    '''
    Esta es una función que carga las primeras posiciones de W con el bloque y el nonce.
    Recibe un bloque de datos, un nonce inicial y una condición de inicio.
    '''
    # Secuencia de inicio
    if (inicio == False):
        print("Esperando inicio")
        exit(0)
    else:
        W_l = np.concatenate((nonce, bloque[::-1])).reshape((16))
    
    '''
    Esta sección revisa las posiciones del nonce para ir probando
    nuevos nonce en orden. Se truncan a byte con & 0xFF
    '''
    if (nonce[3] != 0xFF):
        nonce[0] = nonce[0]+1 & 0xFF
        if (nonce[0] == 0x00):
            nonce[1] = nonce[1]+1 & 0xFF
        if (nonce[0] == 0x00 and nonce[1] == 0x00):
            nonce[2] = nonce[2]+1 & 0xFF
        if (nonce[0] == 0x00 and nonce[1] == 0x00 and nonce[2] == 0x00):
            nonce[3] = nonce[2]+1 & 0xFF
    
    return W_l, nonce

def generar_W(W_l):
    '''
    Una vez que se cargaron los datos con cargar_datos, se puede generar W. 
    Para esto sigue una logica establecida y retorna W.
    '''
    W = W_l
    
    # Generar W a partir de W_l
    for i in range(16,32): # hasta 32 para que tome en cuenta el 31
        value = W[i-3] | W[i-9] ^ W[i-14]
        W = np.append(W, value)

    return W 

def algoritmo_hashing(W):
    '''
    Esta es una función que recibe W ya lleno y luego comienza el proceso de calcular los hashes 
    para el bloque con el nonce dado. Retorna el hash.
    '''
    H = [0x01, 0x89, 0xFE]
    a = H[0] & 0xFF
    b = H[1] & 0xFF
    c = H[2] & 0xFF

    for i in range(0,32):
        if( i >= 0 and i <= 16):
            k = 0x99 
            x = (a ^ b) & 0xFF

        if( i >= 17 and i <= 31):
            k = 0xa1
            x = (a | b) & 0xFF

        a = (b ^ c) & 0xFF
        b = (c << 4) & 0xFF
        c = (x + k + W[i]) & 0xFF
        #print('c', c) # para debugging
    H[0] = (H[0] + a) & 0xFF
    H[1] = (H[1] + b) & 0xFF 
    H[2] = (H[2] + c) & 0xFF

    return H

def comparador_target_hash(H,target):
    '''
    Una vez calculado el hash esta función se encarga de comparar el hash
    con el target y decide si el proceso ya se terminó o hay que ir a
    dar un nuevo nonce para continuar probando. 
    Siempre retorna un valor en bounty, pero este no es valido a menos
    que se haya terminado.
    '''
    target = target
    bounty = H
    if(H[1] < target and H[2] < target):
        terminado = True
    else:
        terminado = False

    return bounty, terminado

def hex_str(int_list):
        '''
        Una pequeña función para pasar rápidamente a hex una lista de ints a la hora de imprimir
        '''
        hex_list = '[{}]'.format(', '.join(hex(x) for x in int_list))
        return hex_list

def sistema(bloque, inicio, target):
    '''
    Esta función usa los todos los bloques para poder ejecutar el algoritmo que describe
    a micro_ucr_hash. 
    Tiene como entradas primarias un bloque de datos de 12 B y una condición de inicio.
    Como entrada secundaria tiene un target y como salida principal tiene un bounty.
    '''
    terminado = False
    nonce = [0x00, 0x00, 0x00, 0x00]
    
    contador = 0; # Contar número de iteraciones
    
    while(terminado == False):
        # Generador de nonce 
        W_l, nonce = cargar_datos(bloque, inicio, nonce) 
        setattr(sistema, 'W_l', W_l[::-1]) # Para poder recuperar el input desde el main
        W = generar_W(W_l)
        print("Input: ", hex_str(W_l[::-1]))
        #print("W: ", hex_str(W)) # para debugging
		
        H = algoritmo_hashing(W)
        
        print("Hash: ", hex_str(H[::-1]))
        print("\n")

        bounty, terminado = comparador_target_hash(H, target)
        
        contador += 1
  
        if(nonce == [255, 255, 255, 255]): 
            '''
            Esto me pareció importante agregarlo para que el sistema pueda terminar si ya recorrió todos los
            posibles nonce.
            '''
            print("Se probaron todos los nonce, pero no se encontró bounty. Intente con un target mayor\n.")
            break

        elif(terminado == True):
            break
    
    return terminado, bounty[::-1], contador
