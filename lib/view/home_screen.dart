import 'package:flutter/material.dart';
import 'package:ghar_sewa/home_screens_detail/popular_service_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
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
                                  color: Colors.white,
                                  fontSize: 24,
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
              _buildSectionHeader(context, "Popular Services"),
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
              _buildSectionHeader(context, "Service Providers"),
              const SizedBox(height: 10),
              SizedBox(
                height: 210,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(6, (index) {
                    bool isEven = index % 2 == 0;
                    return _buildProviderCard(
                      isEven ? "Mukeswar Shah" : "Anuz Dhakal",
                      isEven ? "Plumber" : "Electrician",
                      isEven
                          ? "assets/images/mukesh.png"
                          : "assets/images/anuz.png",
                      isGray: !isEven,
                      rating: "4.8",
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionHeader(context, "Top Rated Services"),
              const SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildImageServiceCard(
                      "AC Repair",
                      "assets/images/Solar.png",
                      "4.9",
                    ),
                    _buildImageServiceCard(
                      "Cleaning",
                      "assets/images/Solar.png",
                      "4.8",
                    ),
                    _buildImageServiceCard(
                      "Carpentry",
                      "assets/images/Solar.png",
                      "4.7",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionHeader(context, "Trending Now"),
              const SizedBox(height: 10),
              _buildTrendingBanner("assets/images/Solar.png"),
              const SizedBox(height: 12),
              _buildTrendingBanner("assets/images/Solar.png"),
              const SizedBox(height: 20),
              _buildSectionHeader(context, "Our Achievements"),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _StatBlock(label: "Users", value: "10K+"),
                  _StatBlock(label: "Bookings", value: "50K+"),
                  _StatBlock(label: "Satisfaction", value: "98%"),
                ],
              ),
              const SizedBox(height: 20),
              _buildSectionHeader(context, "About Us"),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(14),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "We are a trusted platform providing quick, affordable, and reliable home services across Nepal. From plumbing to AC repair, our verified professionals ensure top-notch customer satisfaction.",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) =>
                        const PopularServicesScreen(), // <-- Your target screen
              ),
            );
          },
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

  Widget _buildProviderCard(
    String name,
    String role,
    String imagePath, {
    bool isGray = false,
    String rating = "4.8",
  }) {
    return Container(
      width: 160,
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
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(role, style: const TextStyle(fontSize: 12)),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orange, size: 16),
              const SizedBox(width: 4),
              Text(rating),
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

  Widget _buildImageServiceCard(String title, String img, String rating) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              img,
              height: 70,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(Icons.star, size: 14, color: Colors.orange),
                Text(rating, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingBanner(String path) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }
}

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
