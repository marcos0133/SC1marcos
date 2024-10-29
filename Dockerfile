# Usa la imagen oficial de Nginx
FROM nginx:latest

# Copia el archivo de configuración de Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copia el archivo HTML al directorio de Nginx
COPY index.html /usr/share/nginx/html/index.html
