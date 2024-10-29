FROM node:18-alpine AS builder
RUN apk update && apk add --no-cache git
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
