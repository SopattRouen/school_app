import 'package:flutter/material.dart';
import 'package:school_app/model/subject.dart';
import 'package:school_app/service/service.dart';

class SubjectPage extends StatefulWidget {
  const SubjectPage({super.key});

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final _service = Services();
  late Future<List<SubjectModel>> _model;
  @override
  void initState() {
    _model = _service.getSubject();
    super.initState();
  }

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
        title: Text("មុខវិជ្ជា"),
      ),
      body: FutureBuilder<List<SubjectModel>>(
        future: _model,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error ${snapshot.error}"),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final sub = snapshot.data![index];
              return ListTile(
                title: Text("${sub.name}"),
              );
            },
          );
        },
      ),
    );
  }
}
