const express = require("express");
const cors = require("cors");
const exampleRouter = require("./routes/mobile_app/example/example")
const iaImplementRouter = require("./routes/mobile_app/ai_api/ai_request")
const authRouter = require("./routes/auth/auth")
const groceriesRouter = require("./routes/mobile_app/groceries/groceries")
const restaurantsRouter = require("./routes/mobile_app/restaurants/restaurants")
const groceryOpenedRouter = require("./routes/mobile_app/grocery_opened/grocery_opened")


const app = express();
app.use(cors());

const serverPort = process.env.PORT || 3000;



app.use("/api/example",exampleRouter);
app.use("/api/ai",iaImplementRouter);
app.use("/api/auth",authRouter)
app.use("/api/groceries",groceriesRouter);
app.use("/api/restaurants",restaurantsRouter);
app.use("/api/grocery-opened",groceryOpenedRouter);



app.listen(serverPort,() => {
    const host = process.env.HOST || "localhost"; 
    console.log(`Server running at http://${host}:${serverPort}/`);
})