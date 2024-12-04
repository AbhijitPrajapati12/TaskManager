import 'package:flutter/material.dart';
import 'package:testingapp/methods/bottomnavigation.dart';
import 'package:testingapp/Pages/settingspage.dart';

class DrawerOptions extends StatelessWidget {
  const DrawerOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Task Manager",
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text(
              'Home',
              style: TextStyle(fontSize: 25),
            ),
            leading: const Icon(
              Icons.home,
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const BottomNavigotor(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
          const SizedBox(height: 15),
          ListTile(
            title: const Text(
              'Profile',
              style: TextStyle(fontSize: 25),
            ),
            leading: const Icon(
              Icons.person,
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) {
                    // Create BottomNavigotor with initial page set to Profile
                    return const BottomNavigotor(initialPage: 2);
                  },
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
          const SizedBox(height: 15),
          ListTile(
            title: const Text(
              'Settings',
              style: TextStyle(fontSize: 25),
            ),
            leading: const Icon(
              Icons.settings,
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsPage();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
