import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';
import 'edit_profile.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Dio _dio = Dio();

  String userId = "";
  Map<String, dynamic> userData = {
    "email": "",
    "country": "",
    "province": "",
    "role": "",
    "status": "",
    "createdAt": ""
  };

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final id = await _storage.read(key: 'userId');
    if (id != null) {
      userId = id;
      await _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    try {
      final res = await _dio.get("http://192.168.1.66:3000/api/auth/id/$userId");
      if (res.data['success'] == true) {
        setState(() {
          userData = res.data['data'];
        });
      }
    } catch (e) {
      print("❌ Error fetching user data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to load user info")),
      );
    }
  }

  void _openEditDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => EditProfileForm(
        userId: userId,
        userData: userData,
        onSuccess: _fetchUserData,
      ),
    );
  }

  Future<void> _deleteAccount() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Deletion"),
        content: const Text("Are you sure you want to delete your account? This action cannot be undone."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      final res = await _dio.delete("http://192.168.1.66:3000/api/auth/id/$userId");

      if (res.statusCode == 200 && res.data['success'] == true) {
        await _storage.deleteAll(); // optional: clear secure storage
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(context, '/register', (route) => false);
        }
      } else {
        throw Exception("Deletion failed");
      }
    } catch (e) {
      print("❌ Error deleting account: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Account deletion failed: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account Information")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage('assets/images/default_user.png'),
            ),
            const SizedBox(height: 20),
            _buildInfoTile("Email", userData["email"] ?? ""),
            _buildInfoTile("Country", userData["country"] ?? ""),
            _buildInfoTile("Province", userData["province"] ?? ""),
            _buildInfoTile("Role", userData["role"] ?? ""),
            _buildInfoTile("Status", userData["status"] ?? ""),
            _buildInfoTile("Created At", userData["createdAt"]?.toString() ?? ""),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _openEditDialog,
                  icon: const Icon(Icons.edit),
                  label: const Text("Edit Profile"),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: _deleteAccount,
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete Account"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
