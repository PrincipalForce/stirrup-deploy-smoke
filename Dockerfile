FROM node:20-slim
WORKDIR /app
COPY package*.json ./
RUN npm install --legacy-peer-deps --omit=dev
COPY . .
# Diagnostic: confirm install actually produced stirrup binary at build time
RUN ls -la node_modules/stirrup-ai/ 2>&1 | head -10 && \
    ls -la node_modules/.bin/stirrup* 2>&1 || echo "MISSING"
ENV PORT=3711 NODE_ENV=production NPM_CONFIG_CACHE=/tmp/.npm
EXPOSE 3711
ENTRYPOINT []
CMD ["node", "/app/node_modules/.bin/stirrup", "serve", "--port", "3711"]
