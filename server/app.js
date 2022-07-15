const express = require('express');
const mongoose  = require('mongoose');
const adminRouter = require('./routes/admin');
const authRouter = require('./routes/auth');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

const api = '/api/v1'
const PORT = 3000;
const DB = "mongodb+srv://admin:admin@cluster0.7nzog.mongodb.net/amazone-clone?retryWrites=true&w=majority"
const app = express();

app.use(express.json());
app.use(`${api}/user`, authRouter);
app.use(`${api}/admin`, adminRouter);
app.use(`${api}/products`, productRouter);
app.use(`${api}/user`, userRouter);


//Mongoose 
mongoose
  .connect(DB)
  .then(() =>
  {
      console.log('connection successful');
  })
  .catch((e) => console.log(e));

app.listen(PORT, '0.0.0.0', () =>{
    console.log('server is running http://localhost:3000');
})