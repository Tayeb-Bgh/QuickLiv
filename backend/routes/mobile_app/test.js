const db = require('../../dbConnexion'); // Assure-toi que ce chemin correspond à ton fichier db.js
// Requête SQL pour récupérer tous les bons
db.query('SHOW TABLES', (err, results) => {
    if (err) {
        console.error('Erreur lors de la récupération des tables :', err);
    } else {
        console.log('Tables dans la base de données :');
        results.forEach((row) => {
            console.log(Object.values(row)[0]);
        });
    }
});
