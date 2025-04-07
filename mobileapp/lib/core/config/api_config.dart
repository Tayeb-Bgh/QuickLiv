import 'package:flutter/foundation.dart';

class ApiConfig {
  static final String baseUrl = kReleaseMode
      ? 'https://quickbi3backend-u8l71xbz.b4a.run/api'
      : 'http://10.0.2.2:3000/api';
}