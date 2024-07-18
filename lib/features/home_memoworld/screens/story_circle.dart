import 'package:flutter/material.dart';

class StoryCircle extends StatelessWidget {
  final String username;
  final String userImage;
  final List<String> userStories;

  const StoryCircle({
    super.key,
    required this.username,
    required this.userImage,
    required this.userStories,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StoryViewer(userStories: userStories),
          ),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(userImage),
            ),
          ),
          Text(username),
        ],
      ),
    );
  }
}

class StoryViewer extends StatefulWidget {
  final List<String> userStories;

  const StoryViewer({super.key, required this.userStories});

  @override
  _StoryViewerState createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _nextStory() {
    if (_currentIndex < widget.userStories.length - 1) {
      setState(() {
        _currentIndex++;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) {
          final width = MediaQuery.of(context).size.width;
          final dx = details.globalPosition.dx;

          if (dx < width / 2) {
            _previousStory();
          } else {
            _nextStory();
          }
        },
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.userStories.length,
          itemBuilder: (context, index) {
            return Image.asset(
              widget.userStories[index],
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}

class Memow extends StatelessWidget {
  const Memow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MEMOWRIES',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stories')),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          StoryCircle(
            username: 'User1',
            userImage: 'assets/user1.png',
            userStories: ['assets/story1.png', 'assets/story2.png'],
          ),
          StoryCircle(
            username: 'User2',
            userImage: 'assets/user2.png',
            userStories: ['assets/story3.png', 'assets/story4.png'],
          ),
          // Add more StoryCircle widgets here
        ],
      ),
    );
  }
}
