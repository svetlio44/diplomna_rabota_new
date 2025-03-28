/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';

const appColor = Color(0xFFFFA688);
const appColor2 = Color(0xFF272D69);
const appColorBtn = Color(0xFFEF5859);
const backgroundColor = Color.fromARGB(255, 243, 243, 243);

// Text Styles
const TextStyle boldTextStyle = TextStyle(fontFamily: 'bold', color: Colors.black);
const TextStyle mediumTextStyle = TextStyle(fontFamily: 'medium', color: Colors.black54);

Widget blackHeading(String val) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Text(
      val,
      style: boldTextStyle.copyWith(fontSize: 24),
    ),
  );
}

Widget centerHeading(String val) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: Text(
      val,
      textAlign: TextAlign.center,
      style: boldTextStyle.copyWith(fontSize: 24, color: Colors.white),
    ),
  );
}

Widget blackHeadingSmall(String val) {
  return Text(
    val,
    style: boldTextStyle.copyWith(fontSize: 20),
  );
}

Widget blackText(String val) {
  return Text(
    val,
    style: TextStyle(fontSize: 14, color: Colors.black),
  );
}

Widget boldText(String val) {
  return Text(
    val,
    style: boldTextStyle.copyWith(fontSize: 14),
  );
}

Widget blackBoldText(String val) {
  return Text(
    val,
    style: boldTextStyle.copyWith(fontSize: 18),
  );
}

Widget centerText(String val) {
  return Text(
    val,
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 14, color: Colors.white),
  );
}

Widget greyBoldText(String val) {
  return Text(
    val,
    style: mediumTextStyle.copyWith(fontSize: 15),
  );
}

Widget greyText(String val) {
  return Text(
    val,
    style: TextStyle(fontSize: 14, color: Colors.black54),
  );
}

Widget greyTextSmall(String val) {
  return Text(
    val,
    style: TextStyle(fontSize: 12, color: Colors.black54),
  );
}

Widget smallText(String val) {
  return Text(
    val,
    style: TextStyle(fontSize: 10, color: Colors.black54),
  );
}

Widget appColorText(String val) {
  return Text(
    val,
    style: mediumTextStyle.copyWith(color: appColor2, fontSize: 12),
  );
}

Widget colorText(String val) {
  return Text(
    val,
    style: mediumTextStyle.copyWith(color: appColor, fontSize: 12),
  );
}

Widget textField(String hint, IconData icn) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      decoration: InputDecoration(
        labelText: hint,
        suffixIcon: Icon(
          icn,
          size: 18,
          color: Colors.black12,
        ),
        labelStyle: mediumTextStyle.copyWith(fontSize: 12),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: appColor),
        ),
      ),
    ),
  );
}

Widget searchBox() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(30))),
    child: TextField(
      onChanged: (String txt) {},
      style: const TextStyle(
        fontSize: 14,
      ),
      cursorColor: appColor,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
        suffixIcon: Icon(
          Icons.search,
          color: Colors.black45,
        ),
      ),
    ),
  );
}