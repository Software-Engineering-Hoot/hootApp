import express from "express";
import * as advertController from "../controllers/advertController.js";

const router = express.Router();
router.route('/').post(advertController.createAdvert);

export default router;