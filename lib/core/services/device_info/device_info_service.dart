import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

class DeviceInfoService {
  late String _info;

  DeviceInfoService();

  Future<DeviceInfoService> init() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        _info = androidInfo.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        _info = iosInfo.identifierForVendor ?? 'Couldn\'t get device id';
      } else {
        throw UnsupportedError('Unsupported platform');
      }
    } on PlatformException {
      _info = 'Failed to get platform version.';
    }
    return this;
  }

  String get info => _info;
}
