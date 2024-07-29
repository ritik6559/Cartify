const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const mongoose = require("mongoose");
const authRouter = express.Router();

authRouter.post("/api/signup",async (req,res) => {
    try{
        const {name, email, password} = req.body;
        const existingUser = await User.findOne({ email });//we are trying to find the user same email in the user collection.
    if(existingUser){
        return res.status(400).json({msg: 'User with same email already exists'});
    } 

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
        email,
        password : hashedPassword,
        name,
    })

    user = await user.save();
    res.json(user);
    } catch (e) {
        res.status(500).json({error: e.message });
    }
})

module.exports = authRouter;
