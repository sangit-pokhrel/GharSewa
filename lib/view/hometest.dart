import 'package:flutter/material.dart';
import 'package:ghar_sewa/screens/popular_service_screen.dart';
import 'package:ghar_sewa/screens/about_us.dart';
import 'package:ghar_sewa/screens/acheivements_screen.dart';
import 'package:ghar_sewa/screens/service_provider_detail.dart';
import 'package:ghar_sewa/screens/top_rated.dart';
import 'package:ghar_sewa/screens/trending_service_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/logo/removed-blacklogo.png', height: 36),
                  const Icon(Icons.phone, size: 24, color: Colors.black),
                ],
              ),
              const SizedBox(height: 10),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0052CC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Get 30% off",
                                style: TextStyle(
                                  fontFamily: 'Urbanist ExtraBold',
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Just by Booking Home Services",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 100),
                        Image.asset('assets/images/home1.png', height: 130),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -32,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search here..',
                          focusColor: Colors.blue,
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: const Icon(Icons.tune),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: const BorderSide(
                              color: Colors.lime,
                              width: 1.5,
                            ),
                          ),
                          contentPadding: const EdgeInsets.only(top: 40),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              _buildSectionHeader(
                context,
                "Popular Services",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PopularServicesScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 85,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildServiceCard("Plumbing", "assets/icons/Plumber.png"),
                    _buildServiceCard(
                      "Electric work",
                      "assets/icons/Multimeter.png",
                    ),
                    _buildServiceCard("Solar", "assets/icons/Solar.png"),
                    _buildServiceCard("Cleaning", "assets/icons/Solar.png"),
                    _buildServiceCard("AC Repair", "assets/icons/Solar.png"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionHeader(
                context,
                "Service Providers",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ServiceProviderDetail(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // other content unchanged
              _buildSectionHeader(
                context,
                "Top Rated Services",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TopRatedServiceScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildSectionHeader(
                context,
                "Trending Now",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TrendingServiceScreen(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _buildSectionHeader(
                context,
                "Our Achievements",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AcheivementsScreen()),
                ),
              ),
              const SizedBox(height: 10),
              _buildSectionHeader(
                context,
                "About Us",
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AboutUs()),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            "View all",
            style: TextStyle(
              color: Color(0xFF0052CC),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(String title, String iconPath) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: 26),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }
}

// ignore: unused_element
class _StatBlock extends StatelessWidget {
  final String label;
  final String value;
  const _StatBlock({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
