import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:treatment_checkup_app/models/question.dart';

import 'dart:developer';

class QuizService {
  static const _baseEndpoint = 'https://opentdb.com/api.php';

  Future<List<Question>> getQuestions(int count) async {
    try {
        final jsonStringLocal = json.decode('{"response_code":0,"results": [{"category": "Operation X","question": "Do You Have Swelling in Your Knee?","options": ["Low", "High", "Medium"]},{"category": "Operation Y","question": "Are you able to bend your knee?","options": ["Yes", "No"]},{"category": "Operation X","question": "Able to perform all exercises as prescribed?","options": ["Opt-1", "Opt-2", "Opt-3", "Opt-4", "Opt-5"]}]}');
        final List<dynamic> questionAsJsonListLocal = jsonStringLocal['results'];
        if(questionAsJsonListLocal!=null) {
          final List<Question> questions = questionAsJsonListLocal.map((e) => Question.fromJson(e)).toList();
          return questions;
        }
    } catch (error) {
      print('An error occurred: $error');
    }

    return null;
  }
}
