part of 'tablet_layout_cubit.dart';

sealed class TabletLayoutState extends Equatable {
  @override
  List<Object> get props => [];
}

final class TabletLayoutInitialState extends TabletLayoutState {}

final class TabletLayoutTodoSelectedState extends TabletLayoutState {
  final Todo todo;

  TabletLayoutTodoSelectedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class TabletLayoutNewTodoState extends TabletLayoutState {}
