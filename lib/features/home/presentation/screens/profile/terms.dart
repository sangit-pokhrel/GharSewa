import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms & Conditions')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Terms & Conditions",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(
              "By using Ghar Sewa, you agree to the following terms and conditions. Please read them carefully.",
            ),
            SizedBox(height: 16),
            Text(
              "1. User Responsibilities",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              "Users must provide accurate personal information and ensure their account is used securely and responsibly.",
            ),
            SizedBox(height: 12),
            Text(
              "2. Booking & Cancellation",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              "Bookings are confirmed based on provider availability. Cancellations must be made 2 hours prior to avoid charges.",
            ),
            SizedBox(height: 12),
            Text(
              "3. Payment",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              "All payments are processed securely. Refunds are governed by our refund policy as listed in the app.",
            ),
            SizedBox(height: 12),
            Text(
              "4. Changes to Terms",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              "We reserve the right to update these terms at any time. Continued use of the app implies acceptance of any changes.",
            ),
          ],
        ),
      ),
    );
  }
}
