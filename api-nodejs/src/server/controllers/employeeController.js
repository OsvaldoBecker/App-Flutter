const Employee = require('../schemas/employeeSchema');

module.exports = {

    getAll: async (req, res) => {
        await Employee.find((err, objects) => {
            (err ? res.status(400).send(err) : res.status(200).json(objects));
        }).sort({ name: 1 }); // -1 decrescente 1 crescente
    },

    get: async (req, res) => {
        const obj = await Employee.findOne({ _id: req.params.id }, function (err) {
            if (err)
                res.status(400).send(err);
        });
        res.status(200).json(obj);
    },

    insert: async (req, res) => {
        let obj = new Employee(req.body);
        await obj.save((err, obj) => {
            (err ? res.status(400).send(err) : res.status(200).json(obj));
        });
    },

    update: async (req, res) => {
        let obj = new Employee(req.body);
        await Employee.updateOne({ _id: obj._id }, obj, function (err) {
            (err ? res.status(400).send(err) : res.status(200).json(obj));
        });
    },

    delete: async (req, res) => {
        await Employee.deleteOne({ _id: req.params.id }, function (err) {
            (err ? res.status(400).send(err) : res.status(200).json("message : ok"));
        });
    },

    filtrate: async (req, res) => {
        const objects = await Employee.find({
            $or: [
                { name: { $regex: req.params.filter, $options: "i" } },
                { email: { $regex: req.params.filter, $options: "i" } },
            ],
        }, function (err) {
            if (err)
                res.status(400).send(err);
        }).sort({ name: -1 }); // -1 decrescente 1 crescente
        res.json(objects);
    },

};