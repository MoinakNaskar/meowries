// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:memow/layout/instagram_post.dart';
import 'package:memow/layout/menu_page.dart';
import 'package:memow/layout/socialmedia.dart';
import 'package:memow/layout/top_creators_page.dart';
import 'package:memow/screens/spinningwheel.dart';
import 'package:memow/utils/utils.dart';

void main() {
  runApp(const Memow());
}

class Memow extends StatelessWidget {
  const Memow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomeScreen(),
      theme: ThemeData(primarySwatch: Colors.purple),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    const TrendingSection(),
    TopCreatorsSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const GradientText(
              'MEMOW',
              gradient: LinearGradient(colors: [Colors.purple, Colors.blue]),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(120.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        hintText: 'Find best MEMOW partner for you',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const TabBar(
                    tabs: [
                      Tab(text: 'TRENDING'),
                      Tab(text: 'TOP CREATORS'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: _widgetOptions,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SpinningWheelPage()));
                },
                tooltip: 'Memow Booking',
                child: const Icon(Icons.chat),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SocialMediaWorldPage()),
                  );
                },
                tooltip: 'Memow Verse',
                child: const Icon(Icons.people),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CommunityPostPage()),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MemowSpectrumPage()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MenuPage()),
                  );
                }
              },
              items: const [
                BottomNavigationBarItem(
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
              ])),
    );
  }
}

class AccountDetailsSheet extends StatelessWidget {
  const AccountDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Wrap(
        children: <Widget>[
          ListTile(
              leading: const Icon(Icons.person),
              title: const Text('User Profile'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Bookings'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.monetization_on),
              title: const Text('Memow Coins'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {}),
        ],
      ),
    );
  }
}

class TrendingSection extends StatelessWidget {
  const TrendingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return const InstagramPost();
      },
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
      body: const Center(
        child: Text('Community Post Page'),
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
                      builder: (context) => const ImageWorldPage()),
                );
              },
              child: const Text('Image World'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreationsPage()),
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
              child: const Text('Memow Cloud'),
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
      body: const Center(
        child: Text('Coming Soon'),
      ),
    );
  }
}
