const functions = require('firebase-functions');
const admin = require('firebase-admin');
const serviceAccount = require('./service-account-key.json');
const fs = require('fs')
const express = require('express');
const app = express();
const cors = require('cors');
app.use(cors());


admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://hoot-44046.firebaseio.com/"
});

const db = admin.firestore();

app.use(express.json());
app.use(express.urlencoded({extended:true}));

app.use('/', (req, res, next) => {
  if (req.headers.authtoken) {
      admin.auth().verifyIdToken(req.headers.authtoken)
      .then(() => {
          next()
      }).catch(() => {
          res.status(403).send('Unauthorized')
      });
  } else {
      res.status(403).send('Unauthorized')
  }
}
)

app.post('/signup', async(req, res) => {
    console.log(req.body);
    const user = {
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        email: req.body.email,
        password: req.body.password

    }
    const userResponse = await admin.auth().createUser({
        email: req.body.email,
        password: req.body.password
    });
    res.json(userResponse);
})

app.get('/', (req, res) => {
    res.send("Hello from index.js ");
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

