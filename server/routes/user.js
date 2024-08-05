const express = require('express');
const userRouter = express.Router();
const auth = require('../middlewares/auth');
const { Product } = require('../models/product');
const User = require('../models/user');


userRouter.post("/api/add-to-cart",auth, async(req,res) => {
    try{
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);


        if(user.cart.length == 0){
            user.cart.push({product,quantity: 1});
        } else {
            let isProductFound = false;
            for(let i = 0;i < user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){//since we are comparing objects therefore we will be using equals rather than == .
                    isProductFound = true;
                }
            }

            if(isProductFound){
                let producttt = user.cart.find((productt) => productt.product._id.equals(product._id));
                producttt.quantity += 1;
            } else {
                user.cart.push({product,quantity: 1});
            }
        }

        user = await user.save();
        res.json(user);
    } catch (e){
        res.status(500).json({error: e.message});
    }
});

userRouter.delete("/api/remove-from-cart/:id",auth, async(req,res) => {
    try{
        const {id} = req.params;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

            for(let i = 0;i < user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){//since we are comparing objects therefore we will be using equals rather than == .
                    if(user.cart[i].quantity == 1){
                        //if item count is 1 we will delete that product.
                        user.cart.splice(i,1);//deleting the product i is the starting index and 1 signifies how many items i want to delete.
                    } else {
                        //if not quantity is not one we will just decrement it by one.
                        user.cart[i].quantity -= 1;
                    }
                } 
            }
        

        user = await user.save();
        res.json(user);
    } catch (e){
        res.status(500).json({error: e.message});
    }
});


module.exports = userRouter;
