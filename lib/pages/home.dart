import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/camera.dart';
import 'package:diplomna_rabota_new/pages/comment.dart';
import 'package:diplomna_rabota_new/pages/add_ad.dart';
import 'package:diplomna_rabota_new/pages/ads_list.dart';
import 'package:diplomna_rabota_new/pages/search_ads.dart';
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
  int tabID = 1;

  List<Item> categoryList = <Item>[
    Item('#Travel'),
    Item('#Food'),
    Item('#Fashion'),
    Item('#Gaming'),
    Item('#Technology'),
    Item('#lorem'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Camera()));
          },
          icon: Icon(Icons.camera_alt_outlined),
        ),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    children: categoryList.map((e) {
                      return _buildCategory(context, e);
                    }).toList(),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.only(left: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: backgroundColor,
                        child: Icon(Icons.add, color: Colors.black38, size: 20),
                      ),
                      SizedBox(width: 10),
                      _buildButton(context, 'Add Ad', AddAd.id),
                      SizedBox(width: 10),
                      _buildButton(context, 'View Ads', AdsList.id),
                      SizedBox(width: 10),
                      _buildButton(context, 'Search Ads', SearchAds.id),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(context, e) {
    return GestureDetector(
      onTap: () {
        setState(() {
          tabID = e.hashCode;
        });
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: tabID == e.hashCode ? appColorBtn : Colors.white,
          border: Border.all(
            color: tabID == e.hashCode ? appColorBtn : Colors.black38,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Text(
          e.name,
          style: TextStyle(
              color: tabID == e.hashCode ? Colors.white : Colors.black38,
              fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String route) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: appColorBtn,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        textStyle: TextStyle(fontSize: 16, fontFamily: 'medium'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
      ),
      child: Text(text),
    );
  }
}
class Item {
  const Item(this.name);
  final String name;
}