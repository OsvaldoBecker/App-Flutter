const { Router } = require("express");
const routes = Router();

const employeeRoute = require("./employeeRoute");
routes.use("/api", employeeRoute);

const clientRoute = require("./clientRoute");
routes.use("/api", clientRoute);

const projectRoute = require("./projectRoute");
routes.use("/api", projectRoute);

module.exports = routes;
