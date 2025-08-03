import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Your Privacy Matters",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text(
              "Ghar Sewa is committed to protecting your privacy. We only collect necessary information to provide you with a better experience on our platform.",
            ),
            SizedBox(height: 16),
            Text(
              "What We Collect",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              "- Name, email, and phone number\n"
              "- Address and location for service delivery\n"
              "- Payment method details (secured and encrypted)\n"
              "- Device and usage data (for app improvement)",
            ),
            SizedBox(height: 16),
            Text(
              "How We Use Your Data",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),
            Text(
              "Your data helps us to:\n- Process bookings efficiently\n- Personalize your app experience\n- Provide customer support\n- Improve service offerings",
            ),
            SizedBox(height: 16),
            Text(
              "We do not sell your personal data to third parties. Your trust is important to us.",
            ),
          ],
        ),
      ),
    );
  }
}
