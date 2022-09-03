const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const Datum = sequelize.define(
  "datum",
  {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      allowNull: false,
      primaryKey: true,
    },
    title: {
      type: DataTypes.STRING,
    },
    description: {
      type: DataTypes.STRING,
    },
  },
  { timestamps: false }
);

module.exports = Datum;
