import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:todo_list/config/logger/logger.dart';

class RemoteConfigService {
  final _remoteConfig = FirebaseRemoteConfig.instance;
  final _remoteConfigSettings = RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(seconds: 0),
  );

  Future<RemoteConfigService> init() async {
    await _remoteConfig.setConfigSettings(_remoteConfigSettings);
    try {
      await _remoteConfig.fetchAndActivate();
    } on Exception catch (e, s) {
      Log.e('$e $s');
      FirebaseCrashlytics.instance
          .recordError('Failed to fetch remote config - $e', null);
    }
    return this;
  }

  String getString(ConfigKey key) => _remoteConfig.getString(key.name);
  Future<bool> activate() => _remoteConfig.activate();

  Stream<RemoteConfigUpdate> get onConfigUpdated =>
      _remoteConfig.onConfigUpdated;

  static Color? parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) return null;
    final buffer = StringBuffer();
    if (colorString.length == 6 || colorString.length == 7) buffer.write('ff');
    buffer.write(colorString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

enum ConfigKey {
  importanceColorBasic,
  importanceColorLow,
  importanceColorImportant,
}
