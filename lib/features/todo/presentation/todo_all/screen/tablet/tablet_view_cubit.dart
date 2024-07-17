import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/todo.dart';

part 'tablet_view_state.dart';

class TabletViewCubit extends Cubit<TabletViewState> {
  TabletViewCubit() : super(TabletViewInitialState());
  void set(TabletViewState newState) => emit(newState);
}
