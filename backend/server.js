const express = require("express");
const cors = require("cors");
/*const exampleRouter = require("./routes/mobile_app/example/example")
const iaImplementRouter = require("./routes/mobile_app/ai_api/ai_request")
const authRouter = require("./routes/auth/auth")
const groceriesRouter = require("./routes/mobile_app/groceries/groceries")*/
const delivererRouter = require("./routes/gesProfil/create_deliverer")
const TraderRouter = require("./routes/gesProfil/create_trader")

const app = express();
app.use(cors());

const serverPort = process.env.PORT || 3000;

app.use(express.json()); // c'est pour analyser les données JSON envoyées une fois qu'on a fait la requete

/*app.use("/api/example",exampleRouter);
app.use("/api/ai",iaImplementRouter);
app.use("/api/auth",authRouter)
app.use("/api/groceries",groceriesRouter);*/
app.use("/api/gesProfil", delivererRouter); 
app.use("/api/gesProfil", TraderRouter); 


app.listen(serverPort,() => {
    const host = process.env.HOST || "localhost"; 
    console.log(`Server running at http://${host}:${serverPort}/`);
})