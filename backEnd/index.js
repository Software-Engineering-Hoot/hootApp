import { getFirestore, doc, deleteDoc } from "firebase/firestore";
import { getFirestore, doc, updateDoc } from "firebase/firestore";

const admin = require('firebase-admin');
const serviceAccount = require('./service-account-key.json');
const fs = require('fs')
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
});

const db = admin.firestore();

//firestore post
function postData() {

    //users.json dosyası okunuyor
    const jsonFile = fs.readFileSync('./users.json')
    const users = JSON.parse(jsonFile);

    //userDB/users içerisine json file'ı bind ediyor.
    return db.collection('userDB').doc('users')
        .set(users).then(() => {
            console.log("Fresh Meat!!");
        });
};
// GET 
function getDataFirestore() {

    try {

        //firestore üzerinde userDB/users pathini referans alıyor
        const docRef = db.doc("userDB/users");

        docRef.get().then((data) => {
            if (data && data.exists) {
                const responseData = data.data();
                console.log(JSON.stringify(responseData, null, "  "));
            }
        })
    } catch (error) {}
}

// DELETE
const docRef = doc(db, "cities", "yftq9RGp4jWNSyBZ1D6L");
deleteDoc(docRef)
.then(() => {
    console.log("Entire Document has been deleted successfully.")
})
.catch(error => {
    console.log(error);
})


//postData();
getDataFirestore();