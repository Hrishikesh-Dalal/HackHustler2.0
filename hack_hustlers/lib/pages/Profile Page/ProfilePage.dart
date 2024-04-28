import 'package:flutter/material.dart';
import 'package:hack_hustlers/pages/Profile%20Page/FetchDataProfile.dart';

class UserCard extends StatelessWidget {
  final String documentId;

  const UserCard({Key? key, required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getUserData(documentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data!;
          return Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Full Name: ${userData['full name']}'),
                    Text('Age: ${userData['age']}'),
                    Text('Email: ${userData['email']}'),
                    Text('Mobile Number: ${userData['mobileNumber']}'),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
