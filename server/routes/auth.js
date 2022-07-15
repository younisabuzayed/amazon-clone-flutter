const express = require("express");
const User = require("../models/user");
const bcryptjs = require('bcrypt');
const jwt = require("jsonwebtoken");
const auth  = require("../middlewares/auth");
const multer = require("multer");
const authRouter = express.Router();


const isEmpty = function(obj) {
    return Object.keys(obj).length === 0;
}

authRouter.post('/signup', multer().none(), async(req, res) =>
{
    const errorHandle = [];
    try {
        const {
            name,
            email,
            password,
        } = req.body;
        
        const existingUser = await User.findOne({ email });
        const hashPassword = await bcryptjs.hash(password, 8);

        //// Validation
        if (isEmpty(name))
        {
            errorHandle.push('The name is empty');

        }
        if (isEmpty(email))
        {
            errorHandle.push('The email is empty');
        }
        if (isEmpty(password))
        {
            errorHandle.push('The password is empty');
        }
        if (isEmpty(name) || isEmpty(email) || isEmpty(password))
        {
            return res
            .status(400)
            .json({
                msg: errorHandle,
            });
        }
        
        if(existingUser)
        {
            return res
                    .status(400)
                    .json({
                        msg: 'User with same email already exits!',
                    });
        }
        let user = new User({
            name,
            email: email.toLowerCase(),
            password: hashPassword,
        });
        const tokenJwt = jwt.sign(
            {id: user._id,},
            "passwordKey"
        );
        
        user = await user.save();

        //return data to user
        res.json({
            ...(user._doc),
            tokenJwt,
        });
    } 
    catch (error) {
        res
          .status(500)
          .json({
              message: error.message,
          })
    }
});


authRouter.post('/signin', multer().none(), async (req, res) =>
{
    try {
        const {email, password } = req.body;

        const user = await User.findOne({ email: email.toLowerCase() });

        if (!user)
        {
            return res.status(400).json({
                msg: 'user with same email does not exits!',
            })
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if (!isMatch)
        {
            return res.status(400).json({
                msg: 'password does not exits!',
            })
        }
        const tokenJwt = jwt.sign(
            {id: user._id,},
            "passwordKey"
        );

        res.status(200).json({tokenJwt, ...user._doc})
        

    } catch (error) {
        res
          .status(500)
          .json({
              message: error.message,
          });
    }
});

authRouter.post('/tokenIsValid', async (req, res) =>
{
    try {

        const token = req.header('x-auth-token');
        if(!token) return  res.json(false);

        const verified = jwt.verify(token, "passwordKey");
        if(!verified) return  res.json(false);
        
        const user = await User.findById(verified.id);
        if(!user) return  res.json(false);

        res.json(true)
    } catch (error) {
        res
          .status(500)
          .json({
              message: error.message,
          });
    }
});
authRouter.get('/', auth, async (req, res) =>
{
    const user = await User.findById(req.user);
    res.json({
        ...(user._doc),
        tokenJwt: req.tokenJwt,
    })
})

module.exports = authRouter;