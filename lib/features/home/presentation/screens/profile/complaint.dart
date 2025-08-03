import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  String userId = "";
  String selectedPriority = "Low";
  bool isLoading = false;

  final List<String> priorities = ["Low", "Medium", "High"];

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final storedId = await storage.read(key: 'userId');
    setState(() {
      userId = storedId ?? "";
    });
  }

  Future<void> _submitComplaint() async {
    if (!_formKey.currentState!.validate() || userId.isEmpty) return;

    setState(() => isLoading = true);
    final Dio dio = Dio();

    try {
      final response = await dio.post(
        'http://192.168.1.66:3000/api/complaints/',
        data: {
          "userId": userId,
          "requesterId": userId,
          "description": _descriptionController.text.trim(),
          "priority": selectedPriority,
          "status": "Open",
        },
      );

      if (response.data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Complaint submitted successfully")),
        );
        _descriptionController.clear();
      } else {
        throw Exception("Failed to submit complaint");
      }
    } catch (e) {
      print("❌ Error submitting complaint: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to submit complaint")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Complaint Submission")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Describe your issue",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Enter complaint or issue details",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Required" : null,
                ),
                const SizedBox(height: 16),
                const Text("Priority", style: TextStyle(fontWeight: FontWeight.w600)),
                DropdownButtonFormField<String>(
                  value: selectedPriority,
                  items: priorities
                      .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => selectedPriority = val);
                  },
                  decoration: const InputDecoration(border: UnderlineInputBorder()),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.send),
                    label: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Submit Complaint"),
                    onPressed: isLoading ? null : _submitComplaint,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
