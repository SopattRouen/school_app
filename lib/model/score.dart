class ScoreData {
  final String typeId;
  final int scoreId;
  final String studentName;
  final String subjectName;
  final double score;

  ScoreData({
    required this.typeId,
    required this.scoreId,
    required this.studentName,
    required this.subjectName,
    required this.score,
  });

  factory ScoreData.fromJson(Map<String, dynamic> json) {
    return ScoreData(
      typeId: json['type_id'] ?? '',
      scoreId: json['score_id'] ?? 0,
      studentName: json['student_name'] ?? 'Unknown',
      subjectName: json['subject_name'] ?? 'Unknown',
      score: (json['score'] as num).toDouble(),
    );
  }
}
