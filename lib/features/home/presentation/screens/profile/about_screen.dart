import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Welcome to Ghar Sewa!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text(
              "Ghar Sewa is a home service platform designed to make your life easier. We connect you with trusted professionals for a wide range of services — from plumbing, electrical, and cleaning, to appliance repair and home maintenance.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            const Text(
              "Our Mission",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "We aim to simplify your daily life by providing seamless access to reliable home services at your convenience, ensuring quality and affordability every time.",
            ),
            const SizedBox(height: 16),
            const Text(
              "Why Ghar Sewa?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              "- Trusted professionals\n- Transparent pricing\n- Fast booking process\n- 24/7 support\n- Easy tracking of services",
            ),
          ],
        ),
      ),
    );
  }
}
