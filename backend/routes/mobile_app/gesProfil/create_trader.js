const express = require('express');
const db = require('../../../dbConnexion');
const authenticate = require('../../auth/utils/verify_jwt');
const router = express.Router();

router.post('/createTrader', (req, res) => {
    const {
        nom, prenom, dateNais, adresse, telephone, numIdentite, sexe, nomCommerce,
        adresseCommerce, telephoneCommerce, email, numRegCommerce, type, pieceIdentit, regCommerce, paieImpots,
        autoSanitaire
    } = req.body;


    const normalizedBossSex = sexe === "Homme" ? "M" : "F";
    const defaultAuthorized = 0;
    const hashedPwdBusns = "123456";
    const latBusns = 35.5;
    const lngBusns = 35.5;
    const hourOpenBusns = "09:00:00";
    const hourCloseBusns = "22:00:00";
    const wilayaBusns = "bejaia";

    let typeBusns = "restaurant";

    if (type === 'Boucherie' || type === 'Epicerie') {
        typeBusns = "grocery";
    }

    let normalizedTelephone1 = telephone;
    if (telephone.startsWith('0')) {
        normalizedTelephone1 = telephone.slice(1);
    }

    let normalizedTelephone2 = telephoneCommerce;
    if (telephoneCommerce.startsWith('0')) {
        normalizedTelephone2 = telephoneCommerce.slice(1);
    }

    const businessQuery = `
      INSERT INTO Business
      (nameBusns, typeBusns, phoneBusns, emailBusns, hashedPwdBusns, regNbrBusns,
       latBusns, lngBusns, hourOpenBusns, hourCloseBusns, bossFirstNameBusns, bossLastNameBusns, bossSexBusns,
       bossBdayDateBusns, bossPhoneBusns, bossAdrsBusns, bossIdCardBusns, taxesUrlBusns,
       comRegUrlBusns, idCardUrlBusns, authorizationUrlBusns, authorizedBusns, wilayaBusns,
       categoryBusns)
      VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)
    `;

    const businessValues = [
        nomCommerce, typeBusns, normalizedTelephone2, email, hashedPwdBusns, numRegCommerce, latBusns, lngBusns,
        hourOpenBusns, hourCloseBusns, nom, prenom, normalizedBossSex, dateNais, normalizedTelephone1, adresse, numIdentite,
        paieImpots, regCommerce, pieceIdentit, autoSanitaire, defaultAuthorized, wilayaBusns, type
    ];

    db.query(businessQuery, businessValues, (businessErr, businessResult) => {
        if (businessErr) {
            console.error('Erreur d\'insertion Business:', businessErr);
            return res.status(500).json({ message: 'Erreur lors de l\'enregistrement de l\'entreprise.' });
        }

        res.status(201).json({ message: 'Entreprise créée avec succès', businessId: businessResult.insertId });
    });
});

router.put('/update-client', authenticate, async (req, res) => {
    try {
      const client_id = req.user.id;
  
      const updateQuery = "UPDATE Customer SET isSubmittedPartnerCust = 1 WHERE idCust = ?";
  
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


module.exports = router;
