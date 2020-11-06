const express = require('express');
const routes = express.Router();
const controller = require('../controller/userController');

routes.route('/users').get(controller.getAll);
routes.route('/users/:id').get(controller.get);
routes.route('/users').post(controller.insert);
routes.route('/users').put(controller.update);
routes.route('/users/:id').delete(controller.delete);
routes.route('/users/filter/:filter').get(controller.filtrate);

module.exports = routes;