const admin = require("firebase-admin");
const serviceAccount = require("./service-account-key.json");
const express = require("express");
const app = express();
const cors = require("cors");
const { firestore } = require("firebase-admin");
const port = process.env.PORT || 8080;

app.use(cors());
admin.initializeApp({
	credential: admin.credential.cert(serviceAccount),
	databaseURL: "https://hoot-44046.firebaseio.com/",
});

const db = admin.firestore();

app.use(express.json());
app.use(express.urlencoded({
	extended: true
}));

app.post("/adduser", async (req, res) => {
	const docRef = db.collection("UserDB");
	const user = req.body;
	// and ensure that the object does not contain any circular references
	const jsonData = JSON.stringify(user);
	// Convert the JSON string back to a JavaScript object
	const objectData = JSON.parse(jsonData);
	await docRef
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
		.then(function(querySnapshot) {
			querySnapshot.forEach(function(doc) {
				// Do something with the matching document
				console.log(doc.id, " => ", doc.data());
				console.log(JSON.stringify(doc.data(), null, "  "));
				res.status(200).send(JSON.stringify(doc.data()));
			});
		})
		.catch(function(error) {
			res.status(500).send("Error getting document: ", error);
		});
});

app.delete("/deleteuser", async (req, res) => {
	// Get a reference to the collection
	var docRef = db.collection("UserDB");
	// Create a query to find the document you want to delete
	var query = docRef.where("userID", "==", req.body.userID);
	// Delete the matching document
	await query
		.get()
		.then(function(querySnapshot) {
			var batch = db.batch();
			querySnapshot.forEach(function(doc) {
				batch.delete(doc.ref);
			});
			res.status(200);
			return batch.commit();
		})
		.catch(function(error) {
			res.status(500).send("Error removing document: ", error);
		});
});

app.post("/edituser", async (req, res) => {
	// Get a reference to the collection
	var docRef = db.collection("UserDB");

	// Create a query to find the document you want
	var query = docRef.where("userID", "==", req.body.userID);

	// Get the matching document
	await query
		.get()
		.then((querySnapshot) => {
			querySnapshot.forEach((doc) => {
				// Update the document with the new data
				doc.ref.update(req.body);
			});
			// Send a response to the client
			res.sendStatus(200);
		})
		.catch(function(error) {
			console.error("Error getting documents: ", error);
		});
});

