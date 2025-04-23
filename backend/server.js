const express = require("express");
const cors = require("cors");
const exampleRouter = require("./routes/mobile_app/example/example")
const iaImplementRouter = require("./routes/mobile_app/ai_api/ai_request")
const couponRouter = require("./routes/mobile_app/coupon_api/coupon_request")
const customerPointRouter = require("./routes/mobile_app/coupon_api/clientPoint_request")



const app = express();
app.use(cors());

const serverPort = process.env.PORT || 3000;



app.use("/api/example", exampleRouter);
app.use("/api/ai", iaImplementRouter);
app.use("/", couponRouter);
app.use("/api", customerPointRouter);



app.listen(serverPort, () => {
    const host = process.env.HOST || "localhost";
    console.log(`Server running at http://${host}:${serverPort}/`);
})