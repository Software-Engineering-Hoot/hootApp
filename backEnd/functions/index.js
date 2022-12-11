const functions = require('firebase-functions');
const admin = require('firebase-admin');
const { getAuth } = require('firebase-admin/auth');
const { connect } = require('firefose');
const serviceAccount = require('./service-account-key.json');
const fs = require('fs')
const express = require('express');
const app = express();
const cors = require('cors');
const { credential } = require('firebase-admin');
//const {advertRoute} = require('./routes/advertRoute.js')
const { Schema } = require('firefose');
const { SchemaTypes } = require('firefose');
const { Model } = require('firefose');

app.use(cors());


admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://hoot-44046.firebaseio.com/"
});

const db = admin.firestore();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.post('/signup', async (req, res) => {
    console.log(req.body);
    const user = {
        first_name: req.body.first_name,
        last_name: req.body.last_name,
        email: req.body.email,
        password: req.body.password
    }
    const userResponse = await admin.auth().createUser({
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        password: user.password
    });
    res.json(userResponse);
    return db.collection('HootDB').doc('Users').create
        .set(users).then(() => {
            res.send("users added to database")
        })
})

//post single advert to firestore cloud database
app.post('/addadvert', (req, res) => {
    const advert = req.body;
    // and ensure that the object does not contain any circular references
    const jsonData = JSON.stringify(advert);

    // Convert the JSON string back to a JavaScript object
    const objectData = JSON.parse(jsonData);
    db.collection('EmircanTest').add(objectData)
    .then(() => {
        // The data was successfully added to the database
        console.log('Data added to the database');
        console.log('REQ BODY', req.body);
        res.status(200);
    })
    .catch((error) => {
        // An error occurred while trying to add the data to the database
        console.error('Error adding data to the database:', error);
        // Set the response status code to 500
        res.status(500);
    });
});



// Get all adverts
app.get('/adverts', (req, res) => {
    const docRef = db.collection('HootDB');
    docRef.get().then((data) => {
        if (data) {
            const tempDoc = []
            data.forEach((doc) => {
                tempDoc.push({ id: doc.id, ...doc.data() })
            })
            res.send(JSON.stringify(tempDoc, null, "  "));
        }
    })
});

/*
app.post('/newadvert', (req, res) => {
    const myadd = new advertModel(req.body);
    const data = {
        id: 0,
        title: 'My Advert',
        petType: 'Dog',
        address: '123 Main Street, Anytown, USA',
        startDate: '2022-12-11',
        endDate: '2022-12-31',
        price: '$100',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        photos: ['https://example.com/photo1.jpg', 'https://example.com/photo2.jpg'],
        favoriteCount: 0
    };

    const docRef = db.collection('EmircanTest');
    docRef.add(myadd)
    .then(() => {
        // The data was successfully added to the database
        console.log('Data added to the database');
    })
    .catch((error) => {
        // An error occurred while trying to add the data to the database
        console.error('Error adding data to the database:', error);
    });
    /*docRef.set({
        // Set the properties of the document here, such as the title, description, etc.
        // You can add as many properties as you need.
        //firestore post

       
    }).then(() => {
        // The data has been successfully added to the database.
        // You can return a response to the client here, such as a success message or the data itself.
    }).catch((error) => {
        // An error occurred while trying to write to the database.
        // You can return an error response to the client here.
    });
}); */



app.listen(8080, () => {
    console.log("listening on port http://localhost:8080")
})

