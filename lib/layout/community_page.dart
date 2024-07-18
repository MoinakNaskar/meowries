import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memow/utils/frossted_glass.dart';
import 'dart:io';

import 'package:memow/utils/utils.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = '/chat-Page';
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  File? _profileImage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const AssetImage('assets/default_profile.png')
                          as ImageProvider,
                  child: _profileImage == null
                      ? const Icon(Icons.person, size: 32)
                      : null,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'MEMOW',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellow,
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Search',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.person_search),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FollowersListPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const TabBar(
                  tabs: [
                    Tab(text: 'GENERAL'),
                    Tab(text: 'GROUPS'),
                    Tab(text: 'PARTNERS'),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            GeneralChatScreen(),
            GroupsChatScreen(),
            PartnersChatScreen(),
          ],
        ),
      ),
    );
  }
}

class FollowersListPage extends StatelessWidget {
  const FollowersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of followers/following
    final List<String> followers = [
      'User1',
      'User2',
      'User3',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers/Following'),
      ),
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person), // Placeholder for user profile picture
            ),
            title: Text(followers[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChatDetailScreen(username: followers[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class GeneralChatScreen extends StatelessWidget {
  const GeneralChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of chats
    final List<String> chats = [
      'User1',
      'User2',
      'User3',
    ];

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person), // Placeholder for user profile picture
          ),
          title: Text(chats[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(username: chats[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class GroupsChatScreen extends StatelessWidget {
  const GroupsChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of group chats
    final List<String> groupChats = [
      'Group1',
      'Group2',
      'Group3',
    ];

    return ListView.builder(
      itemCount: groupChats.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.group), // Placeholder for group profile picture
          ),
          title: Text(groupChats[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatDetailScreen(
                    username: groupChats[index], isGroupChat: true),
              ),
            );
          },
        );
      },
    );
  }
}

class PartnersChatScreen extends StatelessWidget {
  const PartnersChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy list of partners
    final List<String> partners = [
      'Photographer1',
      'Photographer2',
      'Photographer3',
    ];

    return ListView.builder(
      itemCount: partners.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child:
                Icon(Icons.person), // Placeholder for partner profile picture
          ),
          title: Text(partners[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ChatDetailScreen(username: partners[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final String username;
  final bool isGroupChat;
  const ChatDetailScreen(
      {super.key, required this.username, this.isGroupChat = false});

  @override
  // ignore: library_private_types_in_public_api
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return FrostedGlassBox(
      key: null,
      width: screenSize.width,
      height: screenSize.height,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const CircleAvatar(
                child: Icon(
                    Icons.person), // Placeholder for user/group profile picture
              ),
              const SizedBox(width: 8),
              Text(widget.username),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => widget.isGroupChat
                        ? GroupInfoPage(groupName: widget.username)
                        : UserInfoPage(username: widget.username),
                  ),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_messages[index]),
                  );
                },
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () {
                    // Implement sending images from storage
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.videocam),
                  onPressed: () {
                    // Implement sending videos from storage
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: () {
                    // Implement sending voice messages
                  },
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    setState(() {
                      _messages.add(_controller.text);
                      _controller.clear();
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserInfoPage extends StatelessWidget {
  final String username;

  const UserInfoPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(
            radius: 60,
            child: Icon(Icons.person,
                size: 60), // Placeholder for user profile picture
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              username,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Status: Online'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Shared Media',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Dummy list of shared media
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GroupInfoPage extends StatelessWidget {
  final String groupName;

  const GroupInfoPage({super.key, required this.groupName});

  @override
  Widget build(BuildContext context) {
    // Dummy list of group members
    final List<String> groupMembers = [
      'Member1',
      'Member2',
      'Member3',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Info'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(
            radius: 60,
            child: Icon(Icons.group,
                size: 60), // Placeholder for group profile picture
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              groupName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          const ListTile(
            leading: Icon(Icons.description),
            title: Text('Group description here.'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Group Members',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: groupMembers.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(
                      Icons.person), // Placeholder for member profile picture
                ),
                title: Text(groupMembers[index]),
              );
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Shared Media',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Dummy list of shared media
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image),
              );
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(home: ChatPage()));
}
