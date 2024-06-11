import 'package:flutter/material.dart';

class MemowSpectrumPage extends StatelessWidget {
  const MemowSpectrumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memow Spectrum'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle Memow Cloud button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.purple, // Changed from primary to backgroundColor
              ),
              child: const Text('Memow Cloud'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle Image World button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors
                    .deepPurple, // Changed from primary to backgroundColor
              ),
              child: const Text('Image World'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle Creations button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    Colors.purple, // Changed from primary to backgroundColor
              ),
              child: const Text('Creations'),
            ),
          ],
        ),
      ),
    );
  }
}
