import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/view_ad.dart';
import 'package:diplomna_rabota_new/pages/edit_ad.dart';
import 'package:diplomna_rabota_new/pages/delete_ad.dart'; // Добавете този ред

class AdsList extends StatelessWidget {
  static const String id = 'AdsList';

  const AdsList({Key? key}) : super(key: key);

  final List<Map<String, String>> ads = const [
    {
      'title': 'Sample Title 1',
      'description': 'Sample Description 1',
      'price': '100',
    },
    {
      'title': 'Sample Title 2',
      'description': 'Sample Description 2',
      'price': '200',
    },
    // Добавете още обяви тук
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ads List'),
      ),
      body: ListView.builder(
        itemCount: ads.length,
        itemBuilder: (context, index) {
          final ad = ads[index];
          return ListTile(
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
                  ),
                ),
              );
            },
            trailing: Wrap(
              spacing: 12, // space between two icons
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditAd(
                          title: ad['title']!,
                          description: ad['description']!,
                          price: ad['price']!,
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeleteAd(
                          title: ad['title']!,
                          description: ad['description']!,
                          price: ad['price']!,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}