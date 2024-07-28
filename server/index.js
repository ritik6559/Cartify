//IMPORT FROM PACKAGES
const express = require('express');//importing express
const moongose = require('mongoose');
const User = require('./models/user');

//IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');

//INITIALIZATION
const PORT = 3000;//this is a template
const app = express();
const DB = "mongodb+srv://ritikjoshi741:9456597017ritik@cluster0.s4rbcq6.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

//middleware
app.use(express.json());
app.use(authRouter);


//CONNECTIONS
moongose
    .connect(DB)
    .then(() => {
    console.log('Connection Successful')
}).catch( (e) => {
    console.log(e);
});



app.listen(PORT, () => {
    console.log(`connected at port ${PORT}`);
});

