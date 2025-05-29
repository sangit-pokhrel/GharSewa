import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/motion_toast.dart';
import 'package:ghar_sewa/view/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _agreeTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    setState(() => _isLoading = true);

    final url = Uri.parse('http://10.15.9.57:5000/api/auth/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'fullName': _fullNameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      print('Response Body: ${response.body}');
      final result = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) &&
          result['success'] == true) {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
        FocusScope.of(context).unfocus(); // hide keyboard first

        MotionToast(
          primaryColor: Colors.black87, // background color
          backgroundType: BackgroundType.solid, // disables blur/gradient
          icon: null, // removes icon
          title: const Text(
            "Success",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          description: const Text(
            "Account created successfully!",
            style: TextStyle(fontSize: 12, color: Colors.white70),
          ),
          width: 200,
          height: 20,
          animationType: AnimationType.slideInFromTop,
          toastAlignment: Alignment.topCenter,
          animationDuration: const Duration(milliseconds: 400),
          toastDuration: const Duration(seconds: 2),
          borderRadius: 8,
          displayBorder: false, // no outline
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ).show(context);
      } else {
        FocusScope.of(context).unfocus();
        MotionToast.error(
          title: const Text("Signup Failed"),
          description: const Text("Account creation Failed!"),
          animationType: AnimationType.slideInFromRight,
          toastAlignment: Alignment.topRight,
          animationDuration: const Duration(
            milliseconds: 500,
          ), // controls slide speed
          toastDuration: const Duration(seconds: 2),
          width: 250,
        ).show(context);
      }
    } catch (e) {
      FocusScope.of(context).unfocus();
      MotionToast.error(
        title: const Text("Error Occured"),
        description: const Text("Something Went Wrong !!!"),
        animationType: AnimationType.slideInFromRight,
        animationDuration: const Duration(
          milliseconds: 500,
        ), // controls slide speed
        toastDuration: const Duration(seconds: 2),
        toastAlignment: Alignment.topRight,
        width: 250,
      ).show(context);
    }
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Image.asset('assets/logo/removed-blacklogo.png', height: 120),
                ],
              ),
              const Text(
                "Enter your email and password to login",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  hintText: "Full name",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: "Enter password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: _agreeTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeTerms = value!;
                      });
                    },
                  ),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "I Agree With GharSewa ",
                        children: [
                          TextSpan(
                            text: "Term & Conditions",
                            style: TextStyle(
                              color: Color(0xFF0052CC),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _agreeTerms && !_isLoading ? _handleSignup : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0052CC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "Sign in now",
                      style: TextStyle(
                        color: Color(0xFF0052CC),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: const [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text("Or"),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 15),
              const Center(child: Text("Sign up with")),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Image.asset('assets/images/google.png', height: 28),
                      label: const Text(
                        "Google",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/facebook.jpg',
                        height: 28,
                      ),
                      label: const Text(
                        "Facebook",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
