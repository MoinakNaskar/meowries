import 'package:flutter/material.dart';

class CommunityPostPage extends StatelessWidget {
  const CommunityPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Post'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return const InstagramPost();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle new post creation
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class InstagramPost extends StatelessWidget {
  const InstagramPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            const ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
              title: Text('Username'),
              subtitle: Text('Location'),
              trailing: Icon(Icons.more_vert),
            ),
            Image.network('https://via.placeholder.com/500'),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.favorite_border),
                  SizedBox(width: 16),
                  Icon(Icons.comment),
                  SizedBox(width: 16),
                  Icon(Icons.send),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
