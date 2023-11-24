import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



Widget buildBottomNavigationBar(BuildContext context) {
  return Container(
    width: 390,
    height: 82,
    decoration: ShapeDecoration(
      color: Color(0xFFF9F9FB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      shadows: [
        BoxShadow(
          color: Color(0x0C000000),
          blurRadius: 4,
          offset: Offset(0, -2),
          spreadRadius: 0,
        )
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(right: 80.0,left: 80.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/calender');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.calendar, color: Color(0xFFADB5BD)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/main');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.house, color: Color(0xFFADB5BD)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, '');
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.person_add, color: Color(0xFFADB5BD)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
