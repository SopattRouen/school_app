import 'package:flutter/material.dart';
import 'package:school_app/widget/all-grade.dart';
import 'package:school_app/widget/own-grade.dart';

class GradePage extends StatefulWidget {
  const GradePage({super.key});

  @override
  _GradePageState createState() => _GradePageState();
}

class _GradePageState extends State<GradePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text("ចំណាត់ថ្នាក់ប្រចាំខែ"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'ទាំងអស់'),
            Tab(text: 'ផ្ទាល់ខ្លួន'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AllGrade(),
          OwnGrade(),
        ],
      ),
    );
  }
}
