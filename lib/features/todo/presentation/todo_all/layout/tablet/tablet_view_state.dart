part of 'tablet_view_cubit.dart';

sealed class TabletViewState extends Equatable {
  @override
  List<Object> get props => [];
}

final class TabletViewInitialState extends TabletViewState {}

final class TabletViewTodoSelectedState extends TabletViewState {
  final Todo todo;

  TabletViewTodoSelectedState({required this.todo});

  @override
  List<Object> get props => [todo];
}

final class TabletViewNewTodoState extends TabletViewState {}
