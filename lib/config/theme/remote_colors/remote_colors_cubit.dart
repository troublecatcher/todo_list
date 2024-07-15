import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:todo_list/config/theme/remote_colors/remote_colors_state.dart';
import 'package:todo_list/core/services/remote_config_service.dart';

class RemoteColorsCubit extends Cubit<RemoteColorsState> {
  final RemoteConfigService remoteConfigService;
  late StreamSubscription<RemoteConfigUpdate> _remoteConfigSubscription;

  RemoteColorsCubit(this.remoteConfigService) : super(RemoteColorsInitial()) {
    _remoteConfigSubscription =
        remoteConfigService.onConfigUpdated.listen((_) async {
      await remoteConfigService.activate();
      _updateColors();
    });

    _updateColors();
  }

  void _updateColors() {
    final importanceColorBasic = RemoteConfigService.parseColor(
      remoteConfigService.getString(ConfigKey.importanceColorBasic),
    );
    final importanceColorLow = RemoteConfigService.parseColor(
      remoteConfigService.getString(ConfigKey.importanceColorLow),
    );
    final importanceColorImportant = RemoteConfigService.parseColor(
      remoteConfigService.getString(ConfigKey.importanceColorImportant),
    );

    emit(
      RemoteColorsLoaded(
        importanceColorBasic: importanceColorBasic,
        importanceColorLow: importanceColorLow,
        importanceColorImportant: importanceColorImportant,
      ),
    );
  }

  @override
  Future<void> close() {
    _remoteConfigSubscription.cancel();
    return super.close();
  }
}
