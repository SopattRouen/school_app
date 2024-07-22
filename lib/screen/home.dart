import 'package:flutter/material.dart';
import 'package:school_app/helper/grid-image.dart';
import 'package:school_app/widget/card-widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final _image = ImageView.imag;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ប្រព័ន្ធគ្រប់គ្រងរបស់សាលា',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 18, 29, 65),
      ),
      backgroundColor: Color.fromARGB(255, 18, 29, 65),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: PageScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _image.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final imag = _image[index];
                  return CardWidget(
                    imageView: imag,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
