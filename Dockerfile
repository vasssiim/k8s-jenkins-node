FROM node:24

WORKDIR /webapp

COPY . .

RUN npm install

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
 && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

EXPOSE 3000

CMD [ "npm", "start" ]