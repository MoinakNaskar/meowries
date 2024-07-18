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
                        horizontal: 16.0, vertical: 10.0),
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
                  const SizedBox(height: 10.0),
                  const StoriesSection(),
                  const SizedBox(height: 10.0),
                  const TabBar(
                    tabs: [
                      Tab(text: 'TRENDING'),
                      Tab(text: 'FOLLOWING'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
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
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        backgroundColor: const Color.fromARGB(255, 6, 5, 5),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(eccentricity: 1),
          backgroundColor: Colors.amber,
          focusColor: Colors.black,
          elevation: 50,
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
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.amber,
          selectedItemColor: const Color.fromARGB(242, 160, 5, 175),
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
              backgroundColor: Color.fromARGB(240, 240, 41, 41),
              icon: Icon(Icons.people),
              label: 'Community Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Memow Spectrum',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Menu',
            ),
          ],
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
              child: const Text('Image World'),
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
              child: const Text('Creations'),
            ),
          ],
        ),
      ),
    );
  }
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

class StoriesSection extends StatelessWidget {
  const StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
