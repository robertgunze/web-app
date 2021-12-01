FROM node:12-alpine as builder

RUN mkdir -p /usr/local/app

WORKDIR /usr/local/app

ENV PATH /usr/local/app/node_modules/.bin:$PATH

COPY . /usr/local/app/

RUN npm install -g @angular/cli@9.1.12

RUN npm install

RUN npm run build

FROM nginx:1.19.3

COPY --from=builder /usr/local/app/dist/web-app /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
