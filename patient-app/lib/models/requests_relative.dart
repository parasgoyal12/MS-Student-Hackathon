import 'package:flutter/foundation.dart';

class RequestRelative {
  final String Patient_name, status, date, image, url;

  RequestRelative({
    @required this.Patient_name,
    @required this.status,
    @required this.date,
    @required this.image,
    this.url,
  });
}
