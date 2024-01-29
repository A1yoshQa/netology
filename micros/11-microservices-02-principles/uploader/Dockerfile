FROM node:alpine
WORKDIR /app

COPY package*.json ./
RUN npm --proxy http://172.16.1.10:3128 install
COPY src ./

CMD ["node", "server.js"]
