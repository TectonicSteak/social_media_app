const router = require('express').Router()
const bcrypt = require('bcrypt')
const userModel = require('../models/usermodel');
const { json } = require('express');
const jwt = require('jsonwebtoken')


router.post("/register", (req, res) => {
    const { email, password } = req.body;
    bcrypt.hash(password, 10).then(async (hash) => {
        try {
            const newUser = new userModel({email: email, password: hash})
            await newUser.save()
            res.json({ status: "User created", user: { email: email } })
        } catch (err) {
            console.log(err)

            res.json("Something went wrong")
        }
    })
})


module.exports = router