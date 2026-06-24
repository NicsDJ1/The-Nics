FROM node:22-bookworm-slim

WORKDIR /app

COPY package.json ./
RUN npm install --omit=dev --no-audit --no-fund

COPY bundle /tmp/territorio-bundle
RUN cat /tmp/territorio-bundle/source.part.* \
    | base64 --decode \
    | tar -xz -C /app \
    && rm -rf /tmp/territorio-bundle

ENV NODE_ENV=production \
    HOST=0.0.0.0 \
    PORT=3000

EXPOSE 3000

CMD ["node", "server.js"]
