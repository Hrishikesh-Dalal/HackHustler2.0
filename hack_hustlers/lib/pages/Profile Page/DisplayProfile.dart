import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final String? documentId; // Pass document ID from previous widget
  const ProfilePage({Key? key, required this.documentId}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;

  Future<void> getUserData() async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection('User')
          .doc(widget.documentId)
          .get();
      if (docSnapshot.exists) {
        setState(() {
          userData = docSnapshot.data() as Map<String, dynamic>;
        });
      } else {
        // Handle document not found
        print('Document not found');
      }
    } catch (e) {
      // Handle errors
      print('Error retrieving data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData(); // Fetch data on page load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 34, 96, 203),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white, // Set text color to white
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white, // Set icon color to white
        ),

        automaticallyImplyLeading: true,
        // Remove back arrow
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const SizedBox(height: 50.0),
                Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 40.0,
                            backgroundColor: Color.fromARGB(255, 34, 96, 203),
                            child: Text(
                              userData!['full name'][0].toUpperCase(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 248, 248, 248),
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                            'Full Name: ${userData!['full name']}',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: Text(
                            'Email: ${userData!['email']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.phone),
                          title: Text(
                            'Mobile Number: ${userData!['mobileNumber']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(Icons.cake),
                          title: Text(
                            'Age: ${userData!['age']}',
                            style: const TextStyle(fontSize: 16.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
