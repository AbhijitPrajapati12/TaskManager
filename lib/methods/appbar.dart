import 'package:flutter/material.dart';

AppBar customAppBar() {
  return AppBar(
    actions: [
      Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          child: Image.asset('assets/images/Personpic.png'),
        ),
      ),
    ],
  );
}
