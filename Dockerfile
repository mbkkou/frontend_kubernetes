# Utilisez une version stable de Node.js
FROM node:14

# Définissez le répertoire de travail
WORKDIR /app

# Copiez les fichiers package.json et package-lock.json pour optimiser le cache npm
COPY ./package*.json ./

# Mises à jour des certificats et installations nécessaires
RUN apt-get update && \
    apt-get install -y curl ca-certificates && \
    update-ca-certificates && \
    curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

# Configuration du registry npm (ajoutez cette ligne si nécessaire)
# RUN npm config set registry https://registry.npmjs.org/

# Nettoyez le cache npm et installez les dépendances
RUN npm cache clean --force && npm install

# Copiez le reste des fichiers de l'application
COPY . .

# Exposez le port sur lequel votre application écoute
EXPOSE 4200

# Commande par défaut pour démarrer l'application
CMD ["npm", "start"]

