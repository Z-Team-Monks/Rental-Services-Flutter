import 'package:dartz/dartz.dart';
import 'package:rental/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConstants {
  static String baseUrl = "http://192.168.0.164:5000/api/v1";

  static String staticUrl = "http://192.168.0.164:5000";

  // static String token = getIt<SharedPreferences>().get("token") as String;
  static String token =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMDViNDQyOGQzZmFjNzY4Y2RmMWNiOCIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2MzEyNjY4NTB9.edHxTrukr9ptkbubKCBP025dmFPMpRdngNQq3FHoD4g";
}
