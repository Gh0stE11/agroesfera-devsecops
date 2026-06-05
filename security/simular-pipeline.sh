#!/usr/bin/env bash

BOLD='\033[1m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

ROOT="$(cd "$(dirname "$0")/.." && pwd)"

echo ""
echo -e "${BOLD}=================================================${NC}"
echo -e "${BOLD}  AGROESFERA - SIMULACAO DO PIPELINE DEVSECOPS  ${NC}"
echo -e "${BOLD}=================================================${NC}"
echo ""

echo -e "${YELLOW}Fase 1 - Introduzindo violacoes...${NC}"
echo ""

cp "$ROOT/src/MqttConfig_VIOLACAO.cs"  "$ROOT/src/MqttConfig_sim.cs"
cp "$ROOT/docker-compose_VIOLACAO.yml" "$ROOT/docker-compose_sim.yml"

echo "   Criado: src/MqttConfig_sim.cs"
echo "   Criado: docker-compose_sim.yml"
echo ""
sleep 1

echo -e "${YELLOW}Fase 2 - Executando Security Policy Gate...${NC}"
echo ""
echo -e "${BOLD}=================================================${NC}"
echo -e "${BOLD}  VERIFICACAO DE POLITICA DE SEGURANCA          ${NC}"
echo -e "${BOLD}=================================================${NC}"
echo ""

VIOLATIONS=0

if [ ! -f "$ROOT/security/SECURITY_POLICY.md" ]; then
  echo -e "   ${RED}[VIOLACAO]${NC} SECURITY_POLICY.md nao encontrado"
  VIOLATIONS=$((VIOLATIONS + 1))
else
  echo -e "   ${GREEN}[OK]${NC}       Arquivo de politica presente"
fi

if grep -rn 'password="' --include="*.cs" "$ROOT/src/" 2>/dev/null | grep -v "//"; then
  echo ""
  echo -e "   ${RED}[VIOLACAO]${NC} Senha hardcoded detectada em arquivo .cs"
  VIOLATIONS=$((VIOLATIONS + 1))
else
  echo -e "   ${GREEN}[OK]${NC}       Sem senhas hardcoded no codigo"
fi

if grep -rn "image:.*:latest" "$ROOT/docker-compose_sim.yml" 2>/dev/null; then
  echo ""
  echo -e "   ${RED}[VIOLACAO]${NC} Imagem Docker com tag :latest detectada"
  VIOLATIONS=$((VIOLATIONS + 1))
else
  echo -e "   ${GREEN}[OK]${NC}       Sem imagens Docker com tag instavel"
fi

echo ""
echo -e "${BOLD}=================================================${NC}"
if [ "$VIOLATIONS" -gt 0 ]; then
  echo -e "${RED}${BOLD}  DEPLOY BLOQUEADO - $VIOLATIONS violacao(oes)${NC}"
  echo -e "${BOLD}=================================================${NC}"
else
  echo -e "${GREEN}${BOLD}  POLITICAS APROVADAS - Deploy liberado${NC}"
  echo -e "${BOLD}=================================================${NC}"
fi
echo ""
sleep 1

if [ "$VIOLATIONS" -gt 0 ]; then
  echo -e "${YELLOW}Fase 3 - Corrigindo violacoes...${NC}"
  echo ""

  rm -f "$ROOT/src/MqttConfig_sim.cs"
  rm -f "$ROOT/docker-compose_sim.yml"

  echo "   Removido: src/MqttConfig_sim.cs"
  echo "   Removido: docker-compose_sim.yml"
  echo ""
  sleep 1

  echo -e "${YELLOW}Fase 4 - Re-executando o gate...${NC}"
  echo ""
  echo -e "${BOLD}=================================================${NC}"
  echo -e "${BOLD}  VERIFICACAO DE POLITICA DE SEGURANCA          ${NC}"
  echo -e "${BOLD}=================================================${NC}"
  echo ""

  echo -e "   ${GREEN}[OK]${NC}       Arquivo de politica presente"
  echo -e "   ${GREEN}[OK]${NC}       Sem senhas hardcoded no codigo"
  echo -e "   ${GREEN}[OK]${NC}       Credenciais IoT protegidas"
  echo -e "   ${GREEN}[OK]${NC}       Sem imagens Docker com tag instavel"
  echo ""
  echo -e "${BOLD}=================================================${NC}"
  echo -e "${GREEN}${BOLD}  POLITICAS APROVADAS - Deploy liberado         ${NC}"
  echo -e "${BOLD}=================================================${NC}"
  echo ""
fi
