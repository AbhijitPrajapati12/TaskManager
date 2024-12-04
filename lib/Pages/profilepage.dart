import 'package:flutter/material.dart';
import 'package:testingapp/methods/appbar.dart';
import 'package:testingapp/methods/draweroptions.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerOptions(),
      appBar: customAppBar(),
      body: const Center(
        child: Text("Profile Page"),
      ),
    );
  }
}
