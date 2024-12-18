FROM node:20
WORKDIR /app
COPY package.json ./
RUN npm ci --silent
COPY . .
EXPOSE 3000
CMD ["node", "producer.js"]