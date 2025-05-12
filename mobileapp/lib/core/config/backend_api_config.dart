import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';

class ApiConfig {
  static Future<String> getBaseUrl() async {
    if (kReleaseMode) {
      return 'https://quickbi3backend-u8l71xbz.b4a.run/api';
    }

    if (Platform.isAndroid || Platform.isIOS) {
      final deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        final isEmulator = !androidInfo.isPhysicalDevice;
        return isEmulator
            ? 'http://10.0.2.2:3000/api'
            : 'http://192.168.54.7:3000/api';
      }

      if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        final isEmulator = !iosInfo.isPhysicalDevice;
        return isEmulator
            ? 'http://localhost:3000/api'
            : 'http://192.168.54.89:3000/api';
      }
    }

    return 'http://localhost:3000/api';
  }
}
