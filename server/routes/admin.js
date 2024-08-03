const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const {Product} = require("../models/product");

//ADD PRODUCT

adminRouter.post("/admin/add-product",admin, async(req,res) => {
    try{
        const {name, description, images, quantity, price, category}= req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
        });

        product = await product.save();
        res.json(product);

    } catch (e){
        res.status(500).json({error: e.message});
    }
});


//GET ALL PRODUCTS

adminRouter.get('/admin/get-products',admin, async (req,res) => {
    try{
        const products = await Product.find({});//by passing nothing it means we need all the products
        res.json(products);
    } catch (e){
        res.status(500).json({error: e.message});
    }
});

//DELETING THE PRODUCT
adminRouter.post('/admin/delete-product',admin, async (req,res) => {//post because we need to post the new peoducts after deleting product.
    try{
        const {id} = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch (e){
        res.status(500).json({error: e.message});
    }
});

module.exports = adminRouter;

