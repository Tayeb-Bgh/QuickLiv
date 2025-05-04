const express = require('express');
const db = require('../../../dbConnexion');
const authenticate = require('../../auth/utils/verify_jwt');
const router = express.Router();

router.post('/createdeliverer', (req, res) => {
  const {
    nom, prenom, dateNais, adresse, telephone, email, numSecuriteSociale, numPermis, sexe,
    marque, model, annee, couleur, matricule, numChassis, assurance, type,
    photoIdent, photoVehic, permis, carteGrise
  } = req.body;

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


router.put('/update-client-submited', authenticate, async (req, res) => {
  try {
    const client_id = req.user.id;

    const updateQuery = "UPDATE Customer SET isSubmittedDelivererCust = 1 WHERE idCust = ?";

    db.query(updateQuery, [client_id], (err, result) => {
      if (err) {
        console.error('Erreur lors de la mise à jour:', err);
        return res.status(500).json({
          success: false,
          message: 'Erreur interne du serveur',
          error: err.message,
        });
      }

      res.status(200).json({ success: true, message: 'Statut mis à jour avec succès' });
    });
  } catch (error) {
    console.error('Erreur serveur:', error);
    return res.status(500).json({
      success: false,
      message: 'Erreur interne du serveur',
      error: error.message,
    });
  }
});


router.get('/get-client-status', authenticate, async (req, res) => {
  try {
    const client_id = req.user.id; 
    const query = "SELECT isSubmittedDelivererCust FROM Customer WHERE idCust = ?";

    db.query(query, [client_id], (err, result) => {
      if (err) {
        console.error('Erreur lors de la récupération du statut du client:', err);
        return res.status(500).json({ message: 'Erreur lors de la récupération du statut.' });
      }

      if (result.length > 0) {
        const isSubmittedDelivererCust = result[0].isSubmittedDelivererCust;
        res.status(200).json({ isSubmittedDelivererCust });
      } else {
        res.status(404).json({ message: 'Client non trouvé.' });
      }
    });
  } catch (error) {
    console.error('Erreur serveur:', error);
    return res.status(500).json({ message: 'Erreur interne du serveur', error: error.message });
  }
});



module.exports = router;
