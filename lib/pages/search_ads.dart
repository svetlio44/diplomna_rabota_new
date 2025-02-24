import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/view_ad.dart';

class SearchAds extends StatefulWidget {
  static const String id = 'SearchAds';

  const SearchAds({Key? key}) : super(key: key);

  @override
  _SearchAdsState createState() => _SearchAdsState();
}

class _SearchAdsState extends State<SearchAds> {
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

  List<Map<String, String>> filteredAds = [];

  @override
  void initState() {
    super.initState();
    filteredAds = ads;
  }

  void _filterAds(String query) {
    final filtered = ads.where((ad) {
      final titleLower = ad['title']!.toLowerCase();
      final descriptionLower = ad['description']!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          descriptionLower.contains(searchLower);
    }).toList();

    setState(() {
      filteredAds = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Ads'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: _filterAds,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAds.length,
                itemBuilder: (context, index) {
                  final ad = filteredAds[index];
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