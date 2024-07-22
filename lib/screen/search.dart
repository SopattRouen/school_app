import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 18, 29, 65),
      body: Center(
        child: Text(
          "ស្វែងរក",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
