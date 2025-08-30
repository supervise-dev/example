FROM alpine:latest

RUN apk add --no-cache mise linux-headers python3 make g++

WORKDIR /app

COPY mise.toml ./

RUN mise trust && mise install

COPY package*.json ./

RUN mise exec -- npm install --only=production

COPY . .

EXPOSE 3000

CMD ["mise", "exec", "--", "npm", "start"]