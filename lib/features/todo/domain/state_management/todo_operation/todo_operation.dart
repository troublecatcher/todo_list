import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';

abstract class TodoOperation {
  void startOperation(TodoEntity todo);
  void endOperation();
}
