/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/ad_detail.dart';
import '../components/styles.dart';

class MyProfile extends StatefulWidget {
  static const String id = 'MyProfile';

  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 1, // Само един таб
        child: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                centerTitle: true,
                title: Text('My Profile',
                    style:
                    TextStyle(color: Colors.black, fontFamily: 'medium')),
                floating: true,
                pinned: true,
                snap: false,
                expandedHeight: 240.0,
                backgroundColor: Colors.white,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    background: Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                AssetImage('assets/images/33.png'),
                                radius: 42,
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    blackBoldText('Светлозар Кралев'),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            boldText('2'),
                                            greyTextSmall('Ads')
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            boldText('23m'),
                                            greyTextSmall('Followers')
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            boldText('12k'),
                                            smallText('Following')
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Действие за редактиране на профила
                                      },
                                      child: Text('Edit Profile'),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ),
            ];
          },
          body: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24.0),
                          child: Text(
                            'My Ads',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildAdsSection(), // Нова секция за обявите
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdsSection() {
    final List<Map<String, String>> ads = [
      {
        'title': 'Обява 1',
        'description': 'Ad Description 1',
        'price': '100',
        'image': 'assets/images/32.jpg',
      },
      {
        'title': 'Обява 2',
        'description': 'Ad Description 2',
        'price': '200',
        'image': 'assets/images/31.jpg',
      },
      // Добавете още обяви тук
    ];

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: ads.map((ad) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              leading: Image.asset(ad['image']!, fit: BoxFit.cover, width: 50),
              title: Text(ad['title']!),
              subtitle: Text(ad['description']!),
              trailing: Text('\$${ad['price']}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdDetail(
                      title: ad['title']!,
                      description: ad['description']!,
                      price: ad['price']!,
                      image: ad['image']!,
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}