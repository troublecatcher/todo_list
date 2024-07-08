import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';

abstract class OperationStatusNotifier {
  void startOperation(TodoEntity todo);
  void endOperation();
}