//post single advert to firestore cloud database
app.post("/addadvert", async (req, res) => {
	const docRef = db.collection("AdvertDB");
	const advert = req.body;
	advert.id = docRef.doc().id;
	advert.favoriteCount = 0;
	const userDocRef = db.collection("UserDB");
	var query = userDocRef.where("userID", "==", req.body.publisherID);
	// Delete the matching document
	// Get the matching document
	await query
		.get()
		.then(function(querySnapshot) {
			querySnapshot.forEach(function(doc) {
				var data = doc.data();
				// Set properties of the found data
				data.advertIDs.push(advert.id);
				// Update the document with the new data
				doc.ref.set(data);
				// Send the updated data to the client
			});
		})
		.catch(function(error) {
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

app.delete("/deleteadvert", async (req, res) => {
	const advertID = req.body.id;
	const publisherID = req.body.publisherID;
	const favUsers = req.body.userIDs;
	const userDocRef = db.collection("UserDB");

	// Delete the "advertID" value from the "advertIDs" array of the publisher's document
	var publisherQuery = userDocRef.where("userID", "==", publisherID);
	await publisherQuery
		.get()
		.then(function(querySnapshot) {
			// If no matching documents are found, send an error response to the client
			if (querySnapshot.empty) {
				return res.status(404).send({
					error: "Publisher not found"
				});
			}

			// If multiple matching documents are found, send an error response to the client
			if (querySnapshot.size > 1) {
				return res.status(500).send({
					error: "Multiple publishers found"
				});
			}

			// Get the first (and only) matching document
			var publisherDoc = querySnapshot.docs[0];
			var publisherData = publisherDoc.data();

			// Remove the "advertID" value from the "advertIDs" array
			publisherData.advertIDs = publisherData.advertIDs.filter((id) => id !== advertID);

			// Update the document with the modified data
			publisherDoc.ref.set(publisherData);
		})
		.catch(function(error) {
			console.error("Error getting publisher documents: ", error);
			res.status(500).send({
				error: "Error getting publisher documents"
			});
		});

	// Delete the "advertID" value from the "favAdvertIDs" array of each of the favorite users' documents
	if (favUsers) {
		favUsers.forEach((userID) => {
			var userQuery = userDocRef.where("userID", "==", userID);
			userQuery
				.get()
				.then(function(querySnapshot) {
					// If no matching documents are found, send an error response to the client
					if (querySnapshot.empty) {
						return res.status(404).send({
							error: "Favorite user not found"
						});
					}

					// If multiple matching documents are found, send an error response to the client
					if (querySnapshot.size > 1) {
						return res.status(500).send({
							error: "Multiple favorite users found"
						});
					}

					// Get the first (and only) matching document
					var userDoc = querySnapshot.docs[0];
					var userData = userDoc.data();

					// Remove the "advertID" value from the "favAdvertIDs" array
					userData.favAdvertIDs = userData.favAdvertIDs.filter((id) => id !== advertID);

					// Update the document with the modified data
					userDoc.ref.set(userData);
				})
				.catch(function(error) {
					console.error("Error getting favorite user documents: ", error);
					res.status(500).send({
						error: "Error getting favorite user documents"
					});
				});
		});
	}
	const advertDocRef = db.collection("AdvertDB");
	// Create a query to find the document you want to delete
	var advertQuery = advertDocRef.where("id", "==", advertID);
	// Delete the matching document
	// Get the matching document
	await advertQuery
		.get()
		.then((querySnapshot) => {
			querySnapshot.forEach((doc) => {
				// delete the document with the new data
				doc.ref.delete(req.body);
			});
			res.status(200).send();
		})
		.catch(function(error) {
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
		.catch(function(error) {
			console.error("Error getting documents: ", error);
		});
});
app.post("/notifications", async (req, res) => {
	// Get a reference to the UserDB collection
	var userRef = db.collection("UserDB");
	// Create a query to find the document you want
	var userQuery = userRef.where("userID", "==", req.body.userID);
	// Get the matching document
	await userQuery
	  .get()
	  .then(function(userQuerySnapshot) {
		userQuerySnapshot.forEach(function(userDoc) {
		  // Check if the 'notifications' array has a length of 0
		  if (userDoc.data().notifications.length === 0) {
			// Return an empty array
			res.status(200).send(JSON.stringify([], null, "  "));
		  } else {
			// Get a reference to the AdvertDB collection
			var advertRef = db.collection("AdvertDB");
			// Build up an array of the notification documents
			var notifications = [];
			// Iterate over the notifications array
			userDoc.data().notifications.forEach(async function(notificationID, index) {
			  // Create a query to find the details of the notification
			  var advertQuery = advertRef.where("id", "==", notificationID);
			  // Get the matching document
			  await advertQuery
				.get()
				.then(function(advertQuerySnapshot) {
				  advertQuerySnapshot.forEach(function(advertDoc) {
					notifications.push(advertDoc.data());
					// If this is the last notification, send the array in the response
					if (index === userDoc.data().notifications.length - 1) {
					  res.status(200).send(JSON.stringify(notifications, null, "  "));
					}
				  });
				})
				.catch(function(error) {
				  console.error("Error getting document: ", error);
				});
			});
		  }
		});
	  })
	  .catch(function(error) {
		res.status(500).send("Error getting document: ", error);
	  });
  });
  
  
  
  
  

// Get a single advert with the specified ID
app.post("/userfavorites", async (req, res) => {
	// Get a reference to the AdvertDB collection
	const userID = req.body.userID;
	var docRef = db.collection("AdvertDB");
	// Create a query to find the documents you want
	var query = docRef.where("userIDs", "array-contains", userID);
	// Get the matching documents
	await query
	  .get()
	  .then(function(querySnapshot) {
		var favorites = [];
		querySnapshot.forEach(function(doc) {
		  favorites.push(doc.data());
		});
		res.status(200).send(JSON.stringify(favorites, null, "  "));
	  })
	  .catch(function(error) {
		res.status(500).send("Error getting documents: ", error);
	  });
});

app.post("/favplus", async (req, res) => {
	var advertID = req.body.advertID;
	var userID = req.body.userID;
	var publisherID = req.body.publisherID;

	// Query the "UserDB" collection in the database
	var userQuery = db.collection("UserDB").where("userID", "==", userID);
	await userQuery
		.get()
		.then(function(querySnapshot) {
			// If no matching documents are found, send an error response to the client
			if (querySnapshot.empty) {
				return res.status(404).send({
					error: "User not found"
				});
			}

			// If multiple matching documents are found, send an error response to the client
			if (querySnapshot.size > 1) {
				return res.status(500).send({
					error: "Multiple users found"
				});
			}

			// Get the first (and only) matching document
			var userDoc = querySnapshot.docs[0];
			var userData = userDoc.data();

			// Add the "advertID" value to the "favAdvertIDs" array and increment the "favoriteCount" field
			userData.favAdvertIDs.push(advertID);

			// Update the document with the modified data
			userDoc.ref.set(userData);
		})
		.catch(function(error) {
			console.error("Error getting user documents: ", error);
			res.status(500).send({
				error: "Error getting user documents"
			});
		});

	// Create a query to find the document you want
	var publisherQuery = db.collection("UserDB").where("userID", "==", publisherID);
	await publisherQuery
	.get()
	.then(function(querySnapshot) {
		// If no matching documents are found, send an error response to the client
		if (querySnapshot.empty) {
		return res.status(404).send({
			error: "Advert not found"
		});
		}

		// If multiple matching documents are found, send an error response to the client
		if (querySnapshot.size > 1) {
		return res.status(500).send({
			error: "User Not Found."
		});
		}

		// Get the first (and only) matching document
		var publisherDoc = querySnapshot.docs[0];

		// Update the notifications field using the arrayUnion operator
		publisherDoc.ref.update({
		notifications: firestore.FieldValue.arrayUnion(advertID)
		});
	})
	.catch(function(error) {
		console.error("Error getting publisher documents: ", error);
		res.status(500).send({
		error: "Error getting publisher documents"
		});
	});


	// Query the "AdvertDB" collection in the database
	var advertQuery = db.collection("AdvertDB").where("id", "==", advertID);
	await advertQuery
		.get()
		.then(function(querySnapshot) {
			// If no matching documents are found, send an error response to the client
			if (querySnapshot.empty) {
				return res.status(404).send({
					error: "Advert not found"
				});
			}

			// If multiple matching documents are found, send an error response to the client
			if (querySnapshot.size > 1) {
				return res.status(500).send({
					error: "Multiple adverts found"
				});
			}

			// Get the first (and only) matching document
			var advertDoc = querySnapshot.docs[0];
			var advertData = advertDoc.data();

			// Add the "userID" value to the "userIDs" array
			advertData.userIDs.push(userID);
			
			// Update the document with the modified data
			advertDoc.ref.set(advertData);
		})
		.catch(function(error) {
			console.error("Error getting advert documents: ", error);
			res.status(500).send({
				error: "Error getting advert documents"
			});
		});

	// Send a success response to the client
	res.status(200).send();
});


app.post("/favminus", async (req, res) => {
	var advertID = req.body.advertID;
	var userID = req.body.userID;
	var publisherID = req.body.publisherID;

	// Query the "UserDB" collection in the database
	var userQuery = db.collection("UserDB").where("userID", "==", userID);
	await userQuery
		.get()
		.then(function(querySnapshot) {
			// If no matching documents are found, send an error response to the client
			if (querySnapshot.empty) {
				return res.status(404).send({
					error: "User not found"
				});
			}

			// If multiple matching documents are found, send an error response to the client
			if (querySnapshot.size > 1) {
				return res.status(500).send({
					error: "Multiple users found"
				});
			}
			// Get the first (and only) matching document
			var userDoc = querySnapshot.docs[0];
			var userData = userDoc.data();
			// Remove the "advertID" value from the "favAdvertIDs" array and decrement the "favoriteCount" field
			userData.favAdvertIDs = userData.favAdvertIDs.filter((id) => id !== advertID);
			// Update the document with the modified data
			userDoc.ref.set(userData);
		})
		.catch(function(error) {
			console.error("Error getting user documents: ", error);
			res.status(500).send({
				error: "Error getting user documents"
			});
		});
	var publisherQuery = db.collection("UserDB").where("userID", "==", publisherID);
	await publisherQuery
		.get()
		.then(function(querySnapshot) {
			// If no matching documents are found, send an error response to the client
			if (querySnapshot.empty) {
				return res.status(404).send({
					error: "Advert not found"
				});
			}

			// If multiple matching documents are found, send an error response to the client
			if (querySnapshot.size > 1) {
				return res.status(500).send({
					error: "User Not Found."
				});
			}

			// Get the first (and only) matching document
			var publisherDoc = querySnapshot.docs[0];
			var publisherData = publisherDoc.data();
			publisherDoc.ref.update({
				notifications: firestore.FieldValue.arrayRemove(advertID)
			  });
		})
		.catch(function(error) {
			console.error("Error getting publisher documents: ", error);
			res.status(500).send({
				error: "Error getting publisher documents"
			});
		});
		
	// Query the "AdvertDB" collection in the database
	var advertQuery = db.collection("AdvertDB").where("id", "==", advertID);
	await advertQuery
		.get()
		.then(function(querySnapshot) {
			// If no matching documents are found, send an error response to the client
			if (querySnapshot.empty) {
				return res.status(404).send({
					error: "Advert not found"
				});
			}

			// If multiple matching documents are found, send an error response to the client
			if (querySnapshot.size > 1) {
				return res.status(500).send({
					error: "Multiple adverts found"
				});
			}

			// Get the first (and only) matching document
			var advertDoc = querySnapshot.docs[0];
			var advertData = advertDoc.data();

			// Remove the "userID" value from the "userIDs" array
			advertData.userIDs = advertData.userIDs.filter((id) => id !== userID);

			// Update the document with the modified data
			advertDoc.ref.set(advertData);
		})
		.catch(function(error) {
			console.error("Error getting advert documents: ", error);
		})

	res.status(200).send();
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
		.then(function(querySnapshot) {
			querySnapshot.forEach(function(doc) {
				// Do something with the matching document
				console.log(doc.id, " => ", doc.data());
				res.status(200).send(doc.data());
			});
		})
		.catch(function(error) {
			console.error("Error getting documents: ", error);
		});
});

app.post("/useradverts", async (req, res) => {
	// Get a reference to the collection
	var docRef = db.collection("AdvertDB");
	// Create a query to find the document you want
	var query = docRef.where("publisherID", "==", req.body.userID);
	// Get the matching document
	await query
		.get()
		.then((querySnapshot) => {
			// Convert the query snapshot to an array of results
			const tempDoc = [];
			querySnapshot.forEach((doc) => {
				tempDoc.push({
					id: doc.id, 
					...doc.data()
				});
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
		const tempDoc = dataArray.map((doc) => ({
			id: doc.id,
			...doc.data()
		}));
		res.send(JSON.stringify(tempDoc, null, "  "));
	}
});

app.get("/filterByAll/:city/:petType/:price", async (req, res) => {
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
	await query
		.get()
		.then((querySnapshot) => {
			// Convert the query snapshot to an array of results
			const tempDoc = [];
			querySnapshot.forEach((doc) => {
				tempDoc.push({
					id: doc.id,
					...doc.data()
				});
			});
			res.status(200).send(JSON.stringify(tempDoc, null, "  "));
		})
		.catch((error) => {
			// An error occurred while searching the database
			console.error("Error searching the database:", error);
			res.status(404);
		});
});


//exports.app = functions.https.onRequest(app);
app.listen(port, () => {
	console.log("https://localhost:8080");
});