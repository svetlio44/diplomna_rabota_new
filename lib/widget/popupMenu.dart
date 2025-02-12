/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/find_partners.dart';
import 'package:diplomna_rabota_new/pages/grid_two.dart';
import 'package:diplomna_rabota_new/pages/notifications.dart';
import 'package:diplomna_rabota_new/pages/popular.dart';
import 'package:diplomna_rabota_new/pages/order_detail.dart';
import 'package:diplomna_rabota_new/pages/search.dart';
import 'package:diplomna_rabota_new/pages/settings.dart';

class popUpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
            child: Text('Search'),
            onTap: () => Future(
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => Search()),
                  ),
                )),
        // PopupMenuItem(
        //     child: Text('Live TV'),
        //     onTap: () => Future(
        //           () => Navigator.of(context).push(
        //             MaterialPageRoute(builder: (_) => LiveTV()),
        //           ),
        //         )),
        PopupMenuItem(
            child: Text('Popular'),
            onTap: () => Future(
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => Popular()),
                  ),
                )),
        PopupMenuItem(
            child: Text('2colgrid'),
            onTap: () => Future(
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => GridTwoHome()),
                  ),
                )),
        PopupMenuItem(
            child: Text('Post Detail'),
            onTap: () => Future(
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => PostDetail()),
                  ),
                )),
        PopupMenuItem(
            child: Text('Settings'),
            onTap: () => Future(
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => Settings()),
                  ),
                )),
        PopupMenuItem(
            child: Text('Notifications'),
            onTap: () => Future(
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => Notifications()),
                  ),
                )),
        PopupMenuItem(
            child: Text('Find Friends'),
            onTap: () => Future(
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => FindFriends()),
                  ),
                )),
      ],
    );
  }
}
