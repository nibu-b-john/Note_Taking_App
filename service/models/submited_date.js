const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const Date = sequelize.define(
  "date",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    date: DataTypes.STRING,
  },
  { timestamps: false }
);
module.exports = Date;
