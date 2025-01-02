# Usar una imagen base de Nginx
FROM nginx:alpine

# Copiar los archivos desde la carpeta 'landing' al directorio que Nginx usa para servir archivos
COPY landing/ /usr/share/nginx/html/

# Exponer el puerto 80 para servir la página
EXPOSE 80

# Comando para ejecutar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]