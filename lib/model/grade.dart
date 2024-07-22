class GradeModel {
  final String typeId;
  final String name;
  final double average;
  final String grade;
  final double? totalScore;

  GradeModel({
    required this.typeId,
    required this.name,
    required this.average,
    required this.grade,
    required this.totalScore,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      typeId: json['type_id'],
      name: json['name'],
      average: (json['average'] as num?)?.toDouble() ?? 0.0,
      totalScore: (json['total_score'] as num?)?.toDouble(),
      grade: json['grade'],
    );
  }
}
