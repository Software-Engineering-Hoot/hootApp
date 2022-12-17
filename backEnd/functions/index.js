const functions = require("firebase-functions");
const admin = require("firebase-admin");
const serviceAccount = require("./service-account-key.json");
const express = require("express");
const app = express();
const cors = require("cors");
const port = 8080;

app.use(cors());
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://hoot-44046.firebaseio.com/",
});

const db = admin.firestore();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.post("/adduser", (req, res) => {
  const docRef = db.collection("UserDB");
  const user = req.body;
  // and ensure that the object does not contain any circular references
  const jsonData = JSON.stringify(user);
  // Convert the JSON string back to a JavaScript object
  const objectData = JSON.parse(jsonData);
  docRef
    .add(objectData)
    .then(() => {
      // The data was successfully added to the database
      console.log("Data added to the database");
      console.log("REQ BODY", req.body);
      res.status(200);
    })
    .catch((error) => {
      // An error occurred while trying to add the data to the database
      console.error("Error adding data to the database:", error);
      // Set the response status code to 500
      res.status(500);
    });
});

// Get a single advert with the specified ID
app.post("/getuser", (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection("UserDB");

  // Create a query to find the document you want
  var query = docRef.where("userID", "==", req.body.userID);

  // Get the matching document
  query
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        // Do something with the matching document
        console.log(doc.id, " => ", doc.data());
        console.log(JSON.stringify(doc.data(), null, "  "));
        res.status(200).send(JSON.stringify(doc.data()));
      });
    })
    .catch(function (error) {
      res.status(500).send("Error getting document: ", error);
    });
});

app.delete("/deleteuser", (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection("UserDB");
  // Create a query to find the document you want to delete
  var query = docRef.where("userID", "==", req.body.userID);
  // Delete the matching document
  query
    .get()
    .then(function (querySnapshot) {
      var batch = db.batch();
      querySnapshot.forEach(function (doc) {
        batch.delete(doc.ref);
      });
      res.status(200);
      return batch.commit();
    })
    .catch(function (error) {
      res.status(500).send("Error removing document: ", error);
    });
});

app.post("/edituser", (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection("UserDB");

  // Create a query to find the document you want
  var query = docRef.where("userID", "==", req.body.userID);

  // Get the matching document
  query
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        // Update the document with the new data
        doc.ref.update(req.body);
      });
      // Send a response to the client
      res.sendStatus(200);
    })
    .catch(function (error) {
      console.error("Error getting documents: ", error);
    });
});

//post single location to firestore cloud database
app.post("/addlocation", (req, res) => {
  const docRef = db.collection("LocationDB");
  const location = req.body;

  // and ensure that the object does not contain any circular references
  const jsonData = JSON.stringify(location);
  // Convert the JSON string back to a JavaScript object
  const objectData = JSON.parse(jsonData);
  docRef
    .add(objectData)
    .then(() => {
      // The data was successfully added to the database
      console.log("Data added to the database");
      console.log("REQ BODY", req.body);
      res.status(200);
    })
    .catch((error) => {
      // An error occurred while trying to add the data to the database
      console.error("Error adding data to the database:", error);
      // Set the response status code to 500
      res.status(500);
    });
});

// Get all locations
app.get("/getlocations", async (req, res) => {
  const docRef = db.collection("LocationDB");
  const data = await docRef.get();

  if (data) {
    const dataArray = data.docs;
    const tempDoc = dataArray.map((doc) => ({ id: doc.id, ...doc.data() }));
    res.send(JSON.stringify(tempDoc, null, "  "));
  }
});

//post single advert to firestore cloud database
app.post("/addadvert", (req, res) => {
  const docRef = db.collection("AdvertDB");
  const advert = req.body;
  advert.id = docRef.doc().id;
  advert.favoriteCount = 0;
  const userDocRef = db.collection("UserDB");
  var query = userDocRef.where("userID", "==", req.body.publisherID);
  // Delete the matching document
  // Get the matching document
  query
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        var data = doc.data();
        // Set properties of the found data
        data.advertIDs.push(advert.id);
        // Update the document with the new data
        doc.ref.set(data);
        // Send the updated data to the client
      });
    })
    .catch(function (error) {
      console.error("Error getting documents: ", error);
    });
  // and ensure that the object does not contain any circular references
  const jsonData = JSON.stringify(advert);
  // Convert the JSON string back to a JavaScript object
  const objectData = JSON.parse(jsonData);
  docRef
    .add(objectData)
    .then(() => {
      // The data was successfully added to the database
      console.log("Data added to the database");
      console.log("REQ BODY", req.body);
      res.status(200).send(advert);
    })
    .catch((error) => {
      // An error occurred while trying to add the data to the database
      console.error("Error adding data to the database:", error);
      // Set the response status code to 500
      res.status(500);
    });
});

// Delete a single advert from the Firestore cloud database
// in every deletion user favorites should be updated
app.delete("/deleteadvert", (req, res) => {
  const docRef = db.collection("AdvertDB");
  const advert = req.body;
  let favUsers = req.body.userIDs;
  const userDocRef = db.collection("UserDB");
  var query = userDocRef.where("userID", "==", advert.publisherID);
  // Delete the matching document
  // Get the matching document
  query
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        var data = doc.data();
        // Set properties of the found data
        data.advertIDs.pop(advert.id);
        // Update the document with the new data
        doc.ref.set(data);
        // Send the updated data to the client
        res.status(200);
      });
    })
    .catch(function (error) {
      console.error("Error getting documents: ", error);
    });

  if (favUsers) {
    favUsers.forEach((element) => {
      var query = userDocRef.where("userID", "==", element);
      query
        .get()
        .then(function (querySnapshot) {
          querySnapshot.forEach(function (doc) {
            var data = doc.data();
            // Set properties of the found data
            data.favAdvertIDs.pop(element);
            // Update the document with the new data
            doc.ref.set(data);
            // Send the updated data to the client
            res.status(200);
          });
        })
        .catch(function (error) {
          console.error("Error getting documents: ", error);
        });
    });
  }

  // Create a query to find the document you want to delete
  var query2 = docRef.where("id", "==", advert.id);
  // Delete the matching document
  // Get the matching document
  query2
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        // delete the document with the new data
        doc.ref.delete(advert);
      });
      // Send a response to the client
      res.status(200).send(advert);
    })
    .catch(function (error) {
      console.error("Error getting documents: ", error);
    });
});

app.post("/editadvert", (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection("AdvertDB");
  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);
  // Get the matching document
  query
    .get()
    .then((querySnapshot) => {
      querySnapshot.forEach((doc) => {
        // Update the document with the new data
        doc.ref.update(req.body);
      });
      // Send a response to the client
      res.sendStatus(200);
    })
    .catch(function (error) {
      console.error("Error getting documents: ", error);
    });
});

// Get a single advert with the specified ID
app.post("/getfavs", (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection("UserDB");

  // Create a query to find the document you want
  var query = docRef.where("userID", "==", req.body.userID);

  // Get the matching document
  query
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        // Do something with the matching document
        console.log(doc.id, " => ", doc.data());
        console.log(JSON.stringify(doc.data(), null, "  "));
        res.status(200).send(JSON.stringify(doc.data().favAdvertIDs));
      });
    })
    .catch(function (error) {
      res.status(500).send("Error getting document: ", error);
    });
});

app.post("/userfavorites", (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection("UserDB");
  // Create a query to find the documents with requested location
  var query = docRef.where("userID", "==", req.body.userID);
  // Get the matching documents
  query
    .get()
    .then((querySnapshot) => {
      // Convert the query snapshot to an array of results
      const tempDoc = [];
      querySnapshot.forEach((doc) => {
        tempDoc.push({ id: doc.id, ...doc.data() });
      });
      res.status(200).send(JSON.stringify(tempDoc, null, "  "));
    })
    .catch((error) => {
      // An error occurred while searching the database
      console.error("Error searching the database:", error);
      res.status(404);
    });
});

app.post("/favplus", (req, res) => {
  var advertID = req.body.advertID;
  var userID = req.body.userID;
  var docRef = db.collection("UserDB");
  var query = docRef.where("userID", "==", req.body.userID);
  query
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        var data = doc.data();

        // Set properties of the found data
        data.favAdvertIDs.push(advertID);
        data.favoriteCount = data.favoriteCount + 1;

        // Update the document with the new data
        doc.ref.set(data);
      });
    })
    .catch(function (error) {
      console.error("Error getting documents: ", error);
    });
  var advertDocRef = db.collection("AdvertDB");
  var query2 = advertDocRef.where("id", "==", advertID);
  query2
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        var data = doc.data();

        // Set properties of the found data
        data.userIDs.push(userID);

        // Update the document with the new data
        doc.ref.set(data);
        res.status(200).send(data);
      });
    })
    .catch(function (error) {
      console.error("Error getting documents: ", error);
    });
  res.status(200);
});

app.post("/favminus", (req, res) => {
  var advertID = req.body.advertID;
  var userID = req.body.userID;
  var docRef = db.collection("UserDB");
  var query = docRef.where("userID", "==", req.body.userID);
  query
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        var data = doc.data();

        // Set properties of the found data
        data.favAdvertIDs.pop(advertID);
        if (data.favoriteCount > 0) {
          data.favoriteCount = data.favoriteCount - 1;
        }

        // Update the document with the new data
        doc.ref.set(data);

        // Send the updated data to the client
        res.status(200).send(data);
      });
    })
    .catch(function (error) {
      console.error("Error getting documents: ", error);
    });
  var advertDocRef = db.collection("AdvertDB");
  var query2 = advertDocRef.where("id", "==", advertID);
  query2
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        var data = doc.data();

        // Set properties of the found data
        data.userIDs.pop(userID);

        // Update the document with the new data
        doc.ref.set(data);

        // Send the updated data to the client
        res.status(200).send(data);
      });
    })
    .catch(function (error) {
      console.error("Error getting documents: ", error);
    });
});

// Get a single advert with the specified ID
app.get("/advertdetails", (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection("AdvertDB");
  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);
  // Get the matching document
  query
    .get()
    .then(function (querySnapshot) {
      querySnapshot.forEach(function (doc) {
        // Do something with the matching document
        console.log(doc.id, " => ", doc.data());
        res.status(200).send(doc.data());
      });
    })
    .catch(function (error) {
      console.error("Error getting documents: ", error);
    });
});

app.post("/useradverts", (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection("AdvertDB");
  // Create a query to find the documents with requested location
  var query = docRef.where("publisherID", "==", req.body.userID);
  // Get the matching documents
  query
    .get()
    .then((querySnapshot) => {
      // Convert the query snapshot to an array of results
      const tempDoc = [];
      querySnapshot.forEach((doc) => {
        tempDoc.push({ id: doc.id, ...doc.data() });
      });
      res.status(200).send(JSON.stringify(tempDoc, null, "  "));
    })
    .catch((error) => {
      // An error occurred while searching the database
      console.error("Error searching the database:", error);
      res.status(404);
    });
});

// Get all adverts
app.get("/adverts", async (req, res) => {
  const docRef = db.collection("AdvertDB");
  const data = await docRef.get();
  if (data) {
    const dataArray = data.docs;
    const tempDoc = dataArray.map((doc) => ({ id: doc.id, ...doc.data() }));
    res.send(JSON.stringify(tempDoc, null, "  "));
  }
});

app.get("/filterbyprice/:min/:max", (req, res) => {
  // Get the min and max values from the query string parameters
  var min = req.params.min;
  var max = req.params.max;
  // Get a reference to the collection
  var docRef = db.collection("AdvertDB");

  // Create a query to find the documents with prices between the min and max
  var query = docRef
    .where("price", ">=", Number(min))
    .where("price", "<=", Number(max));
  // Get the matching documents
  query
    .get()
    .then((querySnapshot) => {
      // Convert the query snapshot to an array of results
      const tempDoc = [];
      querySnapshot.forEach((doc) => {
        tempDoc.push({ id: doc.id, ...doc.data() });
      });
      res.status(200).send(JSON.stringify(tempDoc, null, "  "));
    })
    .catch((error) => {
      // An error occurred while searching the database
      console.error("Error searching the database:", error);
      res.status(404);
    });
});

app.get("/filterByAll/:city/:petType/:price", (req, res) => {
  // Get a reference to the collection
  const address = req.params.city;
  const price = req.params.price;
  const petType = req.params.petType;

  var docRef = db.collection("AdvertDB");

  // Create a query to find the documents with prices between the min and max
  var query = docRef;
  if (address != "all") {
    query = query.where("address", "==", address);
  }

  if (petType != "all") {
    query = query.where("petType", "==", petType);
  }

  if (price != 0) {
    query = query.where("price", "<=", Number(price));
  }
  // Get the matching documents
  query
    .get()
    .then((querySnapshot) => {
      // Convert the query snapshot to an array of results
      const tempDoc = [];
      querySnapshot.forEach((doc) => {
        tempDoc.push({ id: doc.id, ...doc.data() });
      });
      res.status(200).send(JSON.stringify(tempDoc, null, "  "));
    })
    .catch((error) => {
      // An error occurred while searching the database
      console.error("Error searching the database:", error);
      res.status(404);
    });
});

app.get("/filterbyaddress/:address", (req, res) => {
  // Get a reference to the collection
  const address = req.params.address;
  var docRef = db.collection("AdvertDB");

  // Create a query to find the documents with requested location
  var query = docRef.where("address", "==", address);

  // Get the matching documents
  query
    .get()
    .then((querySnapshot) => {
      // Convert the query snapshot to an array of results
      const tempDoc = [];
      querySnapshot.forEach((doc) => {
        tempDoc.push({ id: doc.id, ...doc.data() });
      });
      res.status(200).send(JSON.stringify(tempDoc, null, "  "));
    })
    .catch((error) => {
      // An error occurred while searching the database
      console.error("Error searching the database:", error);
      res.status(404);
    });
});
app.get("/filterbypettype/:petType", (req, res) => {
  var petType = req.params.petType;
  // Get a reference to the collection
  var docRef = db.collection("AdvertDB");

  // Create a query to find the documents with requested petType
  var query = docRef.where("petType", "==", req.body.petType);

  // Get the matching documents
  query
    .get()
    .then((querySnapshot) => {
      // Convert the query snapshot to an array of results
      const tempDoc = [];
      querySnapshot.forEach((doc) => {
        tempDoc.push({ id: doc.id, ...doc.data() });
      });
      res.status(200).send(JSON.stringify(tempDoc, null, "  "));
    })
    .catch((error) => {
      // An error occurred while searching the database
      console.error("Error searching the database:", error);
      res.status(404);
    });
});

app.listen(8080, () => {
  console.log("listening on the port http://localhost:8080");
});
