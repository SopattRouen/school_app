import 'package:flutter/material.dart';
import 'package:school_app/model/score.dart';
import 'package:school_app/service/authentication.dart';
import 'package:school_app/service/service.dart';

class OwnScoreWidget extends StatefulWidget {
  const OwnScoreWidget({super.key});

  @override
  State<OwnScoreWidget> createState() => _OwnScoreWidgetState();
}

class _OwnScoreWidgetState extends State<OwnScoreWidget> {
  late Future<List<ScoreData>> ownScoresFuture;
  final Authentication _auth = Authentication();
  @override
  void initState() {
    super.initState();
    final Services _services = Services();
    final userId = _auth.userId;
    ownScoresFuture = _services.getScoreByScoreId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ScoreData>>(
        future: ownScoresFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Data Found'));
          } else {
            final ownScores = snapshot.data!;
            final studentName =
                ownScores.isNotEmpty ? ownScores[0].studentName : 'Unknown';

            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("ឈ្មោះ៖​​ ${studentName}"),
                      Text("ពិន្ទុរ"),
                    ],
                  ),
                ),
                Divider(),
                ...ownScores.map((score) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text('${score.subjectName}'),
                        trailing: Text('${score.score}ពិន្ទុរ'),
                      ),
                    ],
                  );
                }).toList(),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
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
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
