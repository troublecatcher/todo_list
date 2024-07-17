import 'package:todo_list/features/features.dart';

extension SampleRemoteTodo on RemoteTodo {
  static RemoteTodo withId(String id) {
    return RemoteTodo(
      id: id,
      text: 'Задача $id',
      importance: Importance.basic,
      done: false,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      changedAt: DateTime.now().millisecondsSinceEpoch,
      lastUpdatedBy: 'Райан Гослинг',
    );
  }
}
