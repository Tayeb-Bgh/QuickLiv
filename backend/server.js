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
const ordersRouter = require("./routes/mobile_app/orders/orders")

const app = express();
app.use(cors());

const serverPort = process.env.PORT || 3000;

app.use(express.json());


app.use("/api/ai",iaImplementRouter);
app.use("/api/auth",authRouter);
app.use("/api/groceries",groceriesRouter);
app.use("/api/restaurants",restaurantsRouter);
app.use("/api/deliverer",delivererHomeRouter)
app.use("/api/grocery-opened",groceryOpenedRouter);
app.use("/api/restaurant-opened",restaurantOpenedRouter);
app.use("/api/coupon", couponRouter);
app.use("/api/research", researchRouter);
app.use("/api/gesProfil", delivererRouter); 
app.use("/api/gesProfil", TraderRouter);
app.use("/api/favourites",favouritesRouter);
app.use("/api/home", homeRouter);
app.use("/api/orders",ordersRouter);



app.listen(serverPort,() => {
    const host = process.env.HOST || "localhost"; 
    console.log(`Server running at http://${host}:${serverPort}/`);
})