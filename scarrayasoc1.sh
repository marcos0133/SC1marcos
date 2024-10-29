#!/bin/bash

# Verificamos si se pasó un archivo como argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 colores.txt"
    exit 1
fi

# Archivo de colores
archivo_colores=$1

# Declaramos un array asociativo para los colores
declare -A colores

# Leemos el archivo y llenamos el array asociativo
while IFS=: read -r color valor_hex; do
    colores["$color"]="$valor_hex"
done < "$archivo_colores"

# Mostramos los colores disponibles
echo "Colores disponibles:"
for color in "${!colores[@]}"; do
    echo "- $color"
done

# Pedimos al usuario que seleccione los colores
echo "Selecciona el color de fondo de la página web:"
read -r color_fondo

echo "Selecciona el color del párrafo/div en el que voy a poner el texto:"
read -r color_parrafo

echo "Selecciona el color del texto:"
read -r color_texto

# Comprobamos que los colores seleccionados existen en el array
if [[ -z "${colores[$color_fondo]}" || -z "${colores[$color_parrafo]}" || -z "${colores[$color_texto]}" ]]; then
    echo "Uno de los colores seleccionados no es válido."
    exit 1
fi

# Obtener la dirección IP
ip_info=$(ifconfig | grep 'inet ' | awk '{print $2}' | head -n 1)

# Crear el archivo HTML
nombre_archivo="index.html"
cat <<EOL > "$nombre_archivo"
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Página Generada</title>
    <style>
        body {
            background-color: ${colores[$color_fondo]};
            color: ${colores[$color_texto]};
        }
        .contenido {
            background-color: ${colores[$color_parrafo]};
            padding: 20px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="contenido">
        <h1>Información de la IP</h1>
        <p>Tu dirección IP es: $ip_info</p>
    </div>
</body>
</html>
EOL

echo "Página generada: $nombre_archivo"
