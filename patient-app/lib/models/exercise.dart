import 'package:flutter/foundation.dart';

class Exercise {
  final String title, time, difficult, image, reps,url,text_instruct,totalTime;
  final int day;

  Exercise({
    this.day,
    @required this.title,
    @required this.time,
    @required this.difficult,
    @required this.image,
    @required this.reps,
    this.url,
    this.text_instruct,
    this.totalTime
  });
}
