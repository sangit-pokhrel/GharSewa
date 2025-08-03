import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ghar_sewa/features/home/presentation/screens/booking_form_screen.dart';

class ProviderDetailScreen extends StatefulWidget {
  final Map<String, dynamic> provider;
  final String serviceId;

  const ProviderDetailScreen({
    super.key,
    required this.provider,
    required this.serviceId,
  });

  @override
  State<ProviderDetailScreen> createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  final Dio _dio = Dio();
  final _storage = const FlutterSecureStorage();
  final TextEditingController _reviewController = TextEditingController();
  List<dynamic> reviews = [];
  double _rating = 5.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }

Future<void> _fetchReviews() async {
  try {
    final providerId = widget.provider['_id'];

    final response = await _dio.get('http://192.168.1.66:3000/api/reviews');
    print("📥 All reviews fetched: ${response.data}");

    List<dynamic> allReviews = response.data['reviews'] ?? [];

    // ✅ Filter only reviews where userId == providerId
    final filteredReviews = allReviews.where((review) {
      return review['userId'] == providerId;
    }).toList();

    setState(() {
      reviews = filteredReviews;
      isLoading = false;
    });

    print("✅ Filtered reviews for provider $providerId: $filteredReviews");
  } catch (e) {
    print("❌ Error fetching reviews: $e");
    setState(() => isLoading = false);
  }
}


Future<void> _submitReview() async {
  final reviewText = _reviewController.text.trim();
  if (reviewText.isEmpty) return;

  final serviceId = widget.serviceId;
  final providerId = widget.provider['_id'];
  final name = await _storage.read(key: 'name') ?? "John Doe";

  final reviewData = {
    'provider': serviceId,
    'userId': providerId,
    'reviewMessage': reviewText,
    'rating': _rating,
    'customerName': name,
  };

  print("📤 Sending review payload: $reviewData");

  try {
    final response = await _dio.post(
      'http://192.168.1.66:3000/api/reviews',
      data: reviewData,
    );
    print("✅ Review post response: ${response.data}");

    _reviewController.clear();
    _rating = 5.0;
    await _fetchReviews();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Review submitted')),
    );
  } catch (e) {
    if (e is DioException) {
      print("❌ DioError response: ${e.response?.data}");
      print("❌ DioError message: ${e.message}");
    } else {
      print("❌ Unknown error: $e");
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final provider = widget.provider;

    return Scaffold(
      appBar: AppBar(title: Text(provider['name'] ?? 'Provider')),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            provider['image'] != null
                                ? NetworkImage(provider['image'])
                                : const AssetImage(
                                      'assets/images/default_user.png',
                                    )
                                    as ImageProvider,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Center(
                      child: Text(
                        provider['name'] ?? '',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        provider['role'] ?? '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    Center(
                      child: Text(
                        'Min Price: Rs. ${provider['minAmount'] ?? 'N/A'}',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 16),

                    ElevatedButton.icon(
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text("Book Now"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => BookingFormScreen(
                                  providerId: provider['_id'],
                                  serviceId: widget.serviceId,
                                  providerName: provider['name'] ?? '',
                                  serviceName: provider['role'] ?? '',
                                  minimumAmount:
                                      provider['minAmount']?.toString() ?? '',
                                ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                    const Divider(),
                    const Text(
                      "About",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "This provider is highly skilled and certified. Available all week and responds quickly.",
                      style: TextStyle(color: Colors.black54),
                    ),

                    const SizedBox(height: 20),
                    const Divider(),

                    const Text(
                      "Post a Review",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _reviewController,
                      decoration: InputDecoration(
                        hintText: "Write your review...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text("Rating: "),
                            ...List.generate(5, (i) {
                              return IconButton(
                                icon: Icon(
                                  Icons.star,
                                  color:
                                      _rating >= i + 1
                                          ? Colors.amber
                                          : Colors.grey,
                                ),
                                onPressed:
                                    () => setState(
                                      () => _rating = (i + 1).toDouble(),
                                    ),
                              );
                            }),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: _submitReview,
                          icon: const Icon(Icons.send),
                          label: const Text("Submit"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Divider(),
                    const Text(
                      "Reviews",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    reviews.isEmpty
                        ? const Text(
                          "No reviews yet.",
                          style: TextStyle(color: Colors.grey),
                        )
                        : Column(
                          children:
                              reviews.map((r) {
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: ListTile(
                                    title: Text(r['reviewMessage'] ?? ''),
                                    subtitle: Text(
                                      "⭐ ${r['rating']} by ${r['customerName'] ?? ''}",
                                    ),
                                    leading: const Icon(Icons.comment),
                                  ),
                                );
                              }).toList(),
                        ),
                  ],
                ),
              ),
    );
  }
}
