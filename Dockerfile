FROM node:latest as build-step

RUN mkdir -p /app

WORKDIR /app

COPY package.json /app

RUN npm config set strict-ssl false

RUN npm install

COPY . /app

RUN npm run build --prod

FROM nginx:latest

COPY --from=build-step /app/dist/sample-angular-app /usr/share/nginx/html
