import 'package:flutter/material.dart';
import 'package:memow/utils/utils.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: Colors.purple,
      ),
      body: FrostedGlassBackground(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 4, // Number of columns
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            children: [
              _buildMenuButton(context, Icons.history, 'Booking History'),
              _buildMenuButton(context, Icons.notifications, 'Notification'),
              _buildMenuButton(context, Icons.people, 'Followers & Followings'),
              _buildMenuButton(context, Icons.bookmark, 'Saved Posts'),
              _buildMenuButton(context, Icons.group, 'Groups'),
              _buildMenuButton(context, Icons.event, 'Events'),
              _buildMenuButton(context, Icons.help, 'Help & Support'),
              _buildMenuButton(context, Icons.settings, 'Settings & Privacy'),
              _buildMenuButton(context, Icons.logout, 'Logout'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, IconData icon, String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: Colors.purple[50],
        elevation: 4.0,
      ),
      onPressed: () {
        // Handle button tap
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.purple, size: 40),
          const SizedBox(height: 8),
          Text(label,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
