import 'package:flutter/material.dart';
import 'package:school_app/model/grade.dart';
import 'package:school_app/service/service.dart';

class AllGrade extends StatefulWidget {
  const AllGrade({super.key});

  @override
  State<AllGrade> createState() => _GradePageState();
}

class _GradePageState extends State<AllGrade> {
  final Services _services = Services();
  late Future<List<GradeModel>> model;

  @override
  void initState() {
    super.initState();
    model = _services.getGrade();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<GradeModel>>(
        future: model,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("Data is Empty"),
            );
          }

          final grades = snapshot.data!;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: grades.length + 1, // Add 1 for the header
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Return the header for the first item
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("ឈ្មោះ"),
                                Text("និទ្ទេស"),
                              ],
                            ),
                          ),
                          Divider(),
                        ],
                      );
                    }
                    final grade =
                        grades[index - 1]; // Adjust index for the grades
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: ListTile(
                        title: Text(grade.name),
                        trailing: Text(
                          "${grade.grade}",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
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
        },
      ),
    );
  }
}
