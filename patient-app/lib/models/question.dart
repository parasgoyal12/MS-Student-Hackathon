import 'package:html_unescape/html_unescape.dart';
import 'package:meta/meta.dart';

class Question {
  final String category;
  final String question;
  final List<String> options;

  Question({
    @required this.category,
    @required this.question,
    @required this.options,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    category: json['category'],
    question: HtmlUnescape().convert(json['question']),
    options: List<String>.from(json['options'].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    'category': category,
    'question': question,
    'options': List<dynamic>.from(options.map((x) => x)),
  };

  @override
  String toString() => toJson().toString();
}