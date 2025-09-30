#!/bin/bash

echo "========================================"
echo "  Testes da Rubrica 4 - Validações"
echo "========================================"
echo ""

echo "1. Teste: Nome com menos de 3 caracteres (deve retornar 400)"
echo "--------------------------------------------------------------"
RESP=$(curl -s -w "\nHTTP Status: %{http_code}" -X POST http://localhost:5000/mensalista \
  -H "Content-Type: application/json" \
  -d '{"nome":"AB","matricula":"TEST001"}')
echo "$RESP"
echo ""

echo "2. Teste: Matrícula não alfanumérica (deve retornar 400)"
echo "--------------------------------------------------------"
RESP=$(curl -s -w "\nHTTP Status: %{http_code}" -X POST http://localhost:5000/mensalista \
  -H "Content-Type: application/json" \
  -d '{"nome":"Test Name","matricula":"INVALID@#$"}')
echo "$RESP"
echo ""

echo "3. Teste: Dados válidos (deve retornar 201)"
echo "--------------------------------------------"
RESP=$(curl -s -w "\nHTTP Status: %{http_code}" -X POST http://localhost:5000/mensalista \
  -H "Content-Type: application/json" \
  -d '{"nome":"Maria Silva","matricula":"R4TEST001"}')
echo "$RESP"
echo ""

echo "4. Teste: Matrícula duplicada (deve retornar 409)"
echo "--------------------------------------------------"
RESP=$(curl -s -w "\nHTTP Status: %{http_code}" -X POST http://localhost:5000/mensalista \
  -H "Content-Type: application/json" \
  -d '{"nome":"João Silva","matricula":"R4TEST001"}')
echo "$RESP"
echo ""

echo "5. Teste: GET /mensalista/{matricula} encontrado (deve retornar 200)"
echo "---------------------------------------------------------------------"
RESP=$(curl -s -w "\nHTTP Status: %{http_code}" http://localhost:5000/mensalista/R4TEST001)
echo "$RESP"
echo ""

echo "6. Teste: GET /mensalista/{matricula} não encontrado (deve retornar 404)"
echo "--------------------------------------------------------------------------"
RESP=$(curl -s -w "\nHTTP Status: %{http_code}" http://localhost:5000/mensalista/INEXISTENTE)
echo "$RESP"
echo ""

echo "7. Teste: GET /mensalistas (deve retornar 200 com array)"
echo "---------------------------------------------------------"
RESP=$(curl -s -w "\nHTTP Status: %{http_code}" http://localhost:5000/mensalistas)
echo "$RESP"
echo ""

echo "========================================"
echo "  Todos os testes da Rubrica 4 concluídos!"
echo "========================================"
