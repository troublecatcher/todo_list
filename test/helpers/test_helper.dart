import 'package:mocktail/mocktail.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/features/features.dart';
import '../features/todo/domain/state_management/todo_list_bloc/todo_list_bloc_test.dart';
import 'sample_local_todo.dart';
import 'sample_remote_todo.dart';

class TestHelper {
  static void registerFallbackValues() {
    registerFallbackValue(SampleRemoteTodo.withId('0'));
    registerFallbackValue(SampleLocalTodo.withId('0'));
  }

  static MockRemoteTodoSource createMockRemoteTodoSource() {
    return MockRemoteTodoSource();
  }

  static MockLocalTodoSource createMockLocalTodoSource() {
    return MockLocalTodoSource();
  }

  static MockRevisionSetting createMockRevisionSetting() {
    return MockRevisionSetting();
  }

  static MockInitSyncSetting createMockInitSyncSetting() {
    return MockInitSyncSetting();
  }

  static TodoRepositoryImpl createTodoRepository({
    required RemoteTodoSource remote,
    required LocalTodoSource local,
    required RevisionSetting revision,
    required InitSyncSetting initSync,
  }) {
    return TodoRepositoryImpl(
      remote: remote,
      local: local,
      revision: revision,
      initSync: initSync,
    );
  }

  static Future<List<RemoteTodo>> fetchSampleRemoteTodos() async {
    return [
      SampleRemoteTodo.withId('x'),
      SampleRemoteTodo.withId('y'),
      SampleRemoteTodo.withId('z'),
    ];
  }

  static Future<List<LocalTodo>> fetchSampleLocalTodos() async {
    return [
      SampleLocalTodo.withId('a'),
      SampleLocalTodo.withId('b'),
    ];
  }
}
