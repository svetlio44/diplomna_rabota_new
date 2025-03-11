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
        // leading: IconButton(
        //   onPressed: () {
        //   //   Navigator.push(context,
        //   //       MaterialPageRoute(builder: (context) => const Camera()));
        //   // },
        //   icon: Icon(Icons.camera_alt_outlined),
        // ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.favorite_border)),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Profile.id);
            },
            icon: Icon(Icons.person),
          ),
          popUpMenu(),
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Feeds',
          style: TextStyle(color: Colors.black, fontFamily: 'medium'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: _filterAds,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: filteredAds.length,
                itemBuilder: (context, index) {
                  final ad = filteredAds[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
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
        onPressed: () {
          Navigator.pushNamed(context, AddAd.id);
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
class Item {
  const Item(this.name);
  final String name;
}