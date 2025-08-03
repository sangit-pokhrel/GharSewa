import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final ImagePicker _picker = ImagePicker();

  File? _localProfileImage;
  String? userName;
  String? userEmail;
  String? userRole;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    try {
      final email = await _storage.read(key: 'email');
      final role = await _storage.read(key: 'role');
      final imagePath = await _storage.read(key: 'profileImagePath');

      setState(() {
        userEmail = email ?? "johndoe@example.com";
        userRole = role ?? "Customer";
        if (imagePath != null) {
          _localProfileImage = File(imagePath);
        }
      });
    } catch (e) {
      print("❌ Error loading profile data: $e");
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final fpEmail = await _storage.read(key: 'fp_email');
    final fpPassword = await _storage.read(key: 'fp_password');

    await _storage.deleteAll();

    if (fpEmail != null) {
      await _storage.write(key: 'fp_email', value: fpEmail);
    }
    if (fpPassword != null) {
      await _storage.write(key: 'fp_password', value: fpPassword);
    }

    if (context.mounted) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  Future<void> _changeProfileImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final Directory appDir = await getApplicationDocumentsDirectory();
    final String fileName = basename(pickedFile.path);
    final String savedPath = '${appDir.path}/$fileName';

    final File imageFile = File(pickedFile.path);
    final File localImage = await imageFile.copy(savedPath);

    await _storage.write(key: 'profileImagePath', value: localImage.path);

    setState(() {
      _localProfileImage = localImage;
    });

    ScaffoldMessenger.of(context as BuildContext).showSnackBar(
      const SnackBar(content: Text("Profile photo updated")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: _localProfileImage != null
                      ? FileImage(_localProfileImage!)
                      : const AssetImage('assets/images/default_user.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: _changeProfileImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              userName ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              userEmail ?? '',
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              userRole ?? '',
              style: const TextStyle(color: Colors.blueAccent),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildTile(context, Icons.favorite, "My Favorites", "/favorites"),
                  _buildTile(context, Icons.person, "Account Information", "/account-info"),
                  _buildTile(context, Icons.info_outline, "About Us", "/about"),
                  _buildTile(context, Icons.lock_outline, "Privacy Policy", "/privacy"),
                  _buildTile(context, Icons.policy_outlined, "Terms & Conditions", "/terms"),
                  _buildTile(context, Icons.report_problem, "Complaints", "/complaints"),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text("Logout", style: TextStyle(color: Colors.red)),
                    onTap: () => _handleLogout(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildTile(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
