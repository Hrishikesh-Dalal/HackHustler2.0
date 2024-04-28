import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> getUserData(String documentId) async {
  // Get reference to Firestore collection
  final userCollection = FirebaseFirestore.instance.collection('User');

  // Fetch document with the provided ID
  final documentSnapshot = await userCollection.doc(documentId).get();

  if (documentSnapshot.exists) {
    return documentSnapshot.data() as Map<String, dynamic>;
  } else {
    // Handle case where document doesn't exist
    return {}; 
  }
}