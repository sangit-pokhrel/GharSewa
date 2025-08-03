import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:dio/dio.dart';

class MyFavouritesScreen extends StatefulWidget {
  const MyFavouritesScreen({super.key});

  @override
  State<MyFavouritesScreen> createState() => _MyFavouritesScreenState();
}

class _MyFavouritesScreenState extends State<MyFavouritesScreen> {
  final Dio dio = Dio();
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  List<dynamic> favourites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFavourites();
  }

  Future<void> _fetchFavourites() async {
    try {
      final favIdsStr = await storage.read(key: 'favorite_providers');
      final List<String> favIds = favIdsStr != null && favIdsStr.isNotEmpty
          ? List<String>.from(
              (favIdsStr.split(',')).where((id) => id.trim().isNotEmpty).map((e) => e.trim()),
            )
          : [];

      final List<dynamic> fetchedProviders = [];

      if (favIds.isEmpty) {
        // Add default provider if no favourites are found
        fetchedProviders.add({
          "_id": "688e68fc9e704cdd0dc2536c",
          "name": "John Doe",
          "role": "Electrician",
          "rating": 4.5,
          "image": "https://t3.ftcdn.net/jpg/02/43/12/34/240_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg",
          "minAmount": "2500",
          "__v": 0
        });
      } else {
        for (String id in favIds) {
          try {
            final res = await dio.get('http://192.168.1.66:3000/api/providers/$id');
            fetchedProviders.add(res.data);
          } catch (e) {
            print('❌ Error fetching provider $id: $e');
          }
        }
      }

      setState(() {
        favourites = fetchedProviders;
        isLoading = false;
      });
    } catch (e) {
      print('❌ Error loading favourites: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> _removeFromFavourites(String providerId) async {
    try {
      final favIdsStr = await storage.read(key: 'favorite_providers');
      if (favIdsStr == null) return;
      final List<String> favIds = favIdsStr.split(',');
      favIds.remove(providerId);
      await storage.write(key: 'favorite_providers', value: favIds.join(','));

      setState(() {
        favourites.removeWhere((item) => item['_id'] == providerId);
      });
    } catch (e) {
      print('❌ Error removing favourite: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to remove favourite')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Favourites')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : favourites.isEmpty
              ? const Center(child: Text("No favourites yet."))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: favourites.length,
                  itemBuilder: (context, index) {
                    final provider = favourites[index];

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: const EdgeInsets.only(bottom: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            provider['image'] ?? 'https://via.placeholder.com/150',
                          ),
                        ),
                        title: Text(
                          provider['name'] ?? 'No Name',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(provider['role'] ?? 'Unknown Role'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeFromFavourites(provider['_id']),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/serviceproviders',
                            arguments: provider,
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
