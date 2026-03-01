FROM node:24

WORKDIR /webapp

COPY . .

RUN npm install

EXPOSE 3000

CMD [ "npm", "start" ]