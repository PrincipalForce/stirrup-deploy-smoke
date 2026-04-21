FROM node:20-slim
WORKDIR /app
COPY package*.json ./
RUN npm install --legacy-peer-deps --omit=dev
COPY . .
ENV PORT=3711 NODE_ENV=production
EXPOSE 3711
ENTRYPOINT []
CMD ["npx", "stirrup", "serve", "--port", "3711"]
