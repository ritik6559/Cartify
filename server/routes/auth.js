const express = require("express");
const User = require("../models/user");
const bcryptjs = require("bcryptjs");
const mongoose = require("mongoose");
const authRouter = express.Router();
const jwt = require("jsonwebtoken");

//signup route
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

//signin route
authRouter.post("/api/signin",async (req,res) => {
    try{
        const {email,password} = req.body;

        const user = await User.findOne({email});
        if(!user){
            return res
                .status(400)
                .json({msg: "User with this email does not exist"});
        }

        //comparing the user's entered password and checking if it matches with the original password(user.password).
        
        const isMatch = bcryptjs.compare(password,user.password);
        if(!isMatch){
            return res
                .status(400)
                .json({msg: "Password doesn't match"});
        }

        const token = jwt.sign({id: user._id},"passwordKey");
        res.json({token, ...user._doc});

    } catch (e){
        res.status(500).json({error: e.message});
    }

});


module.exports = authRouter;
