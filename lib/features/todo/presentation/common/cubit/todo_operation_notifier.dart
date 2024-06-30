import 'package:todo_list/features/todo/domain/entity/todo.dart';

abstract class OperationStatusNotifier {
  void startOperation(Todo todo);
  void endOperation();
}
