// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';

// import 'package:ghar_sewa/features/home/presentation/screens/service_provider_detail.dart';

// class ServiceProvidersScreen extends StatefulWidget {
//   final String serviceName;
//   final String serviceId;

//   const ServiceProvidersScreen({
//     super.key,
//     required this.serviceName,
//     required this.serviceId,
//   });

//   @override
//   State<ServiceProvidersScreen> createState() => _ServiceProvidersScreenState();
// }

// class _ServiceProvidersScreenState extends State<ServiceProvidersScreen> {
//   final Set<String> favoriteProviders = {};
//   List<dynamic> providers = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchProviders();
//   }

//   Future<void> fetchProviders() async {
//     print("🔍 fetchProviders() called with serviceName: ${widget.serviceName}");

//     try {
//       final response = await Dio().get(
//         'http://192.168.1.66:3000/api/providers',
//       );
//       final allProviders = response.data;

//       print("📦 Providers API Response: $allProviders");

//       // Log each role for debug
//       for (var p in allProviders) {
//         print("🧪 Checking provider: ${p['name']} with role: ${p['role']}");
//       }

//       setState(() {
//         providers =
//             allProviders
//                 .where(
//                   (p) =>
//                       (p['role']?.toString().toLowerCase() ?? '') ==
//                       widget.serviceName.toLowerCase(),
//                 )
//                 .toList();
//         isLoading = false;
//       });

//       print("✅ Filtered providers count: ${providers.length}");
//     } catch (e) {
//       print("❌ Error fetching providers: $e");
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('${widget.serviceName} Providers')),
//       body:
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : providers.isEmpty
//               ? const Center(child: Text("No providers found."))
//               : Padding(
//                 padding: const EdgeInsets.all(12),
//                 child: GridView.builder(
//                   itemCount: providers.length,
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 12,
//                     mainAxisSpacing: 12,
//                     childAspectRatio: 0.75,
//                   ),
//                   itemBuilder: (context, index) {
//                     final provider = providers[index];
//                     final isFavorite = favoriteProviders.contains(
//                       provider['name'],
//                     );
//                     final image = provider['image'] ?? '';
//                     final name = provider['name'] ?? 'N/A';
//                     final rating = provider['rating']?.toString() ?? '0.0';
//                     final minAmount = provider['minAmount'] ?? 'N/A';

//                     return Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey.shade100,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       padding: const EdgeInsets.all(10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           CircleAvatar(
//                             radius: 36,
//                             backgroundImage: NetworkImage(image),
//                           ),
//                           Column(
//                             children: [
//                               Text(
//                                 name,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                               Text(
//                                 widget.serviceName,
//                                 style: const TextStyle(color: Colors.grey),
//                               ),
//                               const SizedBox(height: 4),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   const Icon(
//                                     Icons.star,
//                                     color: Colors.amber,
//                                     size: 16,
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Text(rating),
//                                 ],
//                               ),
//                               Text(
//                                 "Min: Rs. $minAmount",
//                                 style: const TextStyle(
//                                   fontSize: 12,
//                                   color: Colors.black54,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder:
//                                           (_) => ProviderDetailScreen(
//                                             provider:
//                                                 provider, // your existing provider map
//                                             serviceId: widget.serviceId 
//                                           ),
//                                     ),
//                                   );
//                                 },

//                                 child: const Text("Details"),
//                               ),
//                               IconButton(
//                                 icon: Icon(
//                                   isFavorite
//                                       ? Icons.favorite
//                                       : Icons.favorite_border,
//                                   color: isFavorite ? Colors.red : Colors.grey,
//                                 ),
//                                 onPressed: () {
//                                   setState(() {
//                                     isFavorite
//                                         ? favoriteProviders.remove(name)
//                                         : favoriteProviders.add(name);
//                                   });
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                         isFavorite
//                                             ? "Removed from favorites"
//                                             : "Added to favorites",
//                                       ),
//                                       duration: const Duration(seconds: 1),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//               ),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: Theme.of(context).primaryColor,
//         unselectedItemColor: Colors.grey,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.location_city),
//             label: "City",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_bag),
//             label: "Order",
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }
// }



// ✅ ServiceProvidersScreen with Secure Storage Favorite Handling
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ghar_sewa/features/home/presentation/screens/service_provider_detail.dart';

class ServiceProvidersScreen extends StatefulWidget {
  final String serviceName;
  final String serviceId;

  const ServiceProvidersScreen({
    super.key,
    required this.serviceName,
    required this.serviceId,
  });

  @override
  State<ServiceProvidersScreen> createState() => _ServiceProvidersScreenState();
}

class _ServiceProvidersScreenState extends State<ServiceProvidersScreen> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final Set<String> favoriteProviderIds = {};
  List<dynamic> providers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProviders();
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    final favs = await _storage.read(key: 'favoriteProviderIds');
    if (favs != null) {
      setState(() {
        favoriteProviderIds.addAll(List<String>.from(jsonDecode(favs)));
      });
    }
  }

  Future<void> updateFavoritesStorage() async {
    await _storage.write(
      key: 'favoriteProviderIds',
      value: jsonEncode(favoriteProviderIds.toList()),
    );
  }

  Future<void> fetchProviders() async {
    try {
      final response = await Dio().get('http://192.168.1.66:3000/api/providers');
      final allProviders = response.data;

      setState(() {
        providers = allProviders.where((p) => (p['role']?.toString().toLowerCase() ?? '') == widget.serviceName.toLowerCase()).toList();
        isLoading = false;
      });
    } catch (e) {
      print("❌ Error fetching providers: $e");
      setState(() => isLoading = false);
    }
  }

  void toggleFavorite(String id) async {
    setState(() {
      if (favoriteProviderIds.contains(id)) {
        favoriteProviderIds.remove(id);
      } else {
        favoriteProviderIds.add(id);
      }
    });
    await updateFavoritesStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.serviceName} Providers')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : providers.isEmpty
              ? const Center(child: Text("No providers found."))
              : Padding(
                  padding: const EdgeInsets.all(12),
                  child: GridView.builder(
                    itemCount: providers.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                    itemBuilder: (context, index) {
                      final provider = providers[index];
                      final isFavorite = favoriteProviderIds.contains(provider['_id']);
                      final image = provider['image'] ?? '';
                      final name = provider['name'] ?? 'N/A';
                      final rating = provider['rating']?.toString() ?? '0.0';
                      final minAmount = provider['minAmount'] ?? 'N/A';

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(radius: 36, backgroundImage: NetworkImage(image)),
                            Column(
                              children: [
                                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                Text(widget.serviceName, style: const TextStyle(color: Colors.grey)),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(rating),
                                  ],
                                ),
                                Text("Min: Rs. $minAmount", style: const TextStyle(fontSize: 12, color: Colors.black54)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                  onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProviderDetailScreen(provider: provider, serviceId: widget.serviceId),
                                    ),
                                  ),
                                  child: const Text("Details"),
                                ),
                                IconButton(
                                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : Colors.grey),
                                  onPressed: () {
                                    toggleFavorite(provider['_id']);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(isFavorite ? "Removed from favorites" : "Added to favorites")),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
