const express = require("express");
const {
  variables,
  postDetailsAboutDay,
  date,
  deleteItems,
  getAboutThatDay,
} = require("../controllers/about_that_day_controller");
const router = express.Router();

router.post("/postDetails", postDetailsAboutDay);
router.get("/getHomeScreenVariables", variables);
router.get("/getDate", date);
router.get("/getAboutThatDay", getAboutThatDay);
router.post("/deleteItems", deleteItems);
module.exports = router;
