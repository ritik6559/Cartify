const express = require('express');

const authRouter = express.Router();

authRouter.post('/api/signup',(req,res) => {
    //get the data from client
    const {name, email, password} = req.body;
    //req.body will give data as a map
    // {
    //     'name': 
    //     'password': 
    //     'email': 
    // }  
    //{name,email,password} is short hand to get these values.  
    
    //post that data in database

    
    //return data to the server
})

module.exports = authRouter;
