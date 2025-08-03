import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ghar_sewa/features/home/presentation/navbar_screens/invoice_page.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  List<dynamic> bookings = [];
  List<dynamic> filteredBookings = [];
  bool isLoading = true;

  String searchQuery = '';
  String sortOrder = 'latest'; // or 'oldest'

  @override
  void initState() {
    super.initState();
    _fetchBookings();
  }

  Future<void> _fetchBookings() async {
    final userId = await _storage.read(key: 'userId') ?? '64fc6e5e3545c708e0d0f123';
    final url = 'http://192.168.1.66:3000/api/bookings/user/$userId';

    try {
      final response = await _dio.get(url);
      final data = response.data['data'] ?? [];

      setState(() {
        bookings = data;
        filteredBookings = List.from(data);
        isLoading = false;
      });
    } catch (e) {
      print('❌ Error fetching bookings: $e');
      setState(() => isLoading = false);
    }
  }

  void _applyFilters() {
    List<dynamic> temp = bookings.where((b) {
      final serviceName = (b['service']['name'] ?? '').toString().toLowerCase();
      return serviceName.contains(searchQuery.toLowerCase());
    }).toList();

    if (sortOrder == 'latest') {
      temp.sort((a, b) => DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
    } else {
      temp.sort((a, b) => DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));
    }

    setState(() {
      filteredBookings = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Bookings")),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: "Search by service",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        searchQuery = value;
                        _applyFilters();
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DropdownButtonFormField<String>(
                      value: sortOrder,
                      decoration: const InputDecoration(
                        labelText: "Sort by date",
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'latest', child: Text("Latest First")),
                        DropdownMenuItem(value: 'oldest', child: Text("Oldest First")),
                      ],
                      onChanged: (value) {
                        sortOrder = value!;
                        _applyFilters();
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: filteredBookings.isEmpty
                        ? const Center(child: Text("No bookings found"))
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: filteredBookings.length,
                            itemBuilder: (context, index) {
                              final booking = filteredBookings[index];
                              final provider = booking['provider'];
                              final service = booking['service'];
                              final date = DateTime.tryParse(booking['date'] ?? '');
                              final formattedDate = date != null
                                  ? '${date.day}/${date.month}/${date.year}'
                                  : 'Unknown Date';

                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => InvoicePage(booking: booking),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: provider['image'] != null
                                        ? NetworkImage(provider['image'])
                                        : const AssetImage('assets/images/default_user.png') as ImageProvider,
                                  ),
                                  title: Text(service['name'] ?? 'Service'),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Provider: ${provider['name'] ?? 'N/A'}"),
                                      Text("Date: $formattedDate"),
                                      Text("Address: ${booking['fullAddress'] ?? ''}"),
                                    ],
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
