
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
// GET 
function getDataFirestore() {

    try {

        //firestore üzerinde dota/heroes pathini referans alıyor
        const docRef = db.doc("dota/heroes");

        docRef.get().then((data) => {
            if (data && data.exists) {
                const responseData = data.data();
                console.log(JSON.stringify(responseData, null, "  "));
            }
        })
    } catch (error) {}

}



//postData();
getDataFirestore();