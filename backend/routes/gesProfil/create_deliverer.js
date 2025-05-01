const express = require('express');
const db = require('../../dbConnexion');
const router = express.Router();

router.post('/createdeliverer', (req, res) => {
  const {
    nom, prenom, dateNais, adresse, telephone, email, numSecuriteSociale, numPermis, sexe,
    marque, model, annee, couleur, matricule, numChassis, assurance, type,
    photoIdent, photoVehic, permis, carteGrise
  } = req.body;

  // Normalisation du sexe et du type de véhicule
  const normalizedSexe = sexe === "Homme" ? "M" : "F";
  const normalizedType = type === "Vehicule" ? "CAR" : "SCOOTER";
  console.log(`DEBUG: Normalized Type: ${normalizedType}`);

  const defaultAuthorized = 0;
  const defaultIdConvTelegramDel = 0;

  let normalizedTelephone = telephone;
  if (telephone.startsWith('0')) {
    normalizedTelephone = telephone.slice(1);
  }

  const annee2 = annee + "-01-01";
  console.log(`DEBUG: Année utilisée: ${annee2}`);

  // Affichage des valeurs qui vont être insérées dans la table Vehicle
  const vehicleValues = [
    matricule, numChassis, normalizedType, photoVehic, carteGrise, marque, model, couleur, annee2, assurance
  ];
  console.log(`DEBUG: Vehicle Values: ${JSON.stringify(vehicleValues)}`);

  const vehicleQuery = `
    INSERT INTO Vehicle 
    (registerNbrVehc, vinNbrVehc, typeVehc, imgUrlVehc, regDocUrlVehc, brandVehc, modelVehc, colorVehc, yearVehc, insuranceExprVehc)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `;

  db.query(vehicleQuery, vehicleValues, (vehicleErr, vehicleResult) => {
    if (vehicleErr) {
      console.error('Erreur d\'insertion Vehicle:', vehicleErr);
      return res.status(500).json({ message: 'Erreur lors de l\'enregistrement du véhicule.' });
    }

    const vehicleId = vehicleResult.insertId;
    console.log(`DEBUG: Vehicle ID: ${vehicleId}`);

    const delivererValues = [
      nom, prenom, dateNais, adresse, normalizedTelephone, email, numSecuriteSociale, numPermis, normalizedSexe,
      photoIdent, permis, vehicleId, defaultAuthorized, defaultIdConvTelegramDel
    ];
    console.log(`DEBUG: Deliverer Values: ${JSON.stringify(delivererValues)}`);

    const delivererQuery = `
      INSERT INTO Deliverer
      (firstNameDel, lastNameDel, birthDateDel, adrsDel, phoneDel, emailDel, socSecNbrDel, licenseDel, sexDel,
       imgUrlDel, licenseUrlDel, vehicleDel, authorizedDel, idConvTelegramDel)
      VALUES (?,?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    `;

    db.query(delivererQuery, delivererValues, (delivererErr, delivererResult) => {
      if (delivererErr) {
        console.error('Erreur d\'insertion Deliverer:', delivererErr);
        return res.status(500).json({ message: 'Erreur lors de l\'enregistrement du livreur.' });
      }

      res.status(201).json({ message: 'Livreur créé avec succès', delivererId: delivererResult.insertId });
    });
  });
});

module.exports = router;
