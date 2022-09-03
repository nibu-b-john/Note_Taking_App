const express = require("express");
const bodyParser = require("body-parser");
const sequelize = require("./util/database");
const User = require("./models/user");
const Date = require("./models/submited_date");
const Datum = require("./models/data");
const getPostRoutes = require("./routes/about_that_day");

const app = express();
app.use(bodyParser.json());

Datum.belongsTo(User, { constraints: true, onDelete: "CASCADE" });
User.hasMany(Datum, { constraints: true, onDelete: "CASCADE" });
Date.belongsTo(Datum, { constraints: true, onDelete: "CASCADE" });
Datum.hasOne(Date, { constraints: true, onDelete: "CASCADE" });
app.use((req, res, next) => {
  User.findByPk(1)
    .then((user) => {
      req.user = user;
      next();
    })
    .catch((err) => console.log(err));
});

app.use(getPostRoutes);

sequelize
  // .sync({ force: true })
  .sync()
  .then(() => {
    return User.findByPk(1);
  })
  .then((user) => {
    if (!user) {
      return User.create({ name: "nibu" });
    }
    return user;
  })
  .then((user) => {
    app.listen(3000, () => {
      console.log("App started at port 3000");
    });
  })
  .catch((err) => console.log(err));

// SET FOREIGN_KEY_CHECKS=1;
