const express = require("express");
const cors = require("cors");
const iaImplementRouter = require("./routes/mobile_app/ai_api/ai_request")
const authRouter = require("./routes/auth/auth")
const groceriesRouter = require("./routes/mobile_app/groceries/groceries")
const restaurantsRouter = require("./routes/mobile_app/restaurants/restaurants")
const restaurantOpenedRouter = require("./routes/mobile_app/restaurant_opened/restaurant_opened")
const delivererHomeRouter = require("./routes/mobile_app/deliverer/deliverer_home")
const groceryOpenedRouter = require("./routes/mobile_app/grocery_opened/grocery_opened")
const couponRouter = require("./routes/mobile_app/coupon/coupon")
const researchRouter = require("./routes/mobile_app/research/research")
const delivererRouter = require("./routes/mobile_app/gesProfil/create_deliverer")
const TraderRouter = require("./routes/mobile_app/gesProfil/create_trader")
const favouritesRouter = require("./routes/mobile_app/favourites/favourites")
const homeRouter = require("./routes/mobile_app/home/home")
const paymentRouter = require("./routes/mobile_app/payment/payment")
const ordersRouter = require("./routes/mobile_app/orders/orders");
const delivererHistoryRouter = require("./routes/mobile_app/deleverer_history/deleverer_history")
const http = require("http"); // Ajouté pour Socket.IO
const socketIo = require("socket.io"); // Ajouté
const db = require("./dbConnexion");


const cartRouter = require("./routes/mobile_app/cart/cart")
const app = express();
const server = http.createServer(app); // Modifié pour Socket.IO

// Configuration Socket.IO
const io = socketIo(server, {
  cors: {
    origin: "*" // À adapter en production
  }
});

// Middlewares
app.use(cors());
app.use(express.json());

// Variables pour le suivi des commandes
const commandeIntervals = {}; // { commandeId: intervalId }
const socketsParCommande = {}; // { commandeId: Set(socketId) }

// Gestion des connexions Socket.IO
io.on("connection", (socket) => {
  console.log("Socket connecté :", socket.id);

  socket.on("join_commande_room", (commandeId) => {
    const roomName = `commande_${commandeId}`;
    socket.join(roomName);
    console.log(`Socket ${socket.id} a rejoint la room ${roomName}`);
    
    // Ajouter ce socket à la liste des sockets actifs pour cette commande
    if (!socketsParCommande[commandeId]) {
      socketsParCommande[commandeId] = new Set();
    }
    socketsParCommande[commandeId].add(socket.id);

    // Démarrer le polling s'il n'est pas déjà actif
    if (!commandeIntervals[commandeId]) {
      let lastStatus = null;
      commandeIntervals[commandeId] = setInterval(() => {
        const query = "SELECT statusOrd FROM CustomerOrder WHERE idOrd = ?";
        // Ici vous devriez utiliser votre connexion DB existante
        db.query(query, [commandeId], (err, result) => {
          if (err) {
            console.error(`Erreur MySQL pour commande ${commandeId}:`, err);
            return;
          }

          if (result.length > 0) {
            const newStatus = result[0].statusOrd;
            if (newStatus !== lastStatus) {
              lastStatus = newStatus;
              io.to(roomName).emit("commande_status_update", {
                commandeId,
                status: newStatus,
              });
              console.log(`🔄 Statut commande ${commandeId} mis à jour : ${newStatus}`);
            }
          }
        });
      }, 3000); // Vérification toutes les 3 secondes
    }
  });

  socket.on("disconnect", () => {
    console.log("Socket déconnecté :", socket.id);

    // Nettoyer les rooms
    for (const commandeId in socketsParCommande) {
      socketsParCommande[commandeId].delete(socket.id);

      // S'il n'y a plus aucun socket dans la room, on arrête le polling
      if (socketsParCommande[commandeId].size === 0) {
        clearInterval(commandeIntervals[commandeId]);
        delete commandeIntervals[commandeId];
        delete socketsParCommande[commandeId];
        console.log(`🛑 Arrêt du polling pour la commande ${commandeId} (plus de clients dans la room)`);
      }
    }
  });
});

// Routes existantes
app.use("/api/ai", iaImplementRouter);
app.use("/api/auth", authRouter);
app.use("/api/groceries", groceriesRouter);
app.use("/api/restaurants", restaurantsRouter);
app.use("/api/deliverer", delivererHomeRouter);
app.use("/api/grocery-opened", groceryOpenedRouter);
app.use("/api/restaurant-opened", restaurantOpenedRouter);
app.use("/api/coupon", couponRouter);
app.use("/api/research", researchRouter);
app.use("/api/gesProfil", delivererRouter); 
app.use("/api/gesProfil", TraderRouter);
app.use("/api/favourites", favouritesRouter);
app.use("/api/home", homeRouter);
app.use("/api/cart", cartRouter );
app.use("/api/payment", paymentRouter );
app.use("/api/orders", ordersRouter);
app.use("/api/deliverer", delivererHistoryRouter)


// Démarrer le serveur
const serverPort = process.env.PORT || 3000;
server.listen(serverPort, () => { // Changé de app.listen à server.listen
  const host = process.env.HOST || "localhost"; 
  console.log(`Server running at http://${host}:${serverPort}/`);
});
