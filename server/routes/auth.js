const express = require('express');
const User = require('../models/user');

const authRouter = express.Router();

authRouter.post('/api/signup',async (req,res) => {

    try{
        const {name, email, password} = req.body;
    //req.body will give data as a map
    // {
    //     'name': 
    //     'password': 
    //     'email': 
    // }  
    //{name,email,password} is short hand to get these values.  
    const existingUser = await User.findOne({ email });//we are trying to find the user same email in the user collection.
    if(existingUser){
        return res.status(400).json({msg: 'User with same email already exists'});
    } 

    let user = new User({
        email,
        password,
        name,
    })

    user = await user.save();
    res.json(user);
    } catch (e) {
        res.status(500).json({error: e.message });
    }
    
    
})

module.exports = authRouter;
