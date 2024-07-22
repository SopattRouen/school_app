import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("តេស្ត"),
      ),
      body: Center(
        child: Text("បច្ចុប្បន្នមិនទាន់មានតេស្តនៅឡើយទេ"),
      ),
    );
  }
}
