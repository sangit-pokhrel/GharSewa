import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  final Map<String, dynamic> booking;

  const InvoicePage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final provider = booking['provider'];
    final service = booking['service'];
    final date = DateTime.tryParse(booking['date'] ?? '');
    final formattedDate = date != null
        ? '${date.day}/${date.month}/${date.year}'
        : 'Unknown Date';

    return Scaffold(
      appBar: AppBar(title: const Text("Booking Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: provider['image'] != null
                        ? NetworkImage(provider['image'])
                        : const AssetImage('assets/images/default_user.png') as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                Text("Service: ${service['name']}", style: Theme.of(context).textTheme.titleLarge),
                Text("Provider: ${provider['name']} (${provider['role']})"),
                const Divider(height: 30),
                Text("Email: ${booking['email']}"),
                Text("Booking Date: $formattedDate"),
                Text("Address: ${booking['house']}, ${booking['street']}, ${booking['fullAddress']}"),
                const SizedBox(height: 20),
                Text("Minimum Price: Rs. ${provider['minAmount']}", style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
