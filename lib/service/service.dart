import 'dart:convert';
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:school_app/const/const.dart';
import 'package:school_app/model/grade.dart';
import 'package:school_app/model/score.dart';
import 'package:school_app/model/subject.dart';

class Services {
  final box = GetStorage();

  Future<List<ScoreData>> getScore() async {
    final token = box.read('token');
    try {
      final response = await http.get(
        Uri.parse('${urlApi}score/getscore'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log('Status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['data'];
        return data.map((json) => ScoreData.fromJson(json)).toList();
      } else {
        log("Error fetching data: ${response.statusCode}");
        throw Exception("Error fetching data");
      }
    } catch (e) {
      log("Error: $e");
      throw Exception("Error fetching data: $e");
    }
  }

  Future<List<ScoreData>> getScoreByScoreId(num userId) async {
    final token = box.read('token');
    try {
      final url = '${urlApi}score/${userId}';
      log('Request URL: $url'); // Log the request URL
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log('User ID: $userId');
      log('Status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['data'];

        // Convert data to List<ScoreData>
        List<ScoreData> scores =
            data.map((json) => ScoreData.fromJson(json)).toList();

        return scores;
      } else {
        log("Error fetching data: ${response.statusCode}");
        throw Exception("Error fetching data");
      }
    } catch (e) {
      log("Error: $e");
      throw Exception("Error fetching data: $e");
    }
  }

  Future<List<GradeModel>> getGrade() async {
    try {
      final token = box.read('token');
      final response = await http.get(
        Uri.parse(
          "${urlApi}grade",
        ),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['message'] == "ជោគជ័យ") {
          List<GradeModel> grades = (responseBody['data'] as List)
              .map((data) => GradeModel.fromJson(data))
              .toList();
          return grades;
        } else {
          throw Exception('Failed to load data');
        }
      }
    } catch (e) {
      throw Exception("error fetching data: $e");
    }
    return [];
  }

  Future<GradeModel> getGradeById(num userId) async {
    final token = box.read('token');
    final response = await http.get(
      Uri.parse(
        "${urlApi}grade/${userId}",
      ),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      if (responseBody['message'] == "ជោគជ័យ") {
        final data = responseBody['data'];
        GradeModel grade = GradeModel.fromJson(data);
        return grade;
      } else {
        throw Exception('Failed to load data: ${responseBody['message']}');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<List<SubjectModel>> getSubject() async {
    final token = box.read('token');
    try {
      final response = await http.get(
        Uri.parse('${urlApi}subject'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      log("${response.statusCode}");
      if (response.statusCode == 200) {
        final res = jsonDecode(response.body);
        List<dynamic> data = res['data'];
        List<SubjectModel> sub =
            data.map((data) => SubjectModel.fromJson(data)).toList();
        return sub;
      } else {
        log("${response.statusCode}");
        log("Can't fetch data");
      }
    } catch (e) {
      log("Error:${e}");
    }
    return [];
  }
}
