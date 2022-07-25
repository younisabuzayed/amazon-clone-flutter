const express = require('express');
const mongoose  = require('mongoose');
const cors = require('cors');
const adminRouter = require('./routes/admin');
const authRouter = require('./routes/auth');
const firebaseRouter = require('./routes/firebase');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

const api = '/api/v1'
const PORT = 3000;
const DB = ""
const app = express();

// app.use(cors());
// app.options('*', cors());
app.use(express.json());
app.use(`${api}/user`, authRouter);
app.use(`${api}/admin`, adminRouter);
app.use(`${api}/products`, productRouter);
app.use(`${api}/user`, userRouter);
app.use(`${api}/firebase`, firebaseRouter);


//Mongoose 
mongoose
  .connect(DB)
  .then(() =>
  {
      console.log('connection successful');
  })
  .catch((e) => console.log(e));

app.listen(PORT, '0.0.0.0', () =>{
    console.log(`server is running http://localhost:${PORT}`);
})