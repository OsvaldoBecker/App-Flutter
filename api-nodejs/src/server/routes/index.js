const { Router } = require("express");
const routes = Router();

const userRoute = require("./userRoute");

routes.use("/api", userRoute);
module.exports = routes;