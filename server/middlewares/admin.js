const jwt = require('jsonwebtoken');
const User = require('../models/user');

const admin = async(req,res,next) => {
    try{
        const token = req.header('x-auth-token');
        if(!token){
            return res.status(401).json({msg: "No auth token, access denied"});
        }
        
        const isVerified = jwt.verify(token,'passwordKey');
        if(!isVerified){
            return res.status(401).json({msg: 'Token verification failed, authorization failed.'});
        }
        const user = await User.findById(isVerified.id);
        if(user.type == 'user' || user.type == 'seller'){
            return res.status(401).json({masg: 'Permission denied, not anadmin'});
        }
        req.user = isVerified.id;
        req.token = token;

    } catch (err){
        res.status(500).json({error: err.message},);
    }
}