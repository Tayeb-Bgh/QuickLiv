const express = require("express");
const cors = require("cors");
const exampleRouter = require("./routes/mobile_app/example/example")



const app = express();
app.use(cors());

const serverPort = process.env.PORT || 3000;



app.use("/api/example",exampleRouter);




app.listen(serverPort,() => {
    const host = process.env.HOST || "localhost"; 
    console.log(`Server running at http://${host}:${serverPort}/`);
})