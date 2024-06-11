import 'package:flutter/material.dart';
import 'package:memow/utils/utils.dart';

class InstagramPost extends StatefulWidget {
  const InstagramPost({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InstagramPostState createState() => _InstagramPostState();
}

class _InstagramPostState extends State<InstagramPost> {
  bool isLiked = false;
  bool isFollowed = false;
  int likesCount = 123;
  List<String> comments = ["Great post!", "Nice picture!", "Amazing!"];

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked) {
        likesCount++;
      } else {
        likesCount--;
      }
    });
  }

  void _onDoubleTap() {
    setState(() {
      if (!isLiked) {
        isLiked = true;
        likesCount++;
      }
    });
  }

  void _toggleFollow() {
    setState(() {
      isFollowed = !isFollowed;
    });
  }

  void _showComments(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FrostedGlassBackground(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text('Comments',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/150'),
                            ),
                            title: Text('User $index'),
                            subtitle: Text(comments[index]),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _onDoubleTap,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Username',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(
                      isFollowed ? Icons.person_remove : Icons.person_add,
                      color: isFollowed ? Colors.red : Colors.blue,
                    ),
                    onPressed: _toggleFollow,
                  ),
                ],
              ),
              subtitle: const Text('Location'),
              trailing: IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ),
            Image.network(
              'https://via.placeholder.com/600x400',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon:
                        Icon(isLiked ? Icons.favorite : Icons.favorite_border),
                    color: isLiked ? Colors.red : Colors.black,
                    onPressed: _toggleLike,
                  ),
                  IconButton(
                    icon: const Icon(Icons.comment),
                    onPressed: () => _showComments(context),
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {},
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.bookmark),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '$likesCount likes',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Username',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'This is the caption for the post.',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GestureDetector(
                onTap: () {
                  _showComments(context);
                },
                child: Text(
                  'View all ${comments.length} comments',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
