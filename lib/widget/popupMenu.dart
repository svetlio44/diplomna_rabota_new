/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:diplomna_rabota_new/pages/notifications.dart';
import 'package:diplomna_rabota_new/pages/order_detail.dart';
import 'package:diplomna_rabota_new/pages/settings.dart';

class popUpMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.more_vert),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        // PopupMenuItem(
        //         //     child: Text('AdsDetail'),
        //         //     onTap: () => Future(
        //         //           () => Navigator.of(context).push(
        //         //             MaterialPageRoute(builder: (_) => AdsDetail()),
        //         //           ),
        //         //         )),
        PopupMenuItem(
            child: Text('Settings'),
            onTap: () => Future(
                  () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => Settings()),
                  ),
                )),
        // PopupMenuItem(
        //     child: Text('Notifications'),
        //     onTap: () => Future(
        //           () => Navigator.of(context).push(
        //             MaterialPageRoute(builder: (_) => Notifications()),
        //           ),
        //         )),
      ],
    );
  }
}
