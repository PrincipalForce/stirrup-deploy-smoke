FROM node:20-slim
WORKDIR /app
RUN corepack enable
COPY package*.json yarn.lock* ./
RUN yarn install --non-interactive
COPY . .
ENV PORT=3711 NODE_ENV=production NPM_CONFIG_CACHE=/tmp/.npm
EXPOSE 3711
ENTRYPOINT []
CMD ["node", "/app/node_modules/.bin/stirrup", "serve", "--port", "3711"]
