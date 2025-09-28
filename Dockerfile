FROM node:22-alpine AS base

WORKDIR /app

FROM base AS builder
COPY package*.json package-lock*.json ./
RUN npm install
COPY . .
#dist
RUN npm run build

FROM joseluisq/static-web-server:2
COPY --from=builder /app/dist /dist 
CMD [ "--port","3000","--root","dist" ]


