# Utilisation de l'image officielle Node.js comme base
FROM node:18

# Définition du répertoire de travail dans le conteneur
WORKDIR /usr/src/app

# Copie des fichiers package.json et package-lock.json
COPY package*.json ./

# Installation des dépendances du projet
RUN npm install

# Copie du reste des fichiers du projet dans le répertoire de travail
COPY . .

# Exposer le port sur lequel l'application fonctionne 
EXPOSE 3000

# Définir la commande pour démarrer l'application
CMD ["npm", "start"]
