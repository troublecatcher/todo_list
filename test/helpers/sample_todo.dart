import 'package:todo_list/features/features.dart';

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
