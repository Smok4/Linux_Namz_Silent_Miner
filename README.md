# 🛠️ Suite de Test Silencieuse — `namz_lab`

> ⚠️ Ce projet est strictement réservé à un usage **éducatif et légal** dans le cadre de **tests de sécurité autorisés**. N’exécutez jamais ces scripts sur des systèmes sans autorisation explicite.

---

## 🎯 Objectif

Ce dépôt propose une suite de scripts Bash pour démontrer, dans un **environnement de laboratoire**, des techniques post-exploitation de type :

- Lancement furtif de processus
- Persistance via systemd
- Évasion face à des outils de surveillance système

L’ensemble est conçu pour fonctionner **en silence**, sans afficher de sortie à l’écran, dans un contexte de **simulation de compromission** pour test défensif ou formation.

---

## 📁 Structure du projet

namz_lab/
├── start_all_namz.sh # Lance les 3 scripts dans l’ordre, sans sortie
├── payload_namz.sh # Simule un processus camouflé (ex : "kworker")
├── evasion_namz.sh # Arrête/redémarre le payload selon les outils actifs
├── persistance_namz.sh # Installe une persistance via systemd
├── README.md

yaml
Copier
Modifier

---

## 🚀 Utilisation

### 1. Rendre les scripts exécutables
```bash
chmod +x *.sh
2. Lancer le script principal
bash
Copier
Modifier
./start_all_namz.sh
Ce script exécutera :

Le faux "payload"

Le système de détection de surveillance (top, htop, etc.)

Le mécanisme de persistance via un service systemd

📌 Aucune sortie n’apparaît à l’écran.

🔍 Détail des scripts
Script	Rôle
payload_namz.sh	Lance un binaire (ex : sleep) avec un nom de processus camouflé
evasion_namz.sh	Surveille les outils (htop, top, etc.) et arrête le payload si besoin
persistance_namz.sh	Crée un service systemd discret pour relancer le payload au démarrage
