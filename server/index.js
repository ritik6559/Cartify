console.log("Hello, world");

const express = require('express');//importing express

const PORT = 3000;//this is a template

const app = express();
//CREATING AN API

app.listen(PORT,"0.0.0.0" ,() => {
    console.log(`connected at port ${PORT}`);
});

