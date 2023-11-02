FROM node:16.17.0-alpine as builder

WORKDIR /app

COPY ./package*.json .

RUN npm install

COPY . .

RUN npm run build

FROM nginx:stable-alpine

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=builder /app/build ./build

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]