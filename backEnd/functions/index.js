const functions = require('firebase-functions');
const admin = require('firebase-admin');
const serviceAccount = require('./service-account-key.json');
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
app.use(express.urlencoded({ extended: true }));

//post single advert to firestore cloud database
app.post('/addadvert', (req, res) => {
    const advert = req.body;
    // and ensure that the object does not contain any circular references
    const jsonData = JSON.stringify(advert);

    // Convert the JSON string back to a JavaScript object
    const objectData = JSON.parse(jsonData);
    db.collection('HootDB').add(objectData)
    .then(() => {
        // The data was successfully added to the database
        console.log('Data added to the database');
        console.log('REQ BODY', req.body);
        res.status(200).send();
    })
    .catch((error) => {
        // An error occurred while trying to add the data to the database
        console.error('Error adding data to the database:', error);
        // Set the response status code to 500
        res.status(500);
    });
});

// Delete a single advert from the Firestore cloud database
app.delete('/deleteadvert', (req, res) => {
    // Get a reference to the collection
  var docRef = db.collection("HootDB");
  // Create a query to find the document you want to delete
  var query = docRef.where("id", "==", req.body.id);
  // Delete the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      doc.ref.delete();
    });
  }).then(function() {
    console.log("Document successfully deleted!");
    res.status(200).send(req.body + "Document successfully deleted!");
  }).catch(function(error) {
    res.status(500).send("Error removing document: ", error);
  });

});

// Get a single advert with the specified ID
app.get('/advertdetails', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('HootDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      res.status(200).send(doc.data());
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
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


app.get('/filterbyprice', (req, res) => {
	// Get the min and max prices from the body parameters
	const minPrice = req.body.min;
	const maxPrice = req.body.max;

	// Get a reference to the collection
	var docRef= db.collection("HootDB");

	// Create a query to find the documents with prices between the min and max
	var query = docRef.where("price", ">=", minPrice).where("price", "<=", maxPrice);

	// Get the matching documents
	query.get()
	.then((querySnapshot) => {
			// Convert the query snapshot to an array of results
			const tempDoc = []
			querySnapshot.forEach((doc) => {
					tempDoc.push({ id: doc.id, ...doc.data() })
			})
			res.send(JSON.stringify(tempDoc, null, "  "));
	})
	.catch((error) => {
			// An error occurred while searching the database
			console.error('Error searching the database:', error);
			res.status(404);
	});
});

app.get('/filterbyaddress', (req, res) => {
	// Get the min and max prices from the body parameters
	const minPrice = req.body.min;
	const maxPrice = req.body.max;

	// Get a reference to the collection
	var docRef= db.collection("HootDB");

	// Create a query to find the documents with prices between the min and max
	var query = docRef.where("address", "==", req.body.address);

	// Get the matching documents
	query.get()
	.then((querySnapshot) => {
			// Convert the query snapshot to an array of results
			const tempDoc = []
			querySnapshot.forEach((doc) => {
					tempDoc.push({ id: doc.id, ...doc.data() })
			})
			res.send(JSON.stringify(tempDoc, null, "  "));
	})
	.catch((error) => {
			// An error occurred while searching the database
			console.error('Error searching the database:', error);
			res.status(404);
	});
});
app.get('/filterbypettype', (req, res) => {
	// Get the min and max prices from the body parameters
	const minPrice = req.body.min;
	const maxPrice = req.body.max;

	// Get a reference to the collection
	var docRef= db.collection("HootDB");

	// Create a query to find the documents with prices between the min and max
	var query = docRef.where("petType", ">=", req.body.petType);

	// Get the matching documents
	query.get()
	.then((querySnapshot) => {
	// Convert the query snapshot to an array of results
	const tempDoc = []
	querySnapshot.forEach((doc) => {
			tempDoc.push({ id: doc.id, ...doc.data() })
	})
	res.send(JSON.stringify(tempDoc, null, "  "));
	})
	.catch((error) => {
	// An error occurred while searching the database
	console.error('Error searching the database:', error);
	res.status(404);
	});
});

app.listen(8080, () => {
    console.log("listening on the port http://localhost:8080")
})

