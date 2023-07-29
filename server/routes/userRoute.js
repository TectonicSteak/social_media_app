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
            res.json({ status: true, user: { email: email } })
        } catch (err) {
            console.log(err)

            res.json("Something went wrong")
        }
    })
})

router.post('/login', async (req, res) => {
    const { email, password } = req.body;
    const user = await userModel.findOne({ email: email });
    if (!user) {
        res.json({status: false, mgs: "User not found"})
    } else {
        bcrypt.compare(password, user.password).then((match) => {
            if (!match) {
                res, json("Wrong password")
            } else {
                const token = jwt.sign({ email: user.email, id: user.id, user: user, }, "key")
                res.json({
                    status: true,
                    token: token,
                    email: email
                    
                })
            }
        })
    }
})


module.exports = router