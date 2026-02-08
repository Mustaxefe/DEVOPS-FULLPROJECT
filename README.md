# DevOps Full Project (Estudo)

Projeto pessoal para demonstrar práticas completas de DevOps, cobrindo **infraestrutura como código**, **containers**, **Kubernetes (K3s)**, **CI/CD** e **observabilidade** em uma stack simples de API Node.js.

> **Objetivo**: criar um projeto de ponta a ponta, com foco em aprendizado prático.

---

## 📁 Estrutura do repositório

```
.
├─ app/                 # API Node.js (Express)
├─ terraform/           # Infraestrutura AWS via Terraform
└─ Dockerfile           # Build da aplicação em container
```

---

## ✅ Requisitos

- **Node.js 20+**
- **Docker**
- **Terraform**
- **AWS CLI**
- **Conta AWS (free-tier)**

---

## 🚀 Executar a aplicação localmente

```bash
cd app
npm install
npm start
```

Endpoints disponíveis:

- `GET /health` → health check
- `GET /fast` → resposta rápida
- `GET /slow` → simula latência
- `GET /cpu` → simula uso intenso de CPU
- `GET /error` → simula erro ocasional
- `GET /metrics` → métricas básicas (formato Prometheus)

---

## 🐳 Build com Docker

```bash
docker build -t obs-api .
docker run -p 3000:3000 obs-api
```

---

## ☁️ Infraestrutura (Terraform)

Os arquivos em `terraform/` definem:

- Instância EC2
- Security Group (SSH + porta da aplicação)
- IAM Role/Profile básico
- Script `startup.sh` para bootstrap da VM

### Executar (exemplo)

```bash
cd terraform
terraform init
terraform apply
```

---

## ☸️ Kubernetes (K3s) — Próxima etapa

O plano de evolução do projeto inclui:

- Deploy da API em **K3s (Kubernetes leve)** sobre EC2
- Manifestos Kubernetes (`Deployment`, `Service`, `Ingress`)
- Observabilidade (Prometheus + Grafana + Loki)

---

## 🔁 CI/CD (GitHub Actions) — Próxima etapa

Pipeline desejado:

1. Build da imagem Docker
2. Push no ECR
3. Deploy automático no K3s

---

## 📊 Observabilidade — Próxima etapa

Stack prevista:

- **Prometheus** (métricas)
- **Grafana** (dashboards)
- **Loki** (logs)
- **OpenTelemetry** (opcional para tracing)

---

## 📌 Objetivo final

Apresentar um projeto completo de DevOps com:

- Infraestrutura como código
- Deploy automatizado
- Observabilidade real
- Boas práticas de segurança e governança básicas

---

## 📬 Contato

Se quiser acompanhar a evolução ou sugerir melhorias, fique à vontade para abrir issues ou PRs.
