/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? width;
  final text;
  final colors;

  const MyTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.colors,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          textStyle: TextStyle(fontSize: 20),
        ),
        onPressed: onPressed,
        child: Text(text,
            style: TextStyle(
              color: colors,
              fontFamily: 'medium',
              fontSize: 14,
            )),
      ),
    );
  }
}
