const jwt = require("jsonwebtoken");
const auth = async (req,res,next) => {
    try{
        const token = req.header('x-auth-token');
        if(!token){
            return res.status(401).json({msg: "No auth token, access denied"});
        }
        const isVerified = jwt.verify(token, 'passwordKey');
        if(!isVerified){
            return res.status(401).json({msg: 'Token verification failed, authorization failed.'});
        }
        req.user = isVerified.id;
        req.token = token;
        next();//to call the next callback function
    } catch (e){
        res.status(500).json({error: e.message});
    }
};

module.exports = auth;