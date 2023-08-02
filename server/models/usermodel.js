const moong = require('mongoose')
const db = require('../config/db')
const mongoose = require('mongoose');

const { Schema } = moong

const userSchema = new Schema({
    email: {
        type: String,
        lowercase: true,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true,
    },
    following: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "user",
    }],
    followers: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "user",
    }]
})

const userModel = db.model('user', userSchema)

module.exports = userModel