FROM node:18

WORKDIR /webapp

COPY . .

RUN npm install

EXPOSE 3000

CMD [ "npm", "start" ]