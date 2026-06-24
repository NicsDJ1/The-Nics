# DUO Territórios

Sistema full-stack para gestão de territórios comerciais da DUO Soluções em Energia.

[![Deploy to Render](https://render.com/images/deploy-to-render-button.svg)](https://render.com/deploy?repo=https://github.com/NicsDJ1/The-Nics)

## Recursos

- 2.008 municípios habilitados conforme a matriz enviada
- Login com perfis Gestor e Vendedor
- PostgreSQL em produção e SQLite no desenvolvimento
- Reserva transacional por 7 dias
- Bloqueio contra reservas simultâneas
- Atualização em tempo real por Server-Sent Events
- Painel para usuários, reservas e pedidos de abertura
- Auditoria das principais ações

## Publicar agora

1. Abra o projeto criado no Neon e copie a connection string PostgreSQL completa, incluindo `sslmode=require`.
2. Clique no botão **Deploy to Render** acima.
3. Autorize o repositório `NicsDJ1/The-Nics` caso o Render solicite.
4. Preencha somente:
   - `DATABASE_URL`: a connection string do Neon
   - `ADMIN_PASSWORD`: uma senha forte para o primeiro gestor
5. Confirme em **Apply** ou **Deploy Blueprint**.

O usuário inicial será `nicolas`. O sistema cria as tabelas e importa os 2.008 municípios automaticamente no primeiro início.

Após a publicação, valide:

```text
https://SEU-DOMINIO.onrender.com/api/health
```

A resposta correta deve conter `"ok":true` e `"municipalities":2008`.

## Desenvolvimento local

Requer Node.js 22.5 ou superior.

```bash
npm install
npm start
```

Sem `DATABASE_URL`, o sistema usa `data/territorio.sqlite`.

Abra `http://localhost:3000`.

Quando `ADMIN_PASSWORD` não for informada no ambiente local, uma senha inicial aleatória é gerada em `data/initial-admin.txt`. Esse arquivo é ignorado pelo Git.

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
