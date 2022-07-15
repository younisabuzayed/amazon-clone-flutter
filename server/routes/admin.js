const express = require('express');
const admin = require('../middlewares/admin');
const Order = require('../models/order');
const { Product } = require('../models/product');

const adminRouter = express.Router();

//Add Proudct
adminRouter.post('/add-product', admin, async (req, res) => {
    try {
        const { 
            name,
            description,
            price,
            quantity,
            images,
            category,
            userId,
        } = req.body;
        
        let product = new Product({
            name,
            description,
            price: price.toFixed(2),
            quantity: quantity.toFixed(2),
            images,
            category,
            userId,
        });

        product = await product.save();
        res.json(product);
        
    } catch (error) {
        res
          .status(500)
          .json({
            msg: error.message,
          });
    }
});

// Get Product
adminRouter.get('/get-product', admin, async (req, res) =>
{
    try {
        const products = await Product.find();
        res.json(products);
    } catch (error) {
        res
          .status(500)
          .json({
            msg: error.message,
          });
    }
});
// Delete Product
adminRouter.post('/delete-product', admin, async (req, res) =>
{
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);
    } catch (error) {
        res
          .status(500)
          .json({
            msg: error.message,
          });
    }
});

adminRouter.get('/get-orders', admin, async (req, res) =>
{
    try {
        const orders = await Order.find();
        res.json(orders);
    } catch (error) {
        res
          .status(500)
          .json({
            msg: error.message,
          });
    }
});

adminRouter.post('/change-order-status', admin, async (req, res) =>
{
    try {
        const { id, status } = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = order.save();
        res.json(order);
    } catch (error) {
        res
          .status(500)
          .json({
            msg: error.message,
          });
    }
});

adminRouter.get('/analytics', admin, async (req, res) =>
{
    try {

        const orders = await Order.find();
        let totalEarnings = 0.0;

        for (let i = 0; i < orders.length; i++)
        {
            for (let j = 0; j < orders[i].products.length; j++)
            {
                totalEarnings += orders[i].products[j].quantity * orders[i].products[j].product.price;
            }
        }

        // CATEGORY WISE ORDER FETCHING
        let mobileEarnings = await fetchCategoryWiseProduct('Mobiles');
        let essentialsEarnings = await fetchCategoryWiseProduct('Essentials');
        let appliancesEarnings = await fetchCategoryWiseProduct('Appliances');
        let booksEarnings = await fetchCategoryWiseProduct('Books');
        let fashionEarnings = await fetchCategoryWiseProduct('Fashion');

        let earnings = {
            totalEarnings : ~~totalEarnings,
            mobileEarnings,
            essentialsEarnings,
            appliancesEarnings,
            booksEarnings,
            fashionEarnings,
        };
        res.json(earnings);

    } catch (error) {
        res
          .status(500)
          .json({
            msg: error.message,
          });
    }
});

async function fetchCategoryWiseProduct(category)
{
    let earnings = 0.0;
    let categoryOrders = await Order.find({
        'products.product.category': category,
    });
    for (let i = 0; i < categoryOrders.length; i++)
    {
        for (let j = 0; j < categoryOrders[i].products.length; j++)
        {
            earnings += categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price;
        }
    }

    return ~~ earnings;
}
module.exports = adminRouter;