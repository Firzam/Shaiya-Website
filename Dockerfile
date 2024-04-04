FROM node:18.17.1-alpine3.18

RUN apk update && apk upgrade \
	&& npm install -g npm@10

WORKDIR /app
COPY . .

RUN npm install

CMD [ "node", "app.js" ]