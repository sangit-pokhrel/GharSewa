import 'package:flutter/material.dart';
import 'package:ghar_sewa/common/bottom_navbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentIndex: 0),
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: const Color(0xFF0052CC),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Header with Logo and Call Icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/logo/removed-blacklogo.png',
                      height: 40,
                    ),
                    const Icon(Icons.phone, color: Colors.black),
                  ],
                ),
                const SizedBox(height: 16),

                /// Promotion Card
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0052CC),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Get 30% off",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "Just by Booking Home Services",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Image.asset('assets/images/home1.png', height: 80),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                /// Search Box
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search here...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: const Icon(Icons.tune),
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                /// Popular Services
                _buildSectionHeader("Popular Services"),
                const SizedBox(height: 10),
                SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildServiceCard('Plumbing', 'assets/icons/Plumber.png'),
                      _buildServiceCard(
                        'Electric work',
                        'assets/icons/Multimeter.png',
                      ),
                      _buildServiceCard('Solar', 'assets/icons/Solar.png'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                /// Service Providers
                _buildSectionHeader("Service Providers"),
                const SizedBox(height: 10),
                SizedBox(
                  height: 210,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildProviderCard(
                        "Mukeswar Shah",
                        "Plumber",
                        "assets/images/mukesh.png",
                      ),
                      _buildProviderCard(
                        "Anuz Dhakal",
                        "Electrician",
                        "assets/images/anuz.png",
                        isGray: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Title and View All
  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const Text("View all", style: TextStyle(color: Color(0xFF0052CC))),
      ],
    );
  }

  /// Popular Service Card
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
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(iconPath, height: 28),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  /// Service Provider Card
  Widget _buildProviderCard(
    String name,
    String role,
    String imagePath, {
    bool isGray = false,
  }) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ColorFiltered(
              colorFilter:
                  isGray
                      ? const ColorFilter.mode(
                        Colors.grey,
                        BlendMode.saturation,
                      )
                      : const ColorFilter.mode(
                        Colors.transparent,
                        BlendMode.multiply,
                      ),
              child: Image.asset(
                imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(role, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 16),
              const SizedBox(width: 4),
              const Text("4.8"),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0052CC),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                child: const Text(
                  "Details",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
