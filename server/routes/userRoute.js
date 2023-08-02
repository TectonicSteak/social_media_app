const router = require('express').Router()
const bcrypt = require('bcrypt')
const userModel = require('../models/usermodel');
const { json } = require('express');
const jwt = require('jsonwebtoken')
const { validateToken } = require('../middleware/validateToken')


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

router.post('/getusers', async (req, res) => {
    try {
        const result = await userModel.find({})
        res.json(result)

    } catch (err) {
        res.status(400).json("something went wrong")
    }
})


router.post('/follow', validateToken, async (req, res) => {
    const { email } = req.body
    const name1 = req.user.email // this will take two emails, one for the user who wants to follow(userEmail) and one for the user who wants to follow(followEmail)
    
    try {
        const user1 = await userModel.findOne({ email: name1 })
        const user2 = await userModel.findOne({ email: email }) //user1 will follow user2
        console.log(user1.name)
        if (!(user1 || user2)) {
            res.json("Make sure the users exist")
        } else {
            if (!user2.followers.includes(user1.id)) {
                await user2.updateOne({ $push: { followers: user1.id } });
                await user1.updateOne({ $push: { following: user2.id } });
                console.log(`${user1.email} started following ${user2.email}`)
                res.status(200).json(`${user1.email} started following ${user2.email}`);
            } else {
                res.status(403).json("you already follow this user");
            }


        }
    } catch (err) {
        res.json(err)
    }

})

router.post('/getfollowing', validateToken, async (req, res) => {
    try {
        const result = await userModel.find({})
        console.log("getting in")
        console.log(res.header("accessToken"))
        const followersId = req.user.user.followers
        const users = []
        let i = 0
        await Promise.all(
            followersId.map(async (element) => {
                const newUser = await userModel.findById(element);
                users.push(newUser);
            })
        );

        console.log(users)
        res.json(users)
        //res.status(200).json(req.user.following);
    } catch (err) {
        res.status(400).json("something went wrong")
    }
})

module.exports = router