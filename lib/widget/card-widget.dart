import 'package:flutter/material.dart';
import 'package:school_app/helper/grid-image.dart';
import 'package:school_app/widget/grade.dart';
import 'package:school_app/widget/score.dart';
import 'package:school_app/widget/subject.dart';
import 'package:school_app/widget/test.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({super.key, required this.imageView});
  final ImageView imageView;
  // Map titles to pages
  Map<String, Widget> get pageMap {
    return {
      'មុខវិជ្ជា': SubjectPage(),
      'ពិន្ទុរ': ScorePage(),
      'តេស្ត': TestPage(),
      'ចំណាត់ថ្នាក់': GradePage(),
      // Add other mappings here
    };
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return pageMap[imageView.title] ??
              Container(); // Provide a fallback in case the title doesn't match
        }));
      },
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            Image(
              height: 90,
              image: AssetImage(
                "${imageView.img}",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text("${imageView.title}"),
          ],
        ),
      ),
    );
  }
}
