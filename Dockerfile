FROM node:20-slim AS builder
ENV DEBIAN_FRONTEND=noninteractive
RUN (test -f /var/lib/dpkg/statoverride && sed -i '/messagebus/d' /var/lib/dpkg/statoverride || true) && \
    apt-get update && apt-get install -y --no-install-recommends dumb-init && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package*.json ./
RUN npm install --legacy-peer-deps
COPY . .

FROM node:20-slim AS runner
ENV DEBIAN_FRONTEND=noninteractive
RUN (test -f /var/lib/dpkg/statoverride && sed -i '/messagebus/d' /var/lib/dpkg/statoverride || true) && \
    apt-get update && apt-get install -y --no-install-recommends dumb-init && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY --from=builder /app .
ENV PORT=3711 NODE_ENV=production
EXPOSE 3711
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD node -e "fetch('http://localhost:3711/health').then(r=>{process.exit(r.ok?0:1)}).catch(()=>process.exit(1))"
CMD ["dumb-init", "npx", "stirrup", "serve", "--port", "3711"]
