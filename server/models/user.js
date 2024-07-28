const moongose = require('mongoose');

const userSchema = moongose.Schema({
    name:{
        required: true,
        type: String,
        trim: true,
    },
    email: {
        required: true,
        type: String,
        trim: true,
        validator: {
            
        }
    }
})