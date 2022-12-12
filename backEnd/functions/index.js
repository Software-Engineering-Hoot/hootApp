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

const actionCodeSettings = {
  handleCodeInApp: true,
  iOS: {
    bundleId: 'com.example.ios',
  },
  android: {
    packageName: 'com.example.android',
    installApp: true,
    minimumVersion: '12',
  },
  // FDL custom domain.
  dynamicLinkDomain: 'coolapp.page.link',
};

//in-progress
app.post('/signin', async (req, res) => {
  try {
    // get the user data from Firestore using the provided username
    const userRecord = await admin.auth().getUserByEmail(req.body.username);
    // check if the provided password matches the user's hashed password
    const success = await admin.auth().verifyPassword(req.body.password, userRecord.passwordHash);
    if (success) {
      console.log("oldu");
    } else {
      // authentication failed, do something...
    }
    // send a JSON response to the client
    res.json({success: success});
  } catch (error) {
    // handle errors
    res.json({success: false, error: error});
  }
});

//in-progress
app.post('/signup', async (req, res) => {
  const docRef = db.collection('UserDB')
  try {
		
    // create a new user in Firestore using the provided username and password
    const userRecord = await admin.auth().createUser({
      email: req.body.username,
      password: req.body.password,
			name: req.body.name,
			surname: req.body.surname
    });
    // send an email verification to the newly created user
    await admin.auth().generateEmailVerificationLink(userRecord.email, actionCodeSettings);
    // do something with the newly created user...
    // and ensure that the object does not contain any circular references
    const jsonData = JSON.stringify(userRecord);
    // Convert the JSON string back to a JavaScript object
    const objectData = JSON.parse(jsonData);
    docRef.add(objectData)
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
    // send a JSON response to the client
    res.json({success: true});
  } catch (error) {
    // handle errors
    res.json({success: false, error: error});
  }
});


//post single advert to firestore cloud database
app.post('/addadvert', (req, res) => {
  const docRef = db.collection('AdvertDB');
  req.body.id = Math.floor(Math.random() * 1000000) + 1;
  req.body.favoriteCount = 0;
  const advert = req.body;

  // and ensure that the object does not contain any circular references
  const jsonData = JSON.stringify(advert);
  // Convert the JSON string back to a JavaScript object
  const objectData = JSON.parse(jsonData);
  docRef.add(objectData)
  .then(() => {
      // The data was successfully added to the database
      console.log('Data added to the database');
      console.log('REQ BODY', req.body);
      res.status(200).send(objectData);
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
  var docRef = db.collection('AdvertDB');
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

app.post('/setprice', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      data.price = req.body.price;
      
      // Update the document with the new data
      doc.ref.set(data);

      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});

app.post('/setpettype', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      data.petType = req.body.petType;
      
      // Update the document with the new data
      doc.ref.set(data);

      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});

app.post('/setstartdate', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      data.startDate = req.body.startDate;
      
      // Update the document with the new data
      doc.ref.set(data);

      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});

app.post('/setenddate', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      data.endDate = req.body.endDate;
      
      // Update the document with the new data
      doc.ref.set(data);

      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});

app.post('/setdescription', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      data.description = req.body.description;
      
      // Update the document with the new data
      doc.ref.set(data);

      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});

app.post('/settitle', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      data.title = req.body.title;
      
      // Update the document with the new data
      doc.ref.set(data);

      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});

app.post('/setphotos', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      data.photos = req.body.photos;
      
      // Update the document with the new data
      doc.ref.set(data);

      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});

app.post('/setaddress', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      data.address = req.body.address;
      
      // Update the document with the new data
      doc.ref.set(data);

      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});

app.post('/setfavorites', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      data.userIDs = req.body.userIDs;
      
      // Update the document with the new data
      doc.ref.set(data);

      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});

app.post('/favplus', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      data.favoriteCount = data.favoriteCount + 1;
      
      // Update the document with the new data
      doc.ref.set(data);

      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});

app.post('/favminus', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

  // Create a query to find the document you want
  var query = docRef.where("id", "==", req.body.id);

  // Get the matching document
  query.get().then(function(querySnapshot) {
    querySnapshot.forEach(function(doc) {
      // Do something with the matching document
      console.log(doc.id, " => ", doc.data());
      var data = doc.data();
      
      // Set properties of the found data
      if(data.favoriteCount > 0){
        data.favoriteCount = data.favoriteCount - 1;
        // Update the document with the new data
        doc.ref.set(data);
      }
      // Send the updated data to the client
      res.status(200).send(data);
    });
  }).catch(function(error) {
    console.error("Error getting documents: ", error);
  });
  
});


// Get a single advert with the specified ID
app.get('/advertdetails', (req, res) => {
  // Get a reference to the collection
  var docRef = db.collection('AdvertDB');

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

app.get('/useradverts', (req, res) => {
  // Get a reference to the collection
	var docRef= db.collection('AdvertDB');

	// Create a query to find the documents with requested location
	var query = docRef.where("publisherID", "==", req.body.publisherID);

	// Get the matching documents
	query.get()
	.then((querySnapshot) => {
    // Convert the query snapshot to an array of results
    const tempDoc = []
    querySnapshot.forEach((doc) => {
        tempDoc.push({ id: doc.id, ...doc.data() })
    })
    res.status(200).send(JSON.stringify(tempDoc, null, "  "));
	})
	.catch((error) => {
    // An error occurred while searching the database
    console.error('Error searching the database:', error);
    res.status(404);
	});
});

// Get all adverts
app.get('/adverts', (req, res) => {
  const docRef = db.collection('AdvertDB');
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
	var docRef= db.collection('AdvertDB');

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
    res.status(200).send(JSON.stringify(tempDoc, null, "  "));
	})
	.catch((error) => {
    // An error occurred while searching the database
    console.error('Error searching the database:', error);
    res.status(404);
	});
});

app.get('/filterbyaddress', (req, res) => {
  // Get a reference to the collection
	var docRef= db.collection('AdvertDB');

	// Create a query to find the documents with requested location
	var query = docRef.where("address", "==", req.body.address);

	// Get the matching documents
	query.get()
	.then((querySnapshot) => {
    // Convert the query snapshot to an array of results
    const tempDoc = []
    querySnapshot.forEach((doc) => {
        tempDoc.push({ id: doc.id, ...doc.data() })
    })
    res.status(200).send(JSON.stringify(tempDoc, null, "  "));
	})
	.catch((error) => {
    // An error occurred while searching the database
    console.error('Error searching the database:', error);
    res.status(404);
	});
});
app.get('/filterbypettype', (req, res) => {
	// Get a reference to the collection
	var docRef= db.collection('AdvertDB');

	// Create a query to find the documents with requested petType
	var query = docRef.where("petType", ">=", req.body.petType);

	// Get the matching documents
	query.get()
	.then((querySnapshot) => {
    // Convert the query snapshot to an array of results
    const tempDoc = []
    querySnapshot.forEach((doc) => {
        tempDoc.push({ id: doc.id, ...doc.data() })
    })
	  res.status(200).send(JSON.stringify(tempDoc, null, "  "));
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

