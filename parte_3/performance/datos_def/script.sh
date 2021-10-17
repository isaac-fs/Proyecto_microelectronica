#!/bin/bash
# ------------------------------------------CELLS---------------------------------------------

# Encontrar los componentes
sed -n '/^COMPONENTS/,/^END COMPONENTS/p' $1 > componentes

#Remover FILL CELLS
sed -i '/^- FILL/d' componentes

#Extraer sólo las coordenadas
grep -o '(.*)' componentes | grep -oP '\(\K[^\)]+' | sed 's/^.//' > coordenadas_celdas

# Nombrar coordenadas
sed -i '1 i\x y' coordenadas_celdas

# Organizar texto
sed -i 's/\s/\t/g' coordenadas_celdas
 
# Remover espacios al final
sed -i 's/[[:blank:]]*$//' coordenadas_celdas

# -------------------------------------------NETS---------------------------------------------

# Econtrar las nets
sed -n '/^NETS/,/^END NETS/p' $1 > nets

# Encontrar las coordenadas de metal 4
grep 'metal4' nets | grep -o '(.*)' > coordenadas_metal4

# Dar formato
sed -i 's/(//g' coordenadas_metal4
sed -i 's/)//g' coordenadas_metal4
sed -i 's/\s\s\s/ /g' coordenadas_metal4
sed -i 's/^.//' coordenadas_metal4

# Nombrar coordenadas
sed -i '1 i\x0 y0 x1 y1' coordenadas_metal4

# Organizar texto
sed -i 's/\s/\t/g' coordenadas_metal4

# Eliminar coordenadas que no sean del primer tramo
sed -i -r 's/\S+//14' coordenadas_metal4 
sed -i -r 's/\S+//13' coordenadas_metal4
sed -i -r 's/\S+//12' coordenadas_metal4 
sed -i -r 's/\S+//11' coordenadas_metal4
sed -i -r 's/\S+//10' coordenadas_metal4 
sed -i -r 's/\S+//9' coordenadas_metal4
sed -i -r 's/\S+//8' coordenadas_metal4 
sed -i -r 's/\S+//7' coordenadas_metal4 
sed -i -r 's/\S+//6' coordenadas_metal4
sed -i -r 's/\S+//5' coordenadas_metal4

# Remover espacios al final
sed -i 's/[[:blank:]]*$//' coordenadas_metal4

# -----------------------------------------PINES----------------------------------------------

# Econtrar los pines
sed -n '/^PINS/,/^END PINS/p' $1 > pins

#Extraer sólo las coordenadas
grep 'PLACED' pins | grep -o '(.*)' | grep -oP '\(\K[^\)]+' | sed 's/^.//' > coordenadas_pines

# Nombrar coordenadas
sed -i '1 i\x y' coordenadas_pines

# Organizar texto
sed -i 's/\s/\t/g' coordenadas_pines
 
# Remover espacios al final
sed -i 's/[[:blank:]]*$//' coordenadas_pines
