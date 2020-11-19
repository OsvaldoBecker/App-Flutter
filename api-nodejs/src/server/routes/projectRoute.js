const express = require('express');
const routes = express.Router();
const controle = require('../controllers/projectController');

routes.route('/projects').get(controle.getAll);
routes.route('/projects/:id').get(controle.get);
routes.route('/projects').post(controle.insert);
routes.route('/projects').put(controle.update);
routes.route('/projects/:id').delete(controle.delete);
routes.route('/projects/filter/:filter').get(controle.filtrate);
module.exports = routes;
