const express = require('express')
const router = express.Router()
const db = require('../../../dbConnexion')

router.get('/business', (req, res) => {

  const { search } = req.query

  if (!search)
    return res.status(400).send({ msg: "Bad request", err: "search query param requried" })

  const query = `SELECT b.idBusns,b.nameBusns,b.categoryBusns,b.typeBusns,b.imgUrlBusns,b.vidUrlBusns,b.lngBusns,b.latBusns,b.hourOpenBusns,b.hourCloseBusns,b.dayOffBusns,
                  b.descBusns, b.instaUrlBusns,b.fcbUrlBusns, b.phoneBusns FROM Business b 
                    WHERE b.authorizedBusns = ? 
                    AND (
                            TRIM(LOWER(nameBusns)) LIKE CONCAT('%',TRIM(LOWER(?)),'%')
                            OR TRIM(LOWER(categoryBusns)) LIKE CONCAT('%',TRIM(LOWER(?)),'%')
                            OR idBusns IN (
                                SELECT DISTINCT pb.idBusns 
                                FROM ProductBusiness pb
                                JOIN Product p 
                                ON pb.idProd = p.idProd
                                WHERE (
                                    TRIM(LOWER(p.nameProd)) LIKE CONCAT('%',TRIM(LOWER(?)),'%')
                                    OR TRIM(LOWER(p.categoryProd)) LIKE CONCAT('%',TRIM(LOWER(?)),'%')
                                )
                                AND p.deleteProd = ?
                        )
                    )`

  const params = [1, search, search, search, search, 0]

  db.query(query, params, (err, results) => {

    if (err) {
      console.error("Database error:", err);
      return res.status(500).json({ error: "Internal server error" });
    }

    if (results && results.length > 0) {
      return res.status(200).json(results);
    } else {
      return res.status(404).json({ message: 'No business found' })
    }
  })

});

router.get('/business/:id/products', (req, res) => {
  const { search } = req.query;
  const { id } = req.params;

  if (!search || !id) {
    return res.status(400).json({
      message: "Bad request",
      error: "Both 'search' query param and 'id' param are required",
    });
  }

  const trimmedSearch = search.trim().toLowerCase();
  const query = `
      SELECT pb.* FROM ProductBusiness pb
      JOIN Product p ON pb.idProd = p.idProd
      JOIN Business b ON pb.idBusns = b.idBusns
      WHERE p.deleteProd = ?
        AND b.idBusns = ?
        AND (
          TRIM(LOWER(p.nameProd)) LIKE CONCAT('%', ?, '%')
          OR TRIM(LOWER(p.categoryProd)) LIKE CONCAT('%', ?, '%')
          OR TRIM(LOWER(p.secondCategoryProd)) LIKE CONCAT('%', ?, '%')
        )
      LIMIT ?;
    `;

  const params = [0, id, trimmedSearch, trimmedSearch, trimmedSearch, 5];

  db.query(query, params, (err, results) => {
    if (err) {
      console.error("[ERROR] DB query failed:", err);
      return res.status(500).json({ error: "Internal server error" });
    }

    if (results.length > 0) {
      return res.status(200).json(results);
    }

    const fallbackQuery = `
        SELECT pb.* FROM ProductBusiness pb
        JOIN Product p ON pb.idProd = p.idProd
        JOIN Business b ON pb.idBusns = b.idBusns
        WHERE p.deleteProd = ?
          AND b.idBusns = ?
        LIMIT ?;
      `;

    const fallbackParams = [0, id, 5];

    db.query(fallbackQuery, fallbackParams, (err2, fallbackResults) => {
      if (err2) {
        console.error("[ERROR] Fallback DB query failed:", err2);
        return res.status(500).json({ error: "Internal server error" });
      }

      if (fallbackResults.length > 0) {
        return res.status(200).json(fallbackResults);
      }

      return res.status(404).json({
        message: `No products found for business ID ${id}`,
      });
    });
  });
});


router.get('/business/products/:id', (req, res) => {

  const { params: { id } } = req

  if (!id)
    return res.status(400).send({ msg: "Bad request", err: "product id param requried" })

  const query = `SELECT * FROM Product WHERE idProd = ? AND deleteProd = ?`

  const params = [id, 0]

  db.query(query, params, (err, results) => {

    if (err) {
      console.error("Database error:", err);
      return res.status(500).json({ error: "Internal server error" });
    }

    if (results && results.length > 0) {
      return res.status(200).json(results);
    } else {
      return res.status(404).json({ message: `No products with ${id} found` })
    }
  })

});



module.exports = router