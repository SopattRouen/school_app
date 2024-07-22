import 'package:flutter/material.dart';
import 'package:school_app/model/score.dart';
import 'package:school_app/service/service.dart';

class AllScoreWidget extends StatefulWidget {
  const AllScoreWidget({super.key});

  @override
  State<AllScoreWidget> createState() => _AllScoreWidgetState();
}

class _AllScoreWidgetState extends State<AllScoreWidget> {
  late Future<Map<String, List<ScoreData>>> scoreFuture;

  @override
  void initState() {
    super.initState();
    final Services _services = Services();
    scoreFuture = _fetchAndGroupScores(_services);
  }

  Future<Map<String, List<ScoreData>>> _fetchAndGroupScores(
      Services services) async {
    final scores = await services.getScore();
    return _groupScoresByStudent(scores);
  }

  Map<String, List<ScoreData>> _groupScoresByStudent(List<ScoreData> scores) {
    final Map<String, List<ScoreData>> groupedScores = {};
    for (var score in scores) {
      if (!groupedScores.containsKey(score.studentName)) {
        groupedScores[score.studentName] = [];
      }
      groupedScores[score.studentName]!.add(score);
    }
    return groupedScores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, List<ScoreData>>>(
        future: scoreFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Data Found'));
          } else {
            final groupedScores = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: groupedScores.length,
                    itemBuilder: (context, index) {
                      final studentName = groupedScores.keys.elementAt(index);
                      final studentScores = groupedScores[studentName]!;
                      return ExpansionTile(
                        title: Text('ឈ្មោះ: $studentName'),
                        children: studentScores.map((score) {
                          return ListTile(
                            title: Text('${score.subjectName}'),
                            trailing: Text('${score.score}ពិន្ទុរ'),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                
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
