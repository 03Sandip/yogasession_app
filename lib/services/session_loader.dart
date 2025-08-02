import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/yoga_session.dart';

class SessionLoader {
  static Future<YogaSession> loadFromAssets(String path) async {
    final String jsonString = await rootBundle.loadString(path);
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return YogaSession.fromJson(jsonData);
  }
}
