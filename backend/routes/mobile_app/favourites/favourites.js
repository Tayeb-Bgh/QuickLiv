const express = require('express');
const db = require('../../../dbConnexion');
const authenticate = require('../../auth/utils/verify_jwt');
const router = express.Router();

// Récupérer tous les business favoris d'un client avec les détails
router.get("/", authenticate, (req, res) => {
  const idCust = req.user.id;
  const query = 'SELECT b.* FROM Business b JOIN Favourite f ON b.idBusns = f.idBusnsFav WHERE f.idCustFav = ?';

  db.query(query, [idCust], (err, results) => {
    if (err) {
      console.error("[SQL ERROR]", err);
      return res.status(500).json({ error: "Database error" });
    }

    return res.status(200).json(results.length > 0 ? results : []);
  });
});

// Filtrer la liste des business favoris selon un type
router.get("/filter/:typeBusns", authenticate, (req, res) => {
  const idCustFav = req.user.id;
  const { typeBusns } = req.params;
  const query = 'SELECT b.* FROM Favourite f JOIN Business b ON f.idBusnsFav = b.idBusns WHERE f.idCustFav = ? AND b.categoryBusns = ?';
  console.log("Type de catégorie reçu : ", typeBusns);

  db.query(query, [idCustFav, typeBusns], (err, results) => {
    if (err) {
      console.error("[SQL ERROR]", err);
      return res.status(500).json({ error: "Database error" });
    }
    return res.status(200).json(results.length > 0 ? results : []);

  });
});

// Ajouter un business aux favoris
router.post("/:idBusnsFav", authenticate, (req, res) => {
  const idCustFav = req.user.id;
  const { idBusnsFav } = req.params;
  const query = 'INSERT INTO Favourite (idCustFav, idBusnsFav) VALUES (?, ?)';

  db.query(query, [idCustFav, idBusnsFav], (err, results) => {
    if (err) {
      console.error("[SQL ERROR]", err);
      return res.status(500).json({ error: "Database error" });
    }
    res.status(results.affectedRows > 0 ? 201 : 400).json({
      success: results.affectedRows > 0,
      message: results.affectedRows > 0 ? 'Favourite added successfully' : 'Failed to add favourite'
    });
  });
});

// Supprimer un business des favoris 
router.delete("/:idBusnsFav", authenticate, (req, res) => {
  const idCustFav = req.user.id;
  const { idBusnsFav } = req.params;
  const query = 'DELETE FROM Favourite WHERE idCustFav = ? AND idBusnsFav = ?';

  db.query(query, [idCustFav, idBusnsFav], (err, results) => {
    if (err) {
      console.error("[SQL ERROR]", err);
      return res.status(500).json({ error: "Database error" });
    }
    res.status(results.affectedRows > 0 ? 200 : 404).json({
      success: results.affectedRows > 0,
      message: results.affectedRows > 0 ? 'Favourite removed successfully' : 'Favourite not found'
    });
  });
});

module.exports = router;