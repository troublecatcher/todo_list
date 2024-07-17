import 'package:todo_list/features/features.dart';

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
