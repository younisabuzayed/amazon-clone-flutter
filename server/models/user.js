const mongoose = require("mongoose");
const { productSchema } = require("./product");

const userSchema = mongoose.Schema({
    name:
    {
        type: String,
        require: true,
        trim: true,
    },
    email:
    {
        type: String,
        require: true,
        trim: true,
        validate:
        {
            validator: (value) =>
            {
                const re =
                    /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return value.match(re)
            },
            message: "Please enter a valid email address"
        }, 
    },
    password:
    {
        type: String,
        require: true,
    },
    address:
    {
        type: String,
        default: '',
    },
    type:
    {
        type: String,
        default: 'user',
    },
    cart: [
        {
            product: productSchema,
            quantity: {
                type: Number,
                required: true,
            },
            total:
            {
                type: Number,
                default: 0,
            },
        }
    ],
    total:
    {
        type: Number,
        default: 0,
    },
    registrationToken:
    {
        type: String,
        required: true,
    }
});

// userSchema.virtual('id').get(() =>
// {
//     return this._id.toHexString();
// })
// userSchema.set('toJSON',{
//     virtuals: true,
// });
const User = mongoose.model("User", userSchema);

module.exports = User;