const {verify} = require('jsonwebtoken')

const validateToken = (req, res, next) => {
    const accessToken = req.header("accessToken")
    console.log(req.header("accessToken") + "hello")
    console.log("testing access token")
    //console.log(req.header("test"));
    if(!accessToken) {
        return res.json({error: "User is not logged in (validation)"})
    }

    try {
        const validToken = verify(accessToken, "key")
        if(validToken){
            req.user = validToken 
            //console.log(validToken.email)
            return next() 
        }
    } catch (err) {
        return res.json({error: err});
    }
} 

module.exports = {validateToken}