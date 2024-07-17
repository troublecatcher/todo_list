import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/services/services.dart';

class DuckCubit extends Cubit<bool> {
  final _duck = GetIt.I<SettingsService>().duck;
  DuckCubit() : super(true);

  void init() => emit(_duck.value);
  Future<void> set(bool duck) async {
    await _duck.set(duck);
    emit(duck);
  }
}
