import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

part 'tablet_layout_state.dart';

class TabletLayoutCubit extends Cubit<TabletLayoutState> {
  TabletLayoutCubit() : super(TabletLayoutInitialState());
  void set(TabletLayoutState newState) => emit(newState);
}
