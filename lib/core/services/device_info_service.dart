import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfoService {
  late BaseDeviceInfo _info;
  Future<DeviceInfoService> init() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    _info = deviceInfo;
    return this;
  }

  BaseDeviceInfo get info => _info;
}
