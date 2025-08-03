import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ghar_sewa/features/home/presentation/screens/service_provider_detail.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Dio dio = Dio();
  List<dynamic> allProviders = [];
  List<dynamic> filteredProviders = [];

  String searchQuery = '';
  String selectedRole = 'All';
  String selectedPriceSort = 'None';

  @override
  void initState() {
    super.initState();
    fetchProviders();
  }

  Future<void> fetchProviders() async {
    try {
      final response = await dio.get('http://192.168.1.66:3000/api/providers');
      setState(() {
        allProviders = response.data;
        filteredProviders = List.from(allProviders);
      });
    } catch (e) {
      print('❌ Error fetching providers: $e');
    }
  }

  void applyFilters() {
    List<dynamic> results = allProviders;

    // Case-insensitive name search
    if (searchQuery.isNotEmpty) {
      results = results
          .where((provider) => provider['name']
              .toString()
              .toLowerCase()
              .contains(searchQuery.toLowerCase()))
          .toList();
    }

    // Filter by role
    if (selectedRole != 'All') {
      results = results
          .where((provider) => provider['role'].toString() == selectedRole)
          .toList();
    }

    // Sort by price
    if (selectedPriceSort == 'High to Low') {
      results.sort((a, b) =>
          int.parse(b['minAmount']).compareTo(int.parse(a['minAmount'])));
    } else if (selectedPriceSort == 'Low to High') {
      results.sort((a, b) =>
          int.parse(a['minAmount']).compareTo(int.parse(b['minAmount'])));
    }

    setState(() {
      filteredProviders = results;
    });
  }

  List<String> getAllRoles() {
    final roles = allProviders.map((e) => e['role'].toString()).toSet().toList();
    roles.sort();
    return ['All', ...roles];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Search Providers")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Search Field
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search by name',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                searchQuery = value;
                applyFilters();
              },
            ),
            const SizedBox(height: 10),

            // Role Filter and Sort Dropdown
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value!;
                        applyFilters();
                      });
                    },
                    items: getAllRoles()
                        .map((role) => DropdownMenuItem(
                              value: role,
                              child: Text(role),
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedPriceSort,
                    onChanged: (value) {
                      setState(() {
                        selectedPriceSort = value!;
                        applyFilters();
                      });
                    },
                    items: const [
                      DropdownMenuItem(value: 'None', child: Text('No Sort')),
                      DropdownMenuItem(value: 'Low to High', child: Text('Price: Low to High')),
                      DropdownMenuItem(value: 'High to Low', child: Text('Price: High to Low')),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Providers List
            Expanded(
              child: filteredProviders.isEmpty
                  ? const Center(child: Text("No providers found."))
                  : ListView.builder(
                      itemCount: filteredProviders.length,
                      itemBuilder: (context, index) {
                        final p = filteredProviders[index];
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(p['image']),
                            ),
                            title: Text(p['name']),
                            subtitle: Text("${p['role']} • Rs. ${p['minAmount']}"),
                            trailing: const Icon(Icons.arrow_forward_ios),
                           onTap: () async {
  try {
    final role = p['role'];
    final serviceRes = await dio.get(
      'http://192.168.1.66:3000/api/services/find-by-role/$role',
    );

    if (serviceRes.data['success']) {
      final serviceId = serviceRes.data['service']['_id'];

      // Navigate to details screen with provider + serviceId
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProviderDetailScreen(
            provider: p,
            serviceId: serviceId,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Service not found for role: $role')),
      );
    }
  } catch (e) {
    print('❌ Error fetching service by role: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Failed to fetch service details.')),
    );
  }
},

                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
