# Politica de Seguranca - Agroesfera

## Escopo

Define as politicas de seguranca obrigatorias para o projeto Agroesfera.
Verificado automaticamente pelo pipeline CI/CD a cada push via `security-policy-gate`.

---

## 1. Gestao de Segredos

- Proibido armazenar senhas, tokens ou chaves de API diretamente no codigo.
- Todas as credenciais devem ser configuradas via GitHub Secrets e acessadas
  como variaveis de ambiente em tempo de execucao.
- Credenciais dos sensores IoT devem usar `Environment.GetEnvironmentVariable()`.

| Secret                 | Uso                                       |
|------------------------|-------------------------------------------|
| MQTT_BROKER_URL        | Endpoint do broker MQTT dos sensores IoT  |
| MQTT_PASSWORD          | Senha de autenticacao MQTT                |
| DB_CONNECTION_STRING   | String de conexao ao banco de dados       |
| ML_API_KEY             | Chave da API de Machine Learning          |

---

## 2. Regras do Pipeline

Todo push para main ou develop deve passar pelo `security-policy-gate`.

| Regra | Descricao |
|-------|-----------|
| 1 | Arquivo security/SECURITY_POLICY.md presente no repositorio |
| 2 | Nenhuma senha hardcoded em arquivos .cs |
| 3 | Credenciais IoT usando Environment.GetEnvironmentVariable() |
| 4 | Imagens Docker com tags fixas - proibido usar :latest |

---

## 3. Regras de Codigo

- Conexoes MQTT devem usar TLS obrigatoriamente (porta 8883).
- Logs nao devem conter dados dos sensores com informacao identificavel de usuario.
- APIs expostas devem usar autenticacao JWT com expiracao maxima de 24h.
- Imagens Docker devem usar tags fixas (ex: aspnet:8.0.4, nunca aspnet:latest).

---

## 4. Violacoes

Qualquer violacao resulta em bloqueio automatico do deploy pelo
`security-policy-gate` com exit 1. A equipe deve corrigir a violacao,
commitar a correcao e aguardar nova execucao do pipeline.

---

Global Solution FIAP - 2026/1
