# DUO Territórios

Sistema full-stack para gestão de territórios comerciais da DUO Soluções em Energia.

## Recursos

- 2.008 municípios habilitados conforme a matriz enviada
- Login com perfis Gestor e Vendedor
- PostgreSQL em produção e SQLite no desenvolvimento
- Reserva transacional por 7 dias
- Bloqueio contra reservas simultâneas
- Atualização em tempo real por Server-Sent Events
- Painel para usuários, reservas e pedidos de abertura
- Auditoria das principais ações

## Desenvolvimento local

Requer Node.js 22.5 ou superior.

```bash
npm install
npm start
```

Sem `DATABASE_URL`, o sistema usa `data/territorio.sqlite`.

Abra `http://localhost:3000`.

Quando `ADMIN_PASSWORD` não for informada no ambiente local, uma senha inicial aleatória é gerada em `data/initial-admin.txt`. Esse arquivo é ignorado pelo Git.

## Publicação gratuita

A configuração recomendada é:

- Render Free para o servidor Node.js e subdomínio `onrender.com`
- Neon Free para o PostgreSQL persistente

### 1. Criar banco no Neon

1. Entre no Neon usando a conta GitHub.
2. Crie um projeto PostgreSQL.
3. Copie a connection string completa com SSL.

O sistema cria as tabelas e importa os municípios automaticamente no primeiro início.

### 2. Publicar no Render

1. Entre no Render usando a conta GitHub.
2. Crie um Blueprint usando este repositório.
3. Preencha as variáveis solicitadas:
   - `DATABASE_URL`: connection string do Neon
   - `ADMIN_PASSWORD`: senha forte do gestor inicial
4. Confirme o deploy.

O arquivo `render.yaml` já configura Docker, plano gratuito, health check e demais variáveis.

## Variáveis

```text
PORT=3000
HOST=0.0.0.0
DATABASE_URL=postgresql://...
DATABASE_SSL=true
ADMIN_USERNAME=nicolas
ADMIN_NAME=Nicolas
ADMIN_PASSWORD=uma-senha-forte
```

## Docker

```bash
docker build -t territorio-duo .
docker run --rm -p 3000:3000 \
  -e DATABASE_URL='postgresql://...' \
  -e ADMIN_PASSWORD='uma-senha-forte' \
  territorio-duo
```

## Segurança

- Nunca grave `DATABASE_URL`, senhas ou arquivos SQLite no repositório.
- Troque a senha inicial após o primeiro acesso.
- Em produção, use somente conexão HTTPS e PostgreSQL persistente.
