import 'package:flutter/material.dart';

class PopularServicesScreen extends StatelessWidget {
  const PopularServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular services'),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("Maintenance", [
              _buildCard("Air Condition", "assets/icons/air.png"),
              _buildCard("Electric", "assets/icons/electric.png"),
              _buildCard("Siding repair", "assets/icons/siding.png"),
            ]),
            _buildSection("Cleaning", [
              _buildCard("Home Flooring", "assets/icons/floor.png"),
              _buildCard("Gutter", "assets/icons/gutter.png"),
              _buildCard("Carpet", "assets/icons/carpet.png"),
            ]),
            _buildSection("Home Improvement", [
              _buildCard("Drilling", "assets/icons/drill.png"),
              _buildCard("Lawn", "assets/icons/lawn.png"),
              _buildCard("Weed control", "assets/icons/weed.png"),
            ]),
            _buildSection("Security", [
              _buildCard("Camera", "assets/icons/camera.png"),
              _buildCard("Burglar alarm", "assets/icons/alarm.png"),
              _buildCard("Study lock", "assets/icons/lock.png"),
            ]),
            _buildSection("Car Maintenance", [
              _buildCard("Car washer", "assets/icons/wash.png"),
              _buildCard("Oil change", "assets/icons/oil.png"),
              _buildCard("Car battery", "assets/icons/battery.png"),
            ]),
            _buildSection("Handyman Services", [
              _buildCard("Furniture", "assets/icons/furniture.png"),
              _buildCard("Door", "assets/icons/door.png"),
              _buildCard("Shelving", "assets/icons/shelf.png"),
            ]),
            _buildSection("Painting Services", [
              _buildCard("Interior", "assets/icons/interior.png"),
              _buildCard("Exterior", "assets/icons/exterior.png"),
              _buildCard("Wall", "assets/icons/wall.png"),
            ]),
            _buildSection("Other services", [
              _buildCard("Dish wash", "assets/icons/dish.png"),
              _buildCard("Loading", "assets/icons/loading.png"),
              _buildCard("Cutting", "assets/icons/cutting.png"),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> cards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 0.8,
          shrinkWrap: true,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          physics: const NeverScrollableScrollPhysics(),
          children: cards,
        ),
      ],
    );
  }

  Widget _buildCard(String title, String iconPath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            height: 40,
            width: 40,
          ), // You can use NetworkImage if needed
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
