import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

extension SampleTodo on Todo {
  static Todo withId(String id) {
    return Todo(
      id: id,
      text: 'Задача $id',
      importance: Importance.basic,
      done: false,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
      lastUpdatedBy: 'Райан Гослинг',
    );
  }
}
