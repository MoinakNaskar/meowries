import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:memow/common/single_post.dart';
import 'package:memow/utils/frossted_glass.dart';
import 'package:memow/utils/utils.dart';

class InstagramPost extends StatefulWidget {
  final String username;
  final String userImage;
  final List<String> postMedia;
  final String caption;
  final int likes;
  final int comments;

  const InstagramPost({
    Key? key,
    required this.username,
    required this.userImage,
    required this.postMedia,
    required this.caption,
    required this.likes,
    required this.comments,
  }) : super(key: key);

  @override
  _InstagramPostState createState() => _InstagramPostState();
}

class _InstagramPostState extends State<InstagramPost> {
  bool isLiked = false;
  bool isFollowed = false;
  late int likesCount;
  bool isTabExpanded = false;

  List<String> comments = ["Great post!", "Nice picture!", "Amazing!"];
  List<String> images = [
    "https://cdn.pixabay.com/photo/2019/10/29/10/16/model-4586589_1280.jpg",
    "https://cdn.pixabay.com/photo/2019/10/29/10/16/model-4586589_1280.jpg",
    "https://cdn.pixabay.com/photo/2019/10/29/10/16/model-4586589_1280.jpg"
  ];

  @override
  void initState() {
    super.initState();
    likesCount = widget.likes;
  }

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
    Size screenSize = Utils().getScreenSize();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FrostedGlassBox(
              key: null,
              width: screenSize.width,
              height: screenSize.height,
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
                            leading: CircleAvatar(
                              backgroundImage: AssetImage(widget.userImage),
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

  void _redirectToSongPage() {
    // Implement navigation to song page
  }

  void _redirectToPhotographerProfile() {
    // Implement navigation to photographer profile page
  }

  void _redirectToLocationPage() {
    // Implement navigation to location page
  }

  void _redirectToUserProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfilePage(username: widget.username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: _onDoubleTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(40),
              // Set the border radius
              child: Container(
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Stack(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Stack(
                          children: [
                            SinglePost(images: images),
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.black54,
                                      Color.fromARGB(241, 41, 38, 38),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black54,
                                      Color.fromARGB(255, 43, 41, 41),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8.0,
                      left: 8.0,
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(widget.userImage),
                          ),
                          const SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: _redirectToUserProfile,
                            child: Text(
                              widget.username,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isTabExpanded = !isTabExpanded;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: isTabExpanded ? 250.0 : 40.0,
                              height: 30.0,
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: isTabExpanded
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TextButton(
                                          onPressed: _redirectToSongPage,
                                          child: const Text(
                                            "Song",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed:
                                              _redirectToPhotographerProfile,
                                          child: const Text(
                                            "Photographer",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: _redirectToLocationPage,
                                          child: const Text(
                                            "Location",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Icon(
                                      Icons.more_horiz,
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: IconButton(
                        icon: Icon(
                          isFollowed ? Icons.person_remove : Icons.person_add,
                          color: Colors.white,
                        ),
                        onPressed: _toggleFollow,
                      ),
                    ),
                    Positioned(
                      bottom: 8.0,
                      right: 42.0,
                      child: IconButton(
                        icon: const Icon(Icons.share),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                    ),
                    Positioned(
                      bottom: 1.0,
                      right: 8.0,
                      child: Column(
                        children: [
                          IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.white,
                            ),
                            onPressed: _toggleLike,
                          ),
                          Text(
                            '$likesCount',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 8.0,
                      left: 8.0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.comment,
                          color: Colors.white,
                        ),
                        onPressed: () => _showComments(context),
                      ),
                    ),
                    Positioned(
                      bottom: 8.0,
                      left: 8.0,
                      right: 8.0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            widget.caption,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final String username;

  const UserProfilePage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(username),
      ),
      body: Center(
        child: Text('Profile page of $username'),
      ),
    );
  }
}
