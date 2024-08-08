import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:memow/features/home_memoworld/screens/post_card.dart';
import 'package:memow/features/home_memoworld/screens/story_circle.dart';
import 'package:memow/layout/community_page.dart';
import 'package:memow/layout/menu_page.dart';
import 'package:memow/screens/spinningwheel.dart';
import 'package:memow/utils/utils.dart';

// Sample data for posts
final List<Post> trendingPosts = [
  Post(
    username: 'Atul',
    userImage: 'assets/logo.png',
    postMedia: ['assets/back.jpg', 'assets/back.jpg'],
    caption: 'what the heck',
    likes: 50,
    comments: 10,
  ),
  // Add more posts here...
];

final List<Post> followedCreatorsPosts = [
  Post(
    username: 'Doe',
    userImage: 'assets/user2.jpg',
    postMedia: ['assets/post2.jpg'],
    caption: 'Check this out!',
    likes: 100,
    comments: 15,
  ),
  // Add more posts here...
];

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen-screen';
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of widgets for the TabBarView
  static final List<Widget> _widgetOptions = <Widget>[
    const TrendingSection(),
    const TopCreatorsSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const GradientText(
            'MEMOW',
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(250, 236, 208, 52),
                Color.fromARGB(255, 239, 91, 23),
              ],
            ),
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const AccountDetailsSheet();
                  },
                );
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 1.0, vertical: 1.0),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: const Icon(Icons.search),
                        hintText: 'Find best MEMOW partner for you',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const StoriesSection(),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          color:
                              Color.fromARGB(36, 99, 99, 98).withOpacity(0.3),
                          child: const TabBar(
                            tabs: [
                              Tab(text: 'TRENDING'),
                              Tab(text: 'FOLLOWING'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: _widgetOptions.map((Widget widget) {
                  return SingleChildScrollView(
                    child: widget,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: Color.fromARGB(242, 12, 2, 2),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(eccentricity: 1),
          backgroundColor: Color.fromARGB(195, 15, 12, 4),
          focusColor: Color.fromARGB(255, 242, 207, 34),
          elevation: 100,
          mouseCursor: SystemMouseCursors.click,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MemoBookingWidget(),
              ),
            );
          },
          tooltip: 'Memow Booking',
          child: const Icon(Icons.book),
        ),
        bottomNavigationBar: Container(
          height: 80,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: BottomNavigationBar(
                backgroundColor: Colors.white.withOpacity(0.3),
                selectedItemColor: Color.fromARGB(241, 243, 202, 19),
                unselectedItemColor: Colors.white,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                onTap: (index) {
                  if (index == 0) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CommunityPostPage(),
                      ),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MemowSpectrumPage(),
                      ),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MenuPage(),
                      ),
                    );
                  }
                },
                items: const [
                  BottomNavigationBarItem(
                    backgroundColor: Color.fromARGB(45, 202, 201, 198),
                    icon: ImageIcon(
                      AssetImage('assets/icons/home.png'),
                      size: 40,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/icons/location.png'),
                      size: 40,
                    ),
                    label: 'Clips',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/icons/spectrum.png'),
                      size: 40,
                    ),
                    label: 'Spectrum',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/icons/find_friends.png'),
                      size: 40,
                    ),
                    label: 'Find',
                  ),
                  BottomNavigationBarItem(
                    icon: ImageIcon(
                      AssetImage('assets/icons/menu.png'),
                      size: 45,
                    ),
                    label: 'Menu',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AccountDetailsSheet extends StatelessWidget {
  const AccountDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('User Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Bookings'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.monetization_on),
            title: const Text('Memow Coins'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: trendingPosts.map((post) {
        return InstagramPost(
          username: post.username,
          userImage: post.userImage,
          postMedia: post.postMedia,
          caption: post.caption,
          likes: post.likes,
          comments: post.comments,
        );
      }).toList(),
    );
  }
}

class TopCreatorsSection extends StatelessWidget {
  const TopCreatorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: followedCreatorsPosts.map((post) {
        return InstagramPost(
          username: post.username,
          userImage: post.userImage,
          postMedia: post.postMedia,
          caption: post.caption,
          likes: post.likes,
          comments: post.comments,
        );
      }).toList(),
    );
  }
}

class CommunityPostPage extends StatelessWidget {
  const CommunityPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Post'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          },
          child: const Text('Go to New Page'),
        ),
      ),
    );
  }
}

class MemowSpectrumPage extends StatelessWidget {
  const MemowSpectrumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memow Spectrum'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ImageWorldPage(),
                  ),
                );
              },
              child: const Text('Go to Spinning Wheel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreationsPage(),
                  ),
                );
              },
              child: const Text('Go to New Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Page'),
      ),
      body: Center(
        child: const Text('Menu Page Content'),
      ),
    );
  }
}

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                  color: Color.fromARGB(87, 134, 133, 133).withOpacity(0.3),
                  child: Container(
                    height: 80,
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return StoryCircle(
                          username: 'user_$index',
                          userImage: 'assets/logo.jpg',
                          userStories: const [
                            'assets/back.jpg',
                            'assets/back.jpg',
                            'assets/back.jpg',
                          ], // Replace with your asset
                        );
                      },
                    ),
                  )))),
    );
  }
}

class Post {
  final String username;
  final String userImage;
  final List<String> postMedia;
  final String caption;
  final int likes;
  final int comments;

  Post({
    required this.username,
    required this.userImage,
    required this.postMedia,
    required this.caption,
    required this.likes,
    required this.comments,
  });
}

class ImageWorldPage extends StatelessWidget {
  const ImageWorldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image World'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Raw'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('AI Share Portal'),
            ),
          ],
        ),
      ),
    );
  }
}

class CreationsPage extends StatelessWidget {
  const CreationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('All Posts'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Your Posts'),
            ),
          ],
        ),
      ),
    );
  }
}
