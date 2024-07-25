import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import '../../../core/extensions/color_extension.dart';
import '../../../core/services/remote_config_service.dart';

part 'remote_colors_state.dart';

class RemoteColorsCubit extends Cubit<RemoteColorsState> {
  final RemoteConfigService _remoteConfigService;
  late StreamSubscription<RemoteConfigUpdate> _remoteConfigSubscription;

  RemoteColorsCubit(this._remoteConfigService) : super(RemoteColorsInitial());

  void init() {
    _remoteConfigSubscription =
        _remoteConfigService.onConfigUpdated.listen((_) async {
      await _remoteConfigService.activate();
      _updateColors();
    });
    _updateColors();
  }

  void _updateColors() {
    final basicColor = ColorExtension.parse(
      _remoteConfigService.getString(ConfigKey.importanceColorBasic),
    );
    final lowColor = ColorExtension.parse(
      _remoteConfigService.getString(ConfigKey.importanceColorLow),
    );
    final importantColor = ColorExtension.parse(
      _remoteConfigService.getString(ConfigKey.importanceColorImportant),
    );
    emit(
      RemoteColorsLoaded(
        basicColor: basicColor,
        lowColor: lowColor,
        importantColor: importantColor,
      ),
    );
  }

  @override
  Future<void> close() {
    _remoteConfigSubscription.cancel();
    return super.close();
  }
}
