import 'package:rental/core/network.dart';

String getImageUrl(String filename) {
  if (filename.startsWith("http")) {
    return filename;
  }
  return "${AppConstants.staticUrl}/$filename";
}
