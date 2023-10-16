import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoService extends ChangeNotifier {
  AppInfoService(this.appInfo);

  final PackageInfo appInfo;

  PackageInfo get info => appInfo;
}
