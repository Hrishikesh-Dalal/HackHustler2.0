import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ... (Existing code)

Widget buildEmotionsList(List<Map<String, dynamic>> emotionsList) {
  return ListView.builder(
    itemCount: emotionsList.length,
    itemBuilder: (context, index) {
      final noteData = emotionsList[index];
      final note = noteData['note'] as String;
      final timestamp =
          noteData['timestamp'] as Timestamp; // Assuming Timestamp

      return Card(
        color: Color.fromARGB(255, 218, 217, 217),
        child: ListTile(
          splashColor: Color.fromARGB(255, 218, 217, 217),
          title: Text(note),
          subtitle: Text(timestamp
              .toDate()
              .toString()
              .substring(0, 11)), // Format timestamp as needed
        ),
      );
    },
  );
}
