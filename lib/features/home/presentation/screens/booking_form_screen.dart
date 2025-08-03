import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BookingFormScreen extends StatefulWidget {
  final String providerName;
  final String serviceName;
  final String minimumAmount;
  final String providerId;
  final String serviceId;

  const BookingFormScreen({
    super.key,
    required this.providerName,
    required this.serviceName,
    required this.minimumAmount,
    required this.providerId,
    required this.serviceId,
  });

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  DateTime? selectedDate;

  final Dio _dio = Dio();

Future<void> _submitBooking() async {
  try {
    // Fetch user ID from secure storage (fallback to static ID if not found)
    final userId = await _storage.read(key: 'userId') ?? "64fc6e5e3545c708e0d0f123";

    final bookingData = {
      "userId": userId,
      "provider": widget.providerId,
      "service": widget.serviceId, // use ID, not role
      "email": emailController.text.trim(),
      "house": houseController.text.trim(),
      "street": streetController.text.trim(),
      "fullAddress": addressController.text.trim(),
      "date": selectedDate?.toIso8601String(),
    };

    print("📤 Booking Payload: $bookingData");

    final response = await _dio.post(
      "http://192.168.1.66:3000/api/bookings",
      data: bookingData,
    );

    print("✅ Server Response: ${response.data}");

    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Booking Submitted"),
          content: const Text(
            "Your booking request has been submitted.\nPlease wait for confirmation.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Stay Here"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Go to Services Page"),
            ),
          ],
        ),
      );
    }

    // Clear form
    emailController.clear();
    houseController.clear();
    streetController.clear();
    addressController.clear();
    setState(() => selectedDate = null);
  } catch (e) {
    print("❌ Booking error: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Failed to submit booking")),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.serviceName} Booking"),
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text("Service: ${widget.serviceName}", style: const TextStyle(fontWeight: FontWeight.bold)),
              Text("Provider: ${widget.providerName}"),
              Text("Minimum Price: ${widget.minimumAmount}"),
              const SizedBox(height: 20),
              const Text("Enter your location address"),
              const SizedBox(height: 12),
              TextFormField(controller: houseController, decoration: const InputDecoration(labelText: "House number")),
              const SizedBox(height: 12),
              TextFormField(controller: streetController, decoration: const InputDecoration(labelText: "Street number")),
              const SizedBox(height: 12),
              TextFormField(controller: addressController, decoration: const InputDecoration(labelText: "Complete Address")),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              const SizedBox(height: 12),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Select Date"),
                subtitle: Text(selectedDate == null
                    ? "No date selected"
                    : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"),
                trailing: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(const Duration(days: 1)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) setState(() => selectedDate = picked);
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate() && selectedDate != null) {
                    _submitBooking();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please complete the form and select a date")),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(45)),
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
