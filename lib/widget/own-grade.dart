import 'package:flutter/material.dart';
import 'package:school_app/model/grade.dart';
import 'package:school_app/service/authentication.dart';
import 'package:school_app/service/service.dart';

class OwnGrade extends StatefulWidget {
  const OwnGrade({super.key});

  @override
  State<OwnGrade> createState() => _OwnGradeState();
}

class _OwnGradeState extends State<OwnGrade> {
  late Future<GradeModel> ownGradeFuture;
  final Authentication _auth = Authentication();
  final Services _services =
      Services(); // Move Services instance outside initState

  @override
  void initState() {
    super.initState();
    final userId = _auth.userId;
    ownGradeFuture = _services.getGradeById(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<GradeModel>(
        future: ownGradeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error fetching data: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No Data Found'));
          } else {
            final ownGrade = snapshot.data!;
            return ListView(
              padding: EdgeInsets.all(15),
              children: [
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ឈ្មោះ៖ ${ownGrade.name}"),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                          'ពិន្ទុរសរុប: ${ownGrade.totalScore!.toStringAsFixed(2)}'),
                      SizedBox(
                        height: 15,
                      ),
                      Text('មធ្យមភាគ: ${ownGrade.average.toStringAsFixed(2)}'),
                      SizedBox(
                        height: 15,
                      ),
                      Text("និទ្ទេស: ${ownGrade.grade}"),
                      Divider(),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(''),
                    Column(
                      children: [
                        Text("បានឃើញនិងឯកភាព"),
                        Image(
                          height: 50,
                          image: AssetImage('images/stamp.png'),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("នាយកសាលា"),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
