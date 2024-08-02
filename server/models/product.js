const mongoose = require("mongoose");

const productSchema = mongoose.Schema({});

const Product = mongoose.model('Product',productSchema);
module.exports = Product;