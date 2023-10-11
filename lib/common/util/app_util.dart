import 'package:package_info_plus/package_info_plus.dart';

class AppUtil {

  Future<String> appVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    return "$version - $buildNumber";
  }
}
