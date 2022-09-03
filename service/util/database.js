const { Sequelize } = require("sequelize");
require("dotenv").config();
const sequelize = new Sequelize(
  process.env.TABLE_NAME,
  process.env.TABLE_OWNER,
  process.env.TABLE_PASSWORD,
  {
    dialect: "mysql",
    host: "localhost",
  }
);
module.exports = sequelize;
