const express = require('express');
const routes = express.Router();
const controller = require('../controllers/employeeController');

routes.route('/employees').get(controller.getAll);
routes.route('/employees/:id').get(controller.get);
routes.route('/employees').post(controller.insert);
routes.route('/employees').put(controller.update);
routes.route('/employees/:id').delete(controller.delete);
routes.route('/employees/filter/:filter').get(controller.filtrate);

module.exports = routes;