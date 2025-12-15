# ======================================
# 1 - Stage de build / Dependências
# ======================================
FROM node:20-alpine 

WORKDIR /app

COPY app/package*.json ./

RUN npm ci --only=production

COPY app/ .

# ======================================
# 2 - Defenir variáveis de ambiente
# ======================================
ENV NODE_ENV=production
ENV PORT=3000


# ======================================
# 3 - Expor porta e iniciar aplicação
# ======================================
EXPOSE 3000

CMD ["node", "server.js"]
