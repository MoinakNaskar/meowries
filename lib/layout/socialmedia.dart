import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memow/utils/utils.dart';

class SocialMediaWorldPage extends StatelessWidget {
  final List<Map<String, String>> creators = [
    {
      'name': 'Creator One',
      'image': 'https://via.placeholder.com/150',
      'bio': 'This is the bio of Creator One.',
    },
    {
      'name': 'Creator Two',
      'image': 'https://via.placeholder.com/150',
      'bio': 'This is the bio of Creator Two.',
    },
  ];

  SocialMediaWorldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Social Media World'),
      ),
      body: FrostedGlassBackground(
        child: Container(
          child: ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: creators.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CreatorProfilePage(creator: creators[index]),
                    ),
                  );
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 2.0,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              NetworkImage(creators[index]['image']!),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            creators[index]['name']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4.0),
                          Text(creators[index]['bio']!),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CreatorProfilePage extends StatelessWidget {
  final Map<String, String> creator;

  const CreatorProfilePage({super.key, required this.creator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(creator['name']!),
      ),
      body: FrostedGlassBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(creator['image']!),
              ),
              const SizedBox(height: 16.0),
              Text(
                creator['name']!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 8.0),
              Text(creator['bio']!),
              // Add more fields and actions as needed
            ],
          ),
        ),
      ),
    );
  }
}
