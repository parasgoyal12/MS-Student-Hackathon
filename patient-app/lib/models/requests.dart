import 'package:flutter/foundation.dart';

class Request {
  final String Relative_name, status, date, image, url;

 Request({
    @required this.Relative_name,
    @required this.status,
    @required this.date,
    @required this.image,
    this.url,
  });
}
