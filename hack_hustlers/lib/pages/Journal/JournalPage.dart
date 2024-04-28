import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hack_hustlers/components/bottomNavBar.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/FetchFromFirebase.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/NegativePage.dart';
import 'package:hack_hustlers/pages/Journal/JournalPages/PositivePage.dart';
import 'package:hack_hustlers/pages/home.dart';

// ... (other imports)

class Journal extends StatefulWidget {
  final String? id;

  Journal({required this.id});

  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  List<Map<String, dynamic>> positiveEmotionsList = [];
  List<Map<String, dynamic>> negativeEmotionsList = [];

  @override
  void initState() {
    super.initState();
    fetchPositiveEmotions(); // Fetch data on app launch
    fetchNegativeEmotions();
  }

  Future<void> fetchPositiveEmotions() async {
    try {
      positiveEmotionsList = await getPositiveEmotions(widget.id);
      setState(() {}); // Update state to rebuild with fetched data
    } catch (error) {
      // Handle error (e.g., display error message)
      print("Error fetching positive emotions: $error");
    }
  }

  Future<void> fetchNegativeEmotions() async {
    try {
      negativeEmotionsList = await getNegativeEmotions(widget.id);
      setState(() {}); // Update state to rebuild with fetched data
    } catch (error) {
      // Handle error (e.g., display error message)
      print("Error fetching negative emotions: $error");
    }
  }

  Widget buildEmotionsList(List<Map<String, dynamic>> emotions, int num) {
    return ListView.builder(
      itemCount: emotions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            color: Color.fromARGB(226, 181, 218, 251),
            child: ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        emotions[index]['timestamp']
                            .toString()
                            .substring(0, 11),
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      content: SingleChildScrollView(
                        // Allow scrolling for long content
                        child: Text(
                          emotions[index]['note'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'),
                        ),
                      ],
                      shape: RoundedRectangleBorder(
                        // Add rounded corners
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    );
                  },
                );
              },
              title: Text(
                emotions[index]['timestamp'].toString().substring(0, 11),
                style: TextStyle(fontSize: 14.0),
              ),
              subtitle: Text(
                emotions[index]['note'],
                style: const TextStyle(fontSize: 18.0),
                maxLines: 2,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal',
          style: TextStyle(color: Color.fromARGB(255, 211, 211, 211)),
        ),
        backgroundColor: Color.fromARGB(255, 34, 96, 203),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavBar(),
                )); // Navigate back
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PositivePage(
                                id: widget.id,
                              )),
                    );
                  },
                  child: Card(
                    color: Color.fromARGB(255, 255, 227, 44),
                    child: Container(
                      width: 170,
                      height: 200,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Something you are feeling estatic about...',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NegativePage(
                                id: widget.id,
                              )),
                    );
                  },
                  child: Card(
                    color: Color.fromARGB(255, 230, 104, 95),
                    child: Container(
                      width: 170,
                      height: 200,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Something you are feeling down about...',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0,
                                color:
                                    const Color.fromARGB(211, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Your Positive Emotions',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: positiveEmotionsList.isNotEmpty
                ? buildEmotionsList(positiveEmotionsList, 0)
                : Center(child: Text('No history yet')),
          ),
          SizedBox(height: 20),
          Text(
            'Your Negative Emotions here',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: negativeEmotionsList.isNotEmpty
                ? buildEmotionsList(negativeEmotionsList, 1)
                : Center(child: Text('No history yet')),
          ),
        ],
      ),
    );
  }
}
