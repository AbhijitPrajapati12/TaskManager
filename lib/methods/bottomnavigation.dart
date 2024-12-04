import 'package:flutter/material.dart';
import 'package:testingapp/Pages/homepage.dart';
import 'package:testingapp/Pages/profilepage.dart';
import 'package:testingapp/Pages/searchscreen.dart';
import 'package:testingapp/methods/draweroptions.dart';

class BottomNavigotor extends StatefulWidget {
  final int initialPage;
  const BottomNavigotor({super.key, this.initialPage = 0});

  @override
  State<BottomNavigotor> createState() => _BottomNavigotorState();
}

class _BottomNavigotorState extends State<BottomNavigotor> {
  late int currentPage;

  @override
  void initState() {
    super.initState();
    currentPage = widget.initialPage;
  }

  final List<Widget> pages = [
    const Homepage(),
    const Searchscreen(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerOptions(),
      body: IndexedStack(
        index: currentPage,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        iconSize: 35,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        items: const [
          BottomNavigationBarItem(
            label: '',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}
