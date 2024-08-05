const moongose = require('mongoose');
const { productSchema } = require('./product');

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
        validate: {
            validator: (value) => {
                const re = /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re);
            },
            //whenever validator if false it will run this message.
            message: 'Please enter a valid email address',
        },
    },
    password: {
        required: true,
        type: String,
    },
    address: {
        type: String,
        default: '',
    },
    type: {
        type: String,
        default: 'user',
    },
    cart: [
        {
            product: productSchema,
            quantity : {
                type: Number,
                required: true,
            }
        }
    ]
});

const User = moongose.model('User', userSchema);
module.exports = User;