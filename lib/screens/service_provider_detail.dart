import 'package:flutter/material.dart';
import 'package:ghar_sewa/screens/service_provider_viewall.dart';

class ServiceProviderDetail extends StatelessWidget {
  const ServiceProviderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> providers = [
      {
        'title': 'Electrician Providers',
        'items': [
          {
            'name': 'Jackson',
            'role': 'Electrician',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/31.jpg',
          },
          {
            'name': 'Emily Jansi',
            'role': 'Electrician',
            'rating': '4.8',
            'img': 'https://randomuser.me/api/portraits/women/44.jpg',
          },
          {
            'name': 'Emily Jansi',
            'role': 'Electrician',
            'rating': '4.8',
            'img': 'https://randomuser.me/api/portraits/women/44.jpg',
          },
          {
            'name': 'Emily Jansi',
            'role': 'Electrician',
            'rating': '4.8',
            'img': 'https://randomuser.me/api/portraits/women/44.jpg',
          },
          {
            'name': 'Emily Jansi',
            'role': 'Electrician',
            'rating': '4.8',
            'img': 'https://randomuser.me/api/portraits/women/44.jpg',
          },
        ],
      },
      {
        'title': 'Plumber Providers',
        'items': [
          {
            'name': 'Ethan Itto',
            'role': 'Plumber',
            'rating': '4.7',
            'img': 'https://randomuser.me/api/portraits/men/36.jpg',
          },
          {
            'name': 'Isabelle Unca',
            'role': 'Plumber',
            'rating': '5.0',
            'img': 'https://randomuser.me/api/portraits/women/47.jpg',
          },
          {
            'name': 'Ethan Itto',
            'role': 'Plumber',
            'rating': '4.7',
            'img': 'https://randomuser.me/api/portraits/men/36.jpg',
          },
          {
            'name': 'Isabelle Unca',
            'role': 'Plumber',
            'rating': '5.0',
            'img': 'https://randomuser.me/api/portraits/women/47.jpg',
          },
          {
            'name': 'Ethan Itto',
            'role': 'Plumber',
            'rating': '4.7',
            'img': 'https://randomuser.me/api/portraits/men/36.jpg',
          },
          {
            'name': 'Isabelle Unca',
            'role': 'Plumber',
            'rating': '5.0',
            'img': 'https://randomuser.me/api/portraits/women/47.jpg',
          },
        ],
      },
      {
        'title': 'Carpenter Providers',
        'items': [
          {
            'name': 'Alden',
            'role': 'Carpenter',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/50.jpg',
          },
          {
            'name': 'Logan',
            'role': 'Carpenter',
            'rating': '4.4',
            'img': 'https://randomuser.me/api/portraits/men/52.jpg',
          },
          {
            'name': 'Alden',
            'role': 'Carpenter',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/50.jpg',
          },
          {
            'name': 'Logan',
            'role': 'Carpenter',
            'rating': '4.4',
            'img': 'https://randomuser.me/api/portraits/men/52.jpg',
          },
          {
            'name': 'Alden',
            'role': 'Carpenter',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/50.jpg',
          },
          {
            'name': 'Logan',
            'role': 'Carpenter',
            'rating': '4.4',
            'img': 'https://randomuser.me/api/portraits/men/52.jpg',
          },
        ],
      },
      {
        'title': 'Painter Providers',
        'items': [
          {
            'name': 'Lucas',
            'role': 'Painter',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/55.jpg',
          },
          {
            'name': 'Ethan',
            'role': 'Painter',
            'rating': '4.5',
            'img': 'https://randomuser.me/api/portraits/men/56.jpg',
          },
          {
            'name': 'Lucas',
            'role': 'Painter',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/55.jpg',
          },
          {
            'name': 'Ethan',
            'role': 'Painter',
            'rating': '4.5',
            'img': 'https://randomuser.me/api/portraits/men/56.jpg',
          },
          {
            'name': 'Lucas',
            'role': 'Painter',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/55.jpg',
          },
          {
            'name': 'Ethan',
            'role': 'Painter',
            'rating': '4.5',
            'img': 'https://randomuser.me/api/portraits/men/56.jpg',
          },
        ],
      },
      {
        'title': 'Cleaner Providers',
        'items': [
          {
            'name': 'Harper',
            'role': 'Cleaner',
            'rating': '4.9',
            'img': 'https://randomuser.me/api/portraits/women/68.jpg',
          },
          {
            'name': 'Caleb',
            'role': 'Cleaner',
            'rating': '4.6',
            'img': 'https://randomuser.me/api/portraits/men/61.jpg',
          },
          {
            'name': 'Harper',
            'role': 'Cleaner',
            'rating': '4.9',
            'img': 'https://randomuser.me/api/portraits/women/68.jpg',
          },
          {
            'name': 'Caleb',
            'role': 'Cleaner',
            'rating': '4.6',
            'img': 'https://randomuser.me/api/portraits/men/61.jpg',
          },
          {
            'name': 'Harper',
            'role': 'Cleaner',
            'rating': '4.9',
            'img': 'https://randomuser.me/api/portraits/women/68.jpg',
          },
          {
            'name': 'Caleb',
            'role': 'Cleaner',
            'rating': '4.6',
            'img': 'https://randomuser.me/api/portraits/men/61.jpg',
          },
        ],
      },
      {
        'title': 'Locksmith Providers',
        'items': [
          {
            'name': 'Benjamin',
            'role': 'Locksmith',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/66.jpg',
          },
          {
            'name': 'Carter',
            'role': 'Locksmith',
            'rating': '4.6',
            'img': 'https://randomuser.me/api/portraits/men/67.jpg',
          },
          {
            'name': 'Benjamin',
            'role': 'Locksmith',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/66.jpg',
          },
          {
            'name': 'Carter',
            'role': 'Locksmith',
            'rating': '4.6',
            'img': 'https://randomuser.me/api/portraits/men/67.jpg',
          },
          {
            'name': 'Benjamin',
            'role': 'Locksmith',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/66.jpg',
          },
          {
            'name': 'Carter',
            'role': 'Locksmith',
            'rating': '4.6',
            'img': 'https://randomuser.me/api/portraits/men/67.jpg',
          },
        ],
      },
      {
        'title': 'Mover Providers',
        'items': [
          {
            'name': 'Matteo Katto',
            'role': 'Mover',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/72.jpg',
          },
          {
            'name': 'Sharma Jon',
            'role': 'Mover',
            'rating': '4.6',
            'img': 'https://randomuser.me/api/portraits/men/73.jpg',
          },
          {
            'name': 'Matteo Katto',
            'role': 'Mover',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/72.jpg',
          },
          {
            'name': 'Sharma Jon',
            'role': 'Mover',
            'rating': '4.6',
            'img': 'https://randomuser.me/api/portraits/men/73.jpg',
          },
          {
            'name': 'Matteo Katto',
            'role': 'Mover',
            'rating': '4.1',
            'img': 'https://randomuser.me/api/portraits/men/72.jpg',
          },
          {
            'name': 'Sharma Jon',
            'role': 'Mover',
            'rating': '4.6',
            'img': 'https://randomuser.me/api/portraits/men/73.jpg',
          },
        ],
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Service Providers",
          style: TextStyle(color: Colors.black),
        ),
      ),

      backgroundColor: Color(0xFFF9FAFB),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final section = providers[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    section['title'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ServiceProviderViewall(
                                providers: List<Map<String, String>>.from(
                                  section['items'],
                                ),
                              ),
                        )
                      );
                    },
                    child: const Text(
                      "View all",
                      style: TextStyle(color: Color(0xFF0052CC)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: section['items'].length,
                  itemBuilder: (context, i) {
                    final item = section['items'][i];
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
                            child: Image.network(
                              item['img'],
                              height: 90,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item['name'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            item['role'],
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.orange,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(item['rating']),
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
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
