# Usa una imagen basada en Debian que es más robusta para instalaciones adicionales
FROM node:18-bullseye-slim AS builder

# Instala git usando apt-get
RUN apt-get update && apt-get install -y git

WORKDIR /app

# Copia solo package.json y package-lock.json para instalar dependencias
COPY package.json .
RUN npm install

# Copia el resto del código de la aplicación
COPY . .

# Construye la aplicación (si tienes un script build en package.json)
RUN npm run build

# Segunda etapa: Servidor Nginx
FROM nginx
EXPOSE 80

# Copia los archivos de construcción desde la etapa anterior a la ruta que Nginx usa para servir contenido
COPY --from=builder /app/build /usr/share/nginx/html
