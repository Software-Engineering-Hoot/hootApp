const admin = require('firebase-admin');
const serviceAccount = require('./service-account-key.json');
const fs = require('fs')
const express = require('express');
const app = express();
const cors = require('cors');
app.use(cors());

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();


app.get('/', (req, res) => {
    res.send("ZORT");
})

app.get('/usersfromfirebase', (req, res) => {
    const docRef = db.doc("userDB/users");

    docRef.get().then((data) => {
        if (data && data.exists) {
            const responseData = data.data();
            res.send(JSON.stringify(responseData, null, "  "));
        }
    })
});

app.post('/userstofirebase', (req, res) => {
    //firestore post
    const jsonFile = fs.readFileSync('./users.json') //reads from local
    const users = JSON.parse(jsonFile); //json parse 

    return db.collection('userDB').doc('users')
        .set(users).then(() => {
            res.send("!!")
        });
})

app.listen(8080, () => {
    console.log("listening on port http://localhost:8080")
})