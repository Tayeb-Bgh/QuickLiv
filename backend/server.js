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
// Ajoutez ces variables globales
const activeDeliverers = {}; // { delivererId: Set(orderIds) }
const orderTrackingIntervals = {}; // { delivererId: intervalId }



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

  // Rejoindre la room du livreur et démarrer le tracking des commandes
  socket.on("join_deliverer_room", (delivererId) => {
    const roomName = `deliverer_${delivererId}`;
    socket.join(roomName);
    console.log(`Socket ${socket.id} a rejoint la room ${roomName}`);

    // Initialiser le Set pour ce livreur s'il n'existe pas
    if (!activeDeliverers[delivererId]) {
      activeDeliverers[delivererId] = new Set();
    }

    // Démarrer le polling pour ce livreur s'il n'est pas déjà actif
    if (!orderTrackingIntervals[delivererId]) {
      orderTrackingIntervals[delivererId] = setInterval(() => {
        const query = `SELECT idOrd FROM CustomerOrder WHERE statusOrd = 0`;

        db.query(query, (err, results) => {
          if (err) {
            console.error(`Erreur MySQL pour livreur ${delivererId}:`, err);
            return;
          }

          const currentOrders = new Set(results.map(row => row.idOrd.toString()));
          const previousOrders = activeDeliverers[delivererId] || new Set();

          // Vérifier les nouvelles commandes
          const newOrders = new Set([...currentOrders].filter(x => !previousOrders.has(x)));
          if (newOrders.size > 0) {
            io.to(`deliverer_${delivererId}`).emit('new_orders_available');
            console.log(`Nouvelles commandes disponibles pour livreur ${delivererId}`);
          }

          // Vérifier les commandes prises par d'autres livreurs
          const removedOrders = new Set([...previousOrders].filter(x => !currentOrders.has(x)));
          if (removedOrders.size > 0) {
            console.log("--------------------------------");
            io.to(`deliverer_${delivererId}`).emit('orders_removed', Array.from(removedOrders));
            console.log(`Commandes retirées pour livreur ${delivererId}:`, Array.from(removedOrders));
          }

          // Mettre à jour la liste des commandes actuelles
          activeDeliverers[delivererId] = currentOrders;
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

    for (const delivererId in orderTrackingIntervals) {
      if (socket.rooms.has(`deliverer_${delivererId}`)) {
        // Si c'est le dernier socket pour ce livreur, arrêter le polling
        const socketsInRoom = io.sockets.adapter.rooms.get(`deliverer_${delivererId}`);
        if (!socketsInRoom || socketsInRoom.size === 0) {
          clearInterval(orderTrackingIntervals[delivererId]);
          delete orderTrackingIntervals[delivererId];
          delete activeDeliverers[delivererId];
          console.log(`🛑 Arrêt du polling pour le livreur ${delivererId}`);
        }
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
app.use("/api/cart", cartRouter);
app.use("/api/payment", paymentRouter);
app.use("/api/orders", ordersRouter);



// Démarrer le serveur
const serverPort = process.env.PORT || 3000;
server.listen(serverPort, () => { // Changé de app.listen à server.listen
  const host = process.env.HOST || "localhost";
  console.log(`Server running at http://${host}:${serverPort}/`);
});
