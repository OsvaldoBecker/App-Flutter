const express = require('express');
const routes = express.Router();
const controller = require('../controllers/clientController');

routes.route('/clients').get(controller.getAll);
routes.route('/clients/:id').get(controller.get);
routes.route('/clients').post(controller.insert);
routes.route('/clients').put(controller.update);
routes.route('/clients/:id').delete(controller.delete);
routes.route('/clients/filter/:filter').get(controller.filtrate);

module.exports = routes;