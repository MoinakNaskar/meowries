import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool _isZoomed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.mail_outline, color: Colors.white),
              onPressed: () {
                // Handle mail button
              },
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 200), // Space for the header
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(63, 13, 3, 3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(height: 80),
                            Text(
                              '@Catherine12',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'My name is Catherine. I like dancing in the rain and travelling all around the world.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      '1k',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Followers'),
                                  ],
                                ),
                                SizedBox(width: 40),
                                Column(
                                  children: [
                                    Text(
                                      '342',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text('Following'),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle follow button
                                  },
                                  child: Text('Follow'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle message button
                                  },
                                  child: Text('Message'),
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            DefaultTabController(
                              length: 3,
                              child: Column(
                                children: [
                                  TabBar(
                                    labelColor: Colors.black,
                                    unselectedLabelColor: Colors.grey,
                                    tabs: [
                                      Tab(text: 'All'),
                                      Tab(text: 'Photos'),
                                      Tab(text: 'Videos'),
                                    ],
                                  ),
                                  Container(
                                    height: 600,
                                    child: TabBarView(
                                      children: [
                                        // Collage-style grid for All posts
                                        GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 4,
                                            crossAxisSpacing: 4,
                                          ),
                                          itemCount:
                                              6, // Replace with your data count
                                          itemBuilder: (context, index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/back.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              margin: EdgeInsets.all(4),
                                              child: Center(
                                                child: Text(
                                                  'Post $index',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    backgroundColor:
                                                        Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        // Collage-style grid for Photos
                                        GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 4,
                                            crossAxisSpacing: 4,
                                          ),
                                          itemCount:
                                              6, // Replace with your data count
                                          itemBuilder: (context, index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/back.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              margin: EdgeInsets.all(4),
                                              child: Center(
                                                child: Text(
                                                  'Photo $index',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    backgroundColor:
                                                        Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        // Collage-style grid for Videos
                                        GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            mainAxisSpacing: 4,
                                            crossAxisSpacing: 4,
                                          ),
                                          itemCount:
                                              6, // Replace with your data count
                                          itemBuilder: (context, index) {
                                            return Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/back.jpg'),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              margin: EdgeInsets.all(4),
                                              child: Center(
                                                child: Text(
                                                  'Video $index',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    backgroundColor:
                                                        Colors.black54,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: -50,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isZoomed = !_isZoomed;
                          });
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: _isZoomed ? 150 : 100,
                          height: _isZoomed ? 150 : 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/back.jpg'), // Replace with your profile image asset
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
