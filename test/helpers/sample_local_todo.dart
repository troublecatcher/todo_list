import 'package:todo_list/features/todo/data/models/local/local_todo.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';

extension SampleLocalTodo on LocalTodo {
  static LocalTodo withId(String id) {
    return LocalTodo(
      uuid: id,
      text: 'Задача $id',
      importance: Importance.basic,
      done: false,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
      lastUpdatedBy: 'Райан Гослинг',
    );
  }
}
