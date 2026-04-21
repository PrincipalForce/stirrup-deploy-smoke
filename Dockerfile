FROM node:20-slim
WORKDIR /app
COPY package*.json ./
RUN npm install --legacy-peer-deps --omit=dev
COPY . .
ENV PORT=3711 NODE_ENV=production NPM_CONFIG_CACHE=/tmp/.npm
EXPOSE 3711
ENTRYPOINT []
CMD ["node", "/app/node_modules/stirrup-ai/dist/cli/cli.js", "serve", "--port", "3711"]
