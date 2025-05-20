import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                height: 190, // Adjust as needed
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // Cloud SVG at the back
                    Positioned(
                      top: 190,
                      left: 0,
                      child: SvgPicture.asset(
                        'assets/icons/cloud.svg',
                        height: 150, // adjust based on your design
                        color: Color(0xFFfecd85),
                      ),
                    ),

                    // Text on top of the cloud
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ready for some",
                          style: TextStyle(fontSize: 26, color: Colors.brown[800]),
                        ),
                        Text(
                          "Nailspiration?",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.brown[800],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),



              // Expanded section with Firestore List
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFB34126),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  padding: EdgeInsets.all(20),

                  // Use StreamBuilder to listen to Firestore collection
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('boards').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error loading boards'));
                      }

                      if (!snapshot.hasData || snapshot.data == null) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final boards = snapshot.data!.docs;

                      return GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        children: [
                          // NEW BOARD BUTTON
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/new-board');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFD47C6B),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text("+ NEW BOARD",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),

                          // Boards from Firestore
                          ...boards.map((doc) {
                            final data = doc.data()! as Map<String, dynamic>;
                            final title = data['title'] ?? 'No Title';
                            final date = data['date'] ?? 'No Date';

                            return GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/board-detail',
                                  arguments: {
                                    'title': title,
                                    'date' : date,
                                    'id'   : doc.id,
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFD47C6B),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "Created $date",
                                      style: TextStyle(fontSize: 12, color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            bottom: -5,
            left: 0,
            right: 0,
            child: Image.asset(
              'images/miffy-writing.png',
              height: 349,
              fit: BoxFit.contain,
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 70,
              padding: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, -2),
                      blurRadius: 5),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // HOME ICON
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/');
                    },
                    child: Icon(Icons.home, color: Colors.brown),
                  ),

                  // PROFILE ICON
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profile');
                    },
                    child: Icon(Icons.person, color: Colors.brown),
                  ),

                  // CHAT ICON
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/chat');
                    },
                    child: Icon(Icons.chat, color: Colors.brown),
                  ),

                  // CONTACT ICON + TEXT
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/contact-nailartist');
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mail_outline, color: Colors.brown),
                        Text(
                          "Contact your\nnail artist",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 8, color: Colors.brown),
                        ),
                      ],
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