import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diplomna_rabota_new/pages/view_ad.dart';

class LikedAdsPage extends StatelessWidget {
  final List<String> likedAdIds;

  const LikedAdsPage({Key? key, required this.likedAdIds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Liked Ads'),
        centerTitle: true,
      ),
      body: likedAdIds.isEmpty
          ? const Center(child: Text('No liked ads'))
          : StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('ads')
            .where(FieldPath.documentId, whereIn: likedAdIds)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading ads'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final ads = snapshot.data!.docs;

          return ListView.builder(
            itemCount: ads.length,
            itemBuilder: (context, index) {
              final ad = ads[index];
              final data = ad.data() as Map<String, dynamic>;

              // Handle potential null values
              final String imageUrl = data['imageUrl'] ?? 'default_image_url';
              final String title = data['title'] ?? 'No Title';
              final String price = data['price'] ?? 'No Price';
              final String description = data['description'] ?? 'No Description';
              final String phoneNumber = data['phoneNumber'] ?? 'N/A';
              final String email = data['email'] ?? 'N/A';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: data['imageUrl'] != null && data['imageUrl']!.isNotEmpty
                        ? Image.network(
                      data['imageUrl']!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image),
                    )
                        : Image.asset(
                      'assets/images/hamalski_uslugi.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(title),
                  subtitle: Text('Price: €$price'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ViewAd(
                          title: title,
                          description: description,
                          price: price,
                          phoneNumber: phoneNumber,
                          email: email,
                          imagePath: data['imageUrl'] ?? 'assets/images/hamalski_uslugi.png',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}