const { Sequelize, DataTypes } = require("sequelize");
const sequelize = require("../util/database");

const User = sequelize.define(
  "user",
  {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      autoIncrement: true,
      primaryKey: true,
    },
    name: {
      type: DataTypes.STRING,
    },
  },
  { timestamps: false }
);

module.exports = User;
