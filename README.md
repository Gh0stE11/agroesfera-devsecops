# Agroesfera - DevSecOps

Global Solution FIAP 2026/1 - Engenharia de Software
Disciplina: Ciberseguranca | Prof. MSc. Oerton Fernandes

## Integrantes

Caio Freitas — RM553190  
Caio Hideki — RM553630  
Jorge Booz — RM552700  
Lana Andrade — RM552596  
Mateus Tibão — RM553267 
---

## Sobre o projeto

O Agroesfera e uma plataforma de agricultura autonoma para ambientes de cultivo
controlado. Este repositorio contem o modulo de DevSecOps integrado ao pipeline
CI/CD do projeto.

## Implementacao

A opcao escolhida foi criar uma checagem automatizada no pipeline. Foi
implementado o `security-policy-gate`, um job bash no GitHub Actions que
verifica a conformidade do projeto com a politica de seguranca a cada push.
Se qualquer regra for violada, o job termina com exit 1 e o deploy e bloqueado.

Regras verificadas:

- Arquivo security/SECURITY_POLICY.md presente no repositorio
- Nenhuma senha hardcoded em arquivos .cs
- Credenciais IoT usando Environment.GetEnvironmentVariable()
- Imagens Docker sem tag :latest

## Estrutura

```
.github/workflows/devsecops-pipeline.yml
security/SECURITY_POLICY.md
security/simular-pipeline.sh
src/MqttConfig.cs
src/MqttConfig_VIOLACAO.cs
docker-compose.yml
docker-compose_VIOLACAO.yml
docs/evidencias/
```

## Simulacao local

```bash
chmod +x security/simular-pipeline.sh
bash security/simular-pipeline.sh
```

---

Global Solution FIAP - Ciberseguranca - 1 Semestre 2026
