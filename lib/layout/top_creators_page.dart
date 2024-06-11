import 'package:flutter/material.dart';

class TopCreatorsSection extends StatelessWidget {
  final List<Map<String, String>> topCreators = [
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
    // Add more top creators here
  ];

  TopCreatorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: topCreators.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CreatorProfilePage(creator: topCreators[index]),
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
                    backgroundImage: NetworkImage(topCreators[index]['image']!),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topCreators[index]['name']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4.0),
                    Text(topCreators[index]['bio']!),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CreatorProfilePage extends StatelessWidget {
  final Map<String, String> creator;

  const CreatorProfilePage({super.key, required this.creator});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(creator['name']!),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(creator['image']!),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    creator['name']!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 8.0),
                  Text(creator['bio']!),
                  const SizedBox(height: 16.0),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text('123',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Followers'),
                        ],
                      ),
                      Column(
                        children: [
                          Text('456',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Following'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Follow'),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Book'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text('Posts',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 8.0),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      return Image.network('https://via.placeholder.com/150');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
