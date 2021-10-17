import heat_map as hm
import numpy as np

# UNITS DISTANCE MICRONS 100 ;
# DIEAREA ( -320 -300 ) ( 118320 84300 ) ;
# TRACKS X -320.0 DO 1484 STEP 80 LAYER metal4 ;

unit_dist = 100 # Multiplicador de unidades de .def
track_step = 80/unit_dist # Cada cuánto hay un track, según el .def
x_offset = 320 # Offset de la coordenada x 
y_offset = 300 # Offset de la coordenada x 
x_max = (118320 + x_offset)/unit_dist # Longitud máxima en x
y_max = (84300 + y_offset)/unit_dist # Longitud máxima en y
# Un grid separado uniformemente
xedges, xstep = np.linspace(0, x_max, num=100, retstep=True) 
yedges, ystep = np.linspace(0, y_max, num=100, retstep=True)

print('Alto del cuadrado', ystep)
print('Largo del cuadrado', xstep)
print('Tracks por cuadrado', ystep/track_step) # Tracks por cuadrado = y_cuadrado / separación entre tracks 

# Archivos a leer y escribir
file_coordenadas_celdas = "../datos_def/coordenadas_celdas"
file_coordenadas_nets = "../datos_def/coordenadas_metal4"
file_coordenadas_pines = "../datos_def/coordenadas_pines"

img_sav_file_celdas = "../img/densidad_celdas_perf"
img_sav_file_nets = "../img/densidad_nets_perf"
img_sav_file_pines = "../img/densidad_pines_perf"

# Generar mapas de calor
hm.cells_hm(file_coordenadas_celdas, xedges, yedges, unit_dist, img_sav_file_celdas)
hm.nets_hm(file_coordenadas_nets, xedges, yedges, unit_dist, img_sav_file_nets)
hm.pins_hm(file_coordenadas_pines, xedges, yedges, x_offset, y_offset, unit_dist, img_sav_file_pines)
