import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/add_ad.dart';
import 'package:diplomna_rabota_new/pages/view_ad.dart';
import 'package:diplomna_rabota_new/pages/profile.dart';
import 'package:diplomna_rabota_new/widget/popupMenu.dart';
import '../components/styles.dart';

class Home extends StatefulWidget {
  static const String id = 'Home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Map<String, String>> ads = const [
    {
      'title': 'Sample Title 1',
      'description': 'Sample Description 1',
      'price': '100',
      'image': 'assets/images/32.jpg',
    },
    {
      'title': 'Sample Title 2',
      'description': 'Sample Description 2',
      'price': '200',
      'image': 'assets/images/31.jpg',
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
    final searchLower = query.toLowerCase();
    setState(() {
      filteredAds = ads.where((ad) {
        final titleLower = ad['title']!.toLowerCase();
        final descriptionLower = ad['description']!.toLowerCase();
        return titleLower.contains(searchLower) || descriptionLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Profile.id),
            icon: const Icon(Icons.person),
          ),
          popUpMenu(),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Feeds',
          style: TextStyle(color: Colors.black, fontFamily: 'medium'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterAds,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAds.length,
                itemBuilder: (context, index) {
                  final ad = filteredAds[index];
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
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, AddAd.id),
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
class Item {
  const Item(this.name);
  final String name;
}