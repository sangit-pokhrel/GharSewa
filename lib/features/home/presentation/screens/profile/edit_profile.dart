import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class EditProfileForm extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> userData;
  final VoidCallback onSuccess;

  const EditProfileForm({
    super.key,
    required this.userId,
    required this.userData,
    required this.onSuccess,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _country;
  late TextEditingController _province;
  String _status = 'Active';
  final List<String> _statusOptions = ['Active', 'Inactive'];
  bool isLoading = false;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _email = TextEditingController(text: widget.userData["email"]);
    _country = TextEditingController(text: widget.userData["country"]);
    _province = TextEditingController(text: widget.userData["province"]);
    _status = widget.userData["status"] ?? 'Active';
  }

  @override
  void dispose() {
    _email.dispose();
    _country.dispose();
    _province.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isLoading = true);

    try {
      final res = await _dio.put(
        "http://192.168.1.66:3000/api/auth/id/${widget.userId}",
        data: {
          "email": _email.text.trim(),
          "country": _country.text.trim(),
          "province": _province.text.trim(),
          "status": _status,
        },
      );

      if (res.data['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );
        widget.onSuccess();
        Navigator.pop(context);
      } else {
        throw Exception("Failed to update profile");
      }
    } catch (e) {
      print("❌ Error updating profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Update failed")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text("Edit Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildField("Email", _email, keyboardType: TextInputType.emailAddress),
              _buildField("Country", _country),
              _buildField("Province", _province),

              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _status,
                items: _statusOptions.map((option) {
                  return DropdownMenuItem(value: option, child: Text(option));
                }).toList(),
                decoration: const InputDecoration(
                  labelText: "Status",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _status = value);
                  }
                },
              ),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _submit,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        validator: (value) =>
            value == null || value.isEmpty ? "$label is required" : null,
      ),
    );
  }
}
