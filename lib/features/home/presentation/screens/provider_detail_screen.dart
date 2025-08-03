// import 'package:flutter/material.dart';
// import 'package:ghar_sewa/features/home/presentation/screens/booking_form_screen.dart';

// class ProviderDetailScreen extends StatelessWidget {
//   final Map<String, String> provider;

//   const ProviderDetailScreen({super.key, required this.provider});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Center(
//                 child: CircleAvatar(
//                   radius: 50,
//                   backgroundImage: NetworkImage(provider['image']!),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 provider['name']!,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 provider['role'] ?? "Plumber",
//                 style: const TextStyle(color: Colors.grey),
//               ),

//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: const [
//                   InfoCard(icon: Icons.star, label: "4.8", sub: "Rating"),
//                   InfoCard(
//                     icon: Icons.shopping_bag,
//                     label: "56",
//                     sub: "Orders",
//                   ),
//                   InfoCard(
//                     icon: Icons.work,
//                     label: "4 Years",
//                     sub: "Experience",
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 16),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Skills",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const Wrap(
//                 spacing: 8,
//                 children: [
//                   SkillChip("Sink"),
//                   SkillChip("Shower"),
//                   SkillChip("Boiler"),
//                   SkillChip("Toilet"),
//                 ],
//               ),

//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder:
//                             (_) => BookingFormScreen(
//                               providerName: provider['name']!,
//                               serviceName: provider['role'] ?? 'Service',
//                               minimumAmount: provider['minAmount'] ?? 'Rs. 500',
//                             ),
//                       ),
//                     );
//                   },
//                   child: const Text("Book"),
//                 ),
//               ),

//               const SizedBox(height: 24),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Bio",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 "I'm Emily Jani, a dedicated plumbing professional with a passion for delivering top notch service "
//                 "to ensure your home's plumbing runs smoothly. With years of hands-on experience.",
//               ),

//               const SizedBox(height: 24),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Text(
//                     "Gallery",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   Text("View all", style: TextStyle(color: Colors.blue)),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               SizedBox(
//                 height: 80,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: 4,
//                   itemBuilder:
//                       (_, index) => ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           "https://cdn.pixabay.com/photo/2016/03/27/19/56/worker-1280649_1280.jpg",
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                   separatorBuilder: (_, __) => const SizedBox(width: 8),
//                 ),
//               ),

//               const SizedBox(height: 24),
//               const Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Review",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               const ReviewTile(name: "Josh Peter", date: "12/12/2024"),
//               const ReviewTile(name: "Caleb", date: "12/12/2024"),
//               const ReviewTile(name: "Ethan", date: "12/12/2024"),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class InfoCard extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String sub;

//   const InfoCard({
//     super.key,
//     required this.icon,
//     required this.label,
//     required this.sub,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Icon(icon, color: Colors.orange),
//         const SizedBox(height: 4),
//         Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
//         Text(sub, style: const TextStyle(fontSize: 12, color: Colors.grey)),
//       ],
//     );
//   }
// }

// class SkillChip extends StatelessWidget {
//   final String skill;

//   const SkillChip(this.skill, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Chip(label: Text(skill));
//   }
// }

// class ReviewTile extends StatelessWidget {
//   final String name;
//   final String date;

//   const ReviewTile({super.key, required this.name, required this.date});

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: const CircleAvatar(
//         backgroundImage: NetworkImage(
//           "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
//         ),
//       ),
//       title: Text(name),
//       subtitle: const Text(
//         "Emily Jani exceeded my expectations! Quick, reliable, and fixed my plumbing issue.",
//       ),
//       trailing: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.star, color: Colors.amber, size: 16),
//           Text(date, style: const TextStyle(fontSize: 10)),
//         ],
//       ),
//     );
//   }
// }
