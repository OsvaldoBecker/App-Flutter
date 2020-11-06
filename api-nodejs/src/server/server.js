// Usar express
const express = require('express');
const app = express();
app.use(express.json());

var cors = require('cors');
app.use(cors());

// Usar o mongo
require("./base/mongo");

// Usar as rotas
const routes = require('./routes/index');
app.use(routes);

// Definir porta para a API de serviços
const port = process.env.PORT || 3000;
app.listen(port, () => { return console.log('API de serviços executando na porta ' + port); });