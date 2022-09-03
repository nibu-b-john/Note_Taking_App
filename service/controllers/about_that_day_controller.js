const { json } = require("body-parser");
const Datum = require("../models/data");
const SubmitedDate = require("../models/submited_date");

exports.getAboutThatDay = (req, res, next) => {
  res.status(200).json({ message: "hello" });
};

exports.postDetailsAboutDay = (req, res, next) => {
  const title = req.body.title;
  const des = req.body.description;
  const submittedDate = req.body.date;
  let dataToSend, dateToSend;
  req.user
    .createDatum({
      title: title,
      description: des,
    })
    .then((data) => {
      dataToSend = data;
      return data;
    })
    .then((data) => {
      return data.createDate({ date: submittedDate });
    })
    .then((date) => {
      dateToSend = date;
      res.json({ data: dataToSend, date: dateToSend });
    });
};

exports.variables = (req, res, next) => {
  Datum.findAll({}).then((data) => res.json(data));
};

exports.date = (req, res, next) => {
  SubmitedDate.findAll({}).then((date) => res.json(date));
};

exports.deleteItems = (req, res, next) => {
  const id = req.body.id;
  Datum.destroy({ where: { id: id } }).then((_) => {
    res.json("item deleted");
  });
};
