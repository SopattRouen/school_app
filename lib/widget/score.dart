import 'package:flutter/material.dart';
import 'package:school_app/widget/all-score-widget.dart';
import 'package:school_app/widget/own-score-widget.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({super.key});

  @override
  _ScorePageState createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage>
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
        title: Text("ពិន្ទុរប្រចាំខែ"),
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
          AllScoreWidget(),
          OwnScoreWidget(),
        ],
      ),
    );
  }
}
