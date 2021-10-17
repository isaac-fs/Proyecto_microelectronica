import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

#------------------------------------------------------------------------------------------------------------------------------
def cells_hm(file_coordenadas_celdas, xedges, yedges, unit_dist, img_sav_file_celdas):
    '''
    Esta función genera un mapa de calor de celdas basada en las posiciones de las celdas
    en el archivo .def
    '''
    coord_cells = pd.read_csv(file_coordenadas_celdas, sep='\t', header=0) # Cargar archivo en un dataf frame de pandas
    # Asignar coordenadas y dividir por factor de multiplicación
    x = coord_cells['x'].div(unit_dist)
    y = coord_cells['y'].div(unit_dist)
    
    # Generar figura
    plt.figure("Mapa de calor de celdas", dpi = 150)
    
    # Generar mapa de calor por medio de un histograma
    map_color = "inferno"
    heat_map, xedges, yedges, im = plt.hist2d(x, y, bins=(xedges, yedges), cmap = map_color)
    heat_map = heat_map.T

    plt.colorbar(im)
    plt.xlabel("x [um]")
    plt.ylabel("y [um]")
    plt.title("Densidad de celdas")
    plt.imshow(heat_map, interpolation='nearest', origin='lower', extent=[xedges[0], xedges[-1], yedges[0], yedges[-1]])
    plt.savefig(img_sav_file_celdas)
    plt.show()

#------------------------------------------------------------------------------------------------------------------------------
def nets_hm(file_coordenadas_nets, xedges, yedges, unit_dist, img_sav_file_nets):
    '''
    Esta función calcular un mapa de calor de densidad de nets por medio de las coordenadas de los puntos iniciales
    y finales de cada segmento de metal y los cuadrados que atraviesen estos segmentos.
    '''
    coord_nets = pd.read_csv(file_coordenadas_nets, sep='\t', header=0) # Cargar archivo en un dataf frame de pandas

    # Manejar datos 
    for row in coord_nets.itertuples(): # Itera todas las filas
        # Si la posición del segundo punto en x es * eliminar (track vertical) o eliminar si vacío
        if(row.x1 == '*'or pd.isna(row.x1)): 
            coord_nets.drop(row.Index, inplace=True) 
        # Si la posción del segundo punto es *, reemplazar por la del primero punto (track horizontal)
        if(row.y1 == '*'):
            coord_nets.at[row.Index, 'y1'] = coord_nets.at[row.Index, 'y0']

    # Acomodar datos
    coord_nets = coord_nets.astype(int) # Pasar todo a int
    coord_nets = coord_nets.sort_values(by=['x0']) # Acomodar en orden ascendente por primer x
    coord_nets = coord_nets.reset_index(drop=True) # Reset a los índices del DF

    # Asignar coordenadas y dividir por factor de multiplicación
    x0 = coord_nets['x0'].div(unit_dist)
    y0 = coord_nets['y0'].div(unit_dist)
    x1 = coord_nets['x1'].div(unit_dist)
    y1 = coord_nets['y1'].div(unit_dist)

    # Buscar si algún segmento atraviesa el grid de manera horizontal (i.e. segmento entre cuadrados)
    for x_0, x_1, y_comm in zip(x0, x1, y0):
        for bin in xedges:
            # Si la coordenada x del grid está entre el segmento, agregar un nuevo punto.
            if(x_0 <= bin <= x_1): 
                x0 = np.append(x0, bin)
                y0 = np.append(y0, y_comm)
    
    # Agrupar todos los datos
    x = np.append(x0,x1)
    y = np.append(y0,y1)

    # Generar figura
    plt.figure("Mapa de calor de nets", dpi = 150)

    # Generar mapa de calor por medio de un histograma
    map_color = "inferno"
    heat_map, xedges, yedges, im = plt.hist2d(x, y, bins=(xedges, yedges), cmap = map_color)
    heat_map = heat_map.T

    plt.colorbar(im)
    plt.xlabel("x [um]")
    plt.ylabel("y [um]")
    plt.title("Densidad de nets (metal 4)")
    plt.imshow(heat_map, interpolation='nearest', origin='lower', extent=[xedges[0], xedges[-1], yedges[0], yedges[-1]])
    plt.savefig(img_sav_file_nets)
    plt.show()

#------------------------------------------------------------------------------------------------------------------------------
def pins_hm(file_coordenadas_pins, xedges, yedges, x_offset, y_offset, unit_dist, img_sav_file_pines):
    '''
    Esta función genera un mapa de calor de pines basada en las posiciones de los pines
    en el archivo .def
    '''
    coord_pines = pd.read_csv(file_coordenadas_pins, sep='\t', header=0) # Cargar archivo en un dataf frame de pandas

    # Los pines originalmente están basados en algunas coordenadas negativas del .def, por lo que hay que asignarles
    # el offset correspondiente.
    for row in coord_pines.itertuples():
        if(row.y < 0):
            coord_pines.at[row.Index, 'y'] = coord_pines.at[row.Index, 'y']+y_offset
        if(row.x < 0):
            coord_pines.at[row.Index, 'x'] = coord_pines.at[row.Index, 'x']+x_offset

    # Asignar coordenadas y dividir por factor de multiplicación
    x = coord_pines['x'].div(unit_dist)
    y = coord_pines['y'].div(unit_dist)

    # Generar figura
    plt.figure("Mapa de calor de pines", dpi = 150)
    
    # Generar mapa de calor por medio de un histograma
    map_color = "inferno"
    heat_map, xedges, yedges, im = plt.hist2d(x, y, bins=(xedges, yedges), cmap = map_color)
    heat_map = heat_map.T

    plt.colorbar(im)
    plt.xlabel("x [um]")
    plt.ylabel("y [um]")
    plt.title("Densidad de pines")
    plt.imshow(heat_map, interpolation='nearest', origin='lower', extent=[xedges[0], xedges[-1], yedges[0], yedges[-1]])
    plt.savefig(img_sav_file_pines)
    plt.show()