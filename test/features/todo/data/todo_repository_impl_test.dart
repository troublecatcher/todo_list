import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/core/services/settings_service.dart';
import 'package:todo_list/features/todo/data/models/local/local_todo.dart';
import 'package:todo_list/features/todo/data/models/remote/remote_todo.dart';
import 'package:todo_list/features/todo/data/sources/local/local_todo_source_impl.dart';
import 'package:todo_list/features/todo/data/sources/remote/remote_source/remote_todo_source_impl.dart';
import 'package:todo_list/features/todo/data/todo_repository_impl.dart';
import 'package:todo_list/features/todo/domain/entities/importance.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';

class MockRemoteTodoSource extends Mock implements RemoteTodoSourceImpl {}

class MockLocalTodoSource extends Mock implements LocalTodoSourceImpl {}

class MockRevisionSetting extends Mock implements RevisionSetting {}

class MockInitSyncSetting extends Mock implements InitSyncSetting {}

void main() {
  late TodoRepositoryImpl todoRepository;
  late MockRemoteTodoSource remoteSource;
  late MockLocalTodoSource localSource;
  late MockRevisionSetting revisionSetting;
  late MockInitSyncSetting initSyncSetting;

  setUpAll(() {
    registerFallbackValue(SampleRemoteTodo.withId('0'));
    registerFallbackValue(SampleLocalTodo.withId('0'));
  });

  setUp(() {
    remoteSource = MockRemoteTodoSource();
    localSource = MockLocalTodoSource();
    revisionSetting = MockRevisionSetting();
    initSyncSetting = MockInitSyncSetting();
    todoRepository = TodoRepositoryImpl(
      remote: remoteSource,
      local: localSource,
      revision: revisionSetting,
      initSync: initSyncSetting,
    );

    // Resetting mock interactions
    reset(remoteSource);
    reset(localSource);
    reset(revisionSetting);
    reset(initSyncSetting);
  });

  group('Todo Repository', () {
    group('и его метод fetchTodos', () {
      test(
          'должен перезаписывать локальные дела, если серверная ревизия больше локальной',
          () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(2);
        when(() => initSyncSetting.value).thenReturn(true);
        when(() => remoteSource.getTodos()).thenAnswer(
          (_) async => (
            [
              SampleRemoteTodo.withId('x'),
              SampleRemoteTodo.withId('y'),
              SampleRemoteTodo.withId('z'),
            ],
            3
          ),
        );
        when(() => localSource.getTodos()).thenAnswer(
          (_) async => [
            SampleLocalTodo.withId('a'),
            SampleLocalTodo.withId('b'),
          ],
        );
        when(() => localSource.putFresh(any()))
            .thenAnswer((_) async => Future.value());
        when(() => revisionSetting.set(any()))
            .thenAnswer((_) async => Future.value(true));

        // Act
        final todos = await todoRepository.fetchTodos();

        // Assert
        final todoIds = todos.map((todo) => todo.id).toList();
        expect(todoIds, containsAll(['x', 'y', 'z']));
      });
      test(
          'должен перезаписывать серверные дела, если локальная ревизия больше серверной',
          () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(3);
        when(() => initSyncSetting.value).thenReturn(true);
        when(() => remoteSource.getTodos()).thenAnswer(
          (_) async => (
            [
              SampleRemoteTodo.withId('x'),
              SampleRemoteTodo.withId('y'),
            ],
            2
          ),
        );
        when(() => localSource.getTodos()).thenAnswer(
          (_) async => [
            SampleLocalTodo.withId('a'),
            SampleLocalTodo.withId('b'),
            SampleLocalTodo.withId('c'),
          ],
        );
        when(() => remoteSource.putFresh(any()))
            .thenAnswer((_) async => Future.value());
        when(() => localSource.putFresh(any()))
            .thenAnswer((_) async => Future.value());
        when(() => revisionSetting.set(any()))
            .thenAnswer((_) async => Future.value(true));

        // Act
        final todos = await todoRepository.fetchTodos();

        // Assert
        final todoIds = todos.map((todo) => todo.id).toList();
        expect(todoIds, containsAll(['a', 'b', 'c']));
      });
      test(
          '''при начале работы с приложением с другого устройства в режиме оффлайн при 
          первом заходе в сеть должен соединять созданные за время оффайна дела с теми, 
          что уже имелись на сервере''', () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(3);
        when(() => initSyncSetting.value).thenReturn(false);
        when(() => remoteSource.getTodos()).thenAnswer(
          (_) async => (
            [
              SampleRemoteTodo.withId('a'),
              SampleRemoteTodo.withId('b'),
            ],
            2
          ),
        );
        when(() => localSource.getTodos()).thenAnswer(
          (_) async => [
            SampleLocalTodo.withId('x'),
            SampleLocalTodo.withId('y'),
            SampleLocalTodo.withId('z'),
          ],
        );
        when(() => remoteSource.putFresh(any()))
            .thenAnswer((_) async => Future.value());
        when(() => localSource.putFresh(any()))
            .thenAnswer((_) async => Future.value());
        when(() => initSyncSetting.set(any()))
            .thenAnswer((_) async => Future.value(true));

        // Act
        final todos = await todoRepository.fetchTodos();

        // Assert
        final todoIds = todos.map((todo) => todo.id).toList();
        expect(todoIds, containsAll(['a', 'b', 'x', 'y', 'z']));
      });
    });

    group('и его метод addTodo', () {
      test('должен добавлять дело при ошибке на удаленном источнике', () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(2);
        when(() => initSyncSetting.value).thenReturn(true);

        // Stub responses for methods
        when(() => remoteSource.getTodos())
            .thenThrow(Exception('Remote error'));
        when(() => localSource.putFresh(any()))
            .thenAnswer((_) async => Future.value());
        when(() => revisionSetting.set(any()))
            .thenAnswer((_) async => Future.value(true));
        when(() => remoteSource.addTodo(any<RemoteTodo>()))
            .thenAnswer((_) async => Future.value());
        when(() => localSource.addTodo(any<LocalTodo>()))
            .thenAnswer((_) async => Future.value());
        when(() => revisionSetting.increment())
            .thenAnswer((_) async => Future.value());

        // Act: Add 'c' using the repository
        await todoRepository.addTodo(SampleTodo.withId('c'));

        // Assert: Verify that localSource.addTodo was called with the correct parameter
        verify(() => localSource.addTodo(any())).called(1);
      });
      test('должен добавлять дело при ошибке на обоих источниках', () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(2);
        when(() => initSyncSetting.value).thenReturn(true);

        // Stub responses for methods
        when(() => remoteSource.getTodos())
            .thenThrow(Exception('Remote error'));
        when(() => localSource.putFresh(any()))
            .thenThrow(Exception('Local error'));
        when(() => revisionSetting.set(any()))
            .thenAnswer((_) async => Future.value(true));
        when(() => remoteSource.addTodo(any<RemoteTodo>()))
            .thenAnswer((_) async => Future.value());
        when(() => localSource.addTodo(any<LocalTodo>()))
            .thenAnswer((_) async => Future.value());
        when(() => revisionSetting.increment())
            .thenAnswer((_) async => Future.value());

        // Act: Add 'c' using the repository
        await todoRepository.addTodo(SampleTodo.withId('c'));

        // Assert: Verify that localSource.addTodo was called with the correct parameter
        verify(() => localSource.addTodo(any()));
      });
    });

    group('и его метод updateTodo', () {
      test('должен изменять дело', () async {
        // Arrange
        when(() => remoteSource.updateTodo(any<RemoteTodo>()))
            .thenAnswer((_) async => Future.value());
        when(() => localSource.updateTodo(any<LocalTodo>()))
            .thenAnswer((_) async => Future.value());
        when(() => revisionSetting.increment())
            .thenAnswer((_) async => Future.value());

        // Act
        await todoRepository.updateTodo(SampleTodo.withId('a'));

        // Assert
        final todos = await todoRepository.fetchTodos();
        final todoIds = todos.map((todo) => todo.id).toList();
        expect(todoIds, contains('a'));
      });
    });

    group('и его метод deleteTodo', () {
      test('должен удалять дело', () async {
        // Arrange
        when(() => remoteSource.deleteTodo(any<RemoteTodo>()))
            .thenAnswer((_) async => Future.value());
        when(() => localSource.deleteTodo(any<LocalTodo>()))
            .thenAnswer((_) async => Future.value());
        when(() => revisionSetting.increment())
            .thenAnswer((_) async => Future.value());

        // Act
        await todoRepository.deleteTodo(SampleTodo.withId('a'));

        // Assert
        final todos = await todoRepository.fetchTodos();
        final todoIds = todos.map((todo) => todo.id).toList();
        expect(todoIds, isNot(contains('a')));
      });
    });
  });
}

extension SampleTodo on Todo {
  static Todo withId(String id) {
    return Todo(
      id: id,
      text: 'Todo $id',
      importance: Importance.basic,
      done: false,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
      lastUpdatedBy: 'ryan gosling',
    );
  }
}

extension SampleRemoteTodo on RemoteTodo {
  static RemoteTodo withId(String id) {
    return RemoteTodo(
      id: id,
      text: 'Todo $id',
      importance: Importance.basic,
      done: false,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      changedAt: DateTime.now().millisecondsSinceEpoch,
      lastUpdatedBy: 'matthew mcconaughey',
    );
  }
}

extension SampleLocalTodo on LocalTodo {
  static LocalTodo withId(String id) {
    return LocalTodo(
      id: id,
      text: 'Todo $id',
      importance: Importance.basic,
      done: false,
      createdAt: DateTime.now(),
      changedAt: DateTime.now(),
      lastUpdatedBy: 'julia roberts',
    );
  }
}
