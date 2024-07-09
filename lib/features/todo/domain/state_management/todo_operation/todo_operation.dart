import 'package:todo_list/features/todo/domain/entities/todo.dart';

abstract class TodoOperation {
  void startOperation(Todo todo);
  void endOperation();
}
