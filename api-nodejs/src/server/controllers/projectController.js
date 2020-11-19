const Project = require('../schemas/projectSchema');

module.exports = {

  getAll: async (req, res) => {
    await Project.find((err, objects) => {
      (err ? res.status(400).send(`${err}`) : res.status(200).json(objects));
    }).populate(['client', 'responsible']).sort({ title: 1 }); // -1 decrescente 1 crescente
  },

  get: async (req, res) => {
    const object = await Project.findOne({ _id: req.params.id }, function (err) {
      if (err)
        res.status(400).send(`${err}`);
    });
    res.status(200).json(object);
  },

  insert: async (req, res) => {
    let object = new Project(req.body);
    await object.save((err, object) => {
      (err ? res.status(400).send(`${err}`) : res.status(200).json(object));
    });
  },

  update: async (req, res) => {
    let object = new Project(req.body);
    await Project.updateOne({ _id: object._id }, object, function (err) {
      (err ? res.status(400).send(`${err}`) : res.status(200).json(object));
    });
  },

  delete: async (req, res) => {
    await Project.deleteOne({ _id: req.params.id }, function (err) {
      (err ? res.status(400).send(`${err}`) : res.status(200).json("status: ok"));
    });
  },

  filtrate: async (req, res) => {
    const objects = await Project.find({
      $or: [
        { title: { $regex: req.params.filter, $options: "i" } },
      ],
    }, function (err) {
      if (err)
        res.status(400).send(`${err}`);
    }).sort({ title: -1 }); // -1 decrescente 1 crescente
    res.json(objects);
  },
};
