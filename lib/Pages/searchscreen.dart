import 'package:flutter/material.dart';
import 'package:testingapp/methods/appbar.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: const Center(
        child: Text("SearchScreen"),
      ),
    );
  }
}
