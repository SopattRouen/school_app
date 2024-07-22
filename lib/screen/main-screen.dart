import 'package:flutter/material.dart';
import 'package:school_app/screen/home.dart';
import 'package:school_app/screen/profile.dart';
import 'package:school_app/screen/search.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final _page = [
    HomePage(),
    Search(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 18, 29, 65),
          indicatorColor: Color.fromARGB(255, 18, 29, 65),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(color: Colors.white),
          ),
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return IconThemeData(color: Colors.blue);
            }
            return IconThemeData(color: Colors.white);
          }),
        ),
        child: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'ទំព័រដើម',
            ),
            NavigationDestination(
              icon: Icon(Icons.search),
              label: 'ស្វែងរក',
            ),
            NavigationDestination(
              icon: Icon(Icons.person),
              label: 'គណនី',
            ),
          ],
          selectedIndex: index,
          elevation: 0,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (value) {
            setState(() {
              index = value;
            });
          },
        ),
      ),
    );
  }
}
