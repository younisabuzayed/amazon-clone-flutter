const express = require('express');
const auth = require('../middlewares/auth');
const Order = require('../models/order');
const { Product } = require('../models/product');
const User = require('../models/user');
 
const userRouter = express.Router();

userRouter.post("/add-to-cart", auth, async (req, res) => {
    try {
      const { id } = req.body;
      const product = await Product.findById(id);
      let user = await User.findById(req.user);
  
      if (user.cart.length == 0) {
        user.cart.push({ product, quantity: 1 });
        user.total = product.price;
        } else {
        let isProductFound = false;
        for (let i = 0; i < user.cart.length; i++) {
          if (user.cart[i].product._id.equals(product._id)) {
            isProductFound = true;
          }
        }
  
        if (isProductFound) {
          let producttt = user.cart.find((productt) =>
            productt.product._id.equals(product._id)
          );
          console.log(product.price);
          producttt.total = 0;
          producttt.quantity += 1;
          producttt.total = product.price * producttt.quantity;
          user.total = 0;
          for (let i = 0; i < user.cart.length; i++)
          {
            user.total += user.cart[i].total;
          }
        } else {
          user.cart.push({ product, quantity: 1 });
        }
      }
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
userRouter.delete("/remove-from-cart", auth, async(req, res) => {
    try {
      const { id } = req.body;
      const product = await Product.findById(id);
      let user = await User.findById(req.user);
  
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          if(user.cart[i].quantity == 1)
          {
            user.cart.splice(i, 1);
          }
          if (
            user.cart.length === 0
            ||  user.total <= 0
          )
          {
            user.total = 0;
          }
          else
          {
            user.cart[i].quantity -=1;
            user.cart[i].total -= user.cart[i].product.price;
            user.total -= user.cart[i].product.price;
          }
          
        }
      }
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  }
);

userRouter.post('/save-user-address', auth, async(req, res) =>
{
  try {
    const { address } = req.body;
    let user = await User.findById(req.user);
    user.address = address;
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.post('/order', auth, async(req, res) =>
{
  try {
    const { totalPrice, cart, address } = req.body;
    let user = await User.findById(req.user);
    
    let products = [];
    for ( let i = 0; i < cart.length; i++)
    {
      let product = await Product.findById(cart[i].product._id);
      if (product.quantity >= cart[i].quantity)
      {
        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity});
        await product.save();
      }
      else
      {
        return res
                .status(400)
                .json({ msg: `${product.name} is out of stock!`});
      }
    }
    user.cart = [];
    user.total = 0;
    user = await user.save();

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.user,
      orderedAt: new Date().getTime(),
    });
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.get('/orders/me', auth, async (req, res) => {
  try {
    
    const orders = await Order.find({userId: req.user});
    res.json(orders);
    
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
module.exports = userRouter;