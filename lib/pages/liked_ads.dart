import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/view_ad.dart';

class LikedAdsPage extends StatelessWidget {
  final List<Map<String, String>> likedAds;

  const LikedAdsPage({Key? key, required this.likedAds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Връща назад към предходната страница
          },
        ),
        title: Text('Liked Ads'),
        centerTitle: true,
      ),
      body: likedAds.isEmpty
          ? Center(child: Text('No liked ads'))
          : ListView.builder(
        itemCount: likedAds.length,
        itemBuilder: (context, index) {
          final ad = likedAds[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Image.asset(ad['image']!, width: 50, fit: BoxFit.cover),
              title: Text(ad['title']!),
              subtitle: Text('Price: ${ad['price']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewAd(
                      title: ad['title']!,
                      description: ad['description']!,
                      price: ad['price']!,
                      phoneNumber: ad['phone number']!,
                      email: ad['email']!,
                      imagePath: ad['image']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}