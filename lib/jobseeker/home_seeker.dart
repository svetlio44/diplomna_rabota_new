import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:diplomna_rabota_new/pages/view_ad.dart';
import 'package:diplomna_rabota_new/pages/liked_ads.dart';
import 'package:diplomna_rabota_new/widget/popupMenu.dart';
import '../components/styles.dart';

class Home_Seeker extends StatefulWidget {
  static const String id = 'Home';

  const Home_Seeker({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home_Seeker> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> likedAdIds = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadLikedAds();
  }

  @override
  void dispose() {
    _saveLikedAds();
    super.dispose();
  }

  Future<void> _loadLikedAds() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? likedIds = prefs.getStringList('likedAdIds');
    if (likedIds != null) {
      setState(() {
        likedAdIds = likedIds;
      });
    }
  }

  Future<void> _saveLikedAds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('likedAdIds', likedAdIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LikedAdsPage(likedAdIds: likedAdIds),
              ),
            ),
            icon: const Icon(Icons.favorite_border),
          ),
          popUpMenu(),
        ],
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black54),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black, fontFamily: 'medium'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchField(),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('ads')
                    .where('status', isEqualTo: 'active')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Error loading ads'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final ads = snapshot.data!.docs;
                  final filteredAds = _searchQuery.isEmpty
                      ? ads
                      : ads.where((ad) {
                    final data = ad.data() as Map<String, dynamic>;
                    return data['title']
                        .toString()
                        .toLowerCase()
                        .contains(_searchQuery.toLowerCase()) ||
                        data['description']
                            .toString()
                            .toLowerCase()
                            .contains(_searchQuery.toLowerCase());
                  }).toList();

                  return _buildAdsGrid(filteredAds);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      onChanged: (value) => setState(() => _searchQuery = value),
    );
  }

  Widget _buildAdsGrid(List<QueryDocumentSnapshot> ads) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: ads.length,
      itemBuilder: (context, index) {
        final ad = ads[index];
        final data = ad.data() as Map<String, dynamic>;
        final isLiked = likedAdIds.contains(ad.id);

        return Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: InkWell(
            onTap: () => _navigateToAdDetail(context, data),
            borderRadius: BorderRadius.circular(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15)),
                    child: data['imageUrl'] != null && data['imageUrl']!.isNotEmpty
                        ? Image.network(
                      data['imageUrl']!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image),
                    )
                        : Image.asset(
                      'assets/images/hamalski_uslugi.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'] ?? 'No Title',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '€${data['price'] ?? 'No Price'}',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.grey,
                            ),
                            onPressed: () => _toggleLike(ad.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleLike(String adId) {
    setState(() {
      if (likedAdIds.contains(adId)) {
        likedAdIds.remove(adId);
      } else {
        likedAdIds.add(adId);
      }
      _saveLikedAds();
    });
  }

  void _navigateToAdDetail(BuildContext context, Map<String, dynamic> data) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAd(
          title: data['title'] ?? 'No Title',
          description: data['description'] ?? 'No Description',
          price: data['price'] ?? 'No Price',
          imagePath: data['imageUrl'] ?? 'assets/images/hamalski_uslugi.png',
          phoneNumber: data['phoneNumber'] ?? 'N/A',
          email: data['email'] ?? 'N/A',
        ),
      ),
    );
  }
}