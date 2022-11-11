
const admin = require('firebase-admin');
const serviceAccount = require('./service-account-key.json');
const fs = require('fs')
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

//firestore post
function postData() {

    //heroes.json dosyası okunuyor
    const jsonFile = fs.readFileSync('./heroes.json')
    const heroes = JSON.parse(jsonFile);

    //dota/heroes içerisine json file'ı bind ediyor.
    return db.collection('dota').doc('heroes')
        .set(heroes).then(() => {
            console.log("Fresh Meat!!");
        });
};

postData();