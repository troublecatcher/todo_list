import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/features/todo/data/todo_repository_impl.dart';
import '../../../helpers/sample_local_todo.dart';
import '../../../helpers/sample_remote_todo.dart';
import '../../../helpers/sample_todo.dart';
import '../../../helpers/test_helper.dart';
import '../domain/state_management/todo_list_bloc/todo_list_bloc_test.dart';

void main() {
  late TodoRepositoryImpl todoRepository;
  late MockRemoteTodoSource remoteSource;
  late MockLocalTodoSource localSource;
  late MockRevisionSetting revisionSetting;
  late MockInitSyncSetting initSyncSetting;

  setUpAll(() {
    TestHelper.registerFallbackValues();
  });

  setUp(() {
    remoteSource = TestHelper.createMockRemoteTodoSource();
    localSource = TestHelper.createMockLocalTodoSource();
    revisionSetting = TestHelper.createMockRevisionSetting();
    initSyncSetting = TestHelper.createMockInitSyncSetting();
    todoRepository = TestHelper.createTodoRepository(
      remote: remoteSource,
      local: localSource,
      revision: revisionSetting,
      initSync: initSyncSetting,
    );

    reset(remoteSource);
    reset(localSource);
    reset(revisionSetting);
    reset(initSyncSetting);
  });

  group('TodoRepository', () {
    group('и его метод fetchTodos', () {
      test(
          'должен перезаписывать локальные задачи, если ревизия на сервере больше, чем локальная ревизия',
          () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(2);
        when(() => initSyncSetting.value).thenReturn(true);
        when(() => remoteSource.getTodos()).thenAnswer(
          (_) async =>
              ([SampleRemoteTodo.withId('x'), SampleRemoteTodo.withId('y')], 2),
        );
        when(() => localSource.getTodos()).thenAnswer(
          (_) async => [
            SampleLocalTodo.withId('a'),
            SampleLocalTodo.withId('b'),
          ],
        );
        when(() => localSource.putFresh(any())).thenAnswer((_) async => {});
        when(() => revisionSetting.set(any())).thenAnswer((_) async => true);

        // Act
        final todos = await todoRepository.fetchTodos();

        // Assert
        final todoIds = todos.map((todo) => todo.id).toList();
        expect(todoIds, containsAll(['x', 'y']));
      });

      test(
          'должен перезаписывать задачи на сервере, если локальная ревизия больше, чем ревизия на сервере',
          () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(3);
        when(() => initSyncSetting.value).thenReturn(true);
        when(() => remoteSource.getTodos()).thenAnswer(
          (_) async => ([SampleRemoteTodo.withId('x')], 1),
        );
        when(() => localSource.getTodos()).thenAnswer(
          (_) async => [
            SampleLocalTodo.withId('a'),
            SampleLocalTodo.withId('b'),
            SampleLocalTodo.withId('c'),
          ],
        );
        when(() => remoteSource.putFresh(any())).thenAnswer((_) async => {});
        when(() => localSource.putFresh(any())).thenAnswer((_) async => {});
        when(() => revisionSetting.set(any())).thenAnswer((_) async => true);

        // Act
        final todos = await todoRepository.fetchTodos();

        // Assert
        final todoIds = todos.map((todo) => todo.id).toList();
        expect(todoIds, containsAll(['a', 'b', 'c']));
      });

      test(
          'должен объединять локальные и серверные задачи при инициализации с другого устройства в автономном режиме',
          () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(3);
        when(() => initSyncSetting.value).thenReturn(false);
        when(() => remoteSource.getTodos()).thenAnswer(
          (_) async =>
              ([SampleRemoteTodo.withId('a'), SampleRemoteTodo.withId('b')], 2),
        );
        when(() => localSource.getTodos()).thenAnswer(
          (_) async => [
            SampleLocalTodo.withId('x'),
            SampleLocalTodo.withId('y'),
            SampleLocalTodo.withId('z'),
          ],
        );
        when(() => remoteSource.putFresh(any())).thenAnswer((_) async => {});
        when(() => localSource.putFresh(any())).thenAnswer((_) async => {});
        when(() => initSyncSetting.set(any())).thenAnswer((_) async => true);

        // Act
        final todos = await todoRepository.fetchTodos();

        // Assert
        final todoIds = todos.map((todo) => todo.id).toList();
        expect(todoIds, containsAll(['a', 'b', 'x', 'y', 'z']));
      });
    });

    group('и его методы addTodo, updateTodo, deleteTodo', () {
      test(
          'должен увеличивать локальную ревизию при успешном добавлении как на сервер, так и на локальном уровне',
          () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(2);
        when(() => initSyncSetting.value).thenReturn(true);
        when(() => remoteSource.getTodos()).thenAnswer(
          (_) async =>
              ([SampleRemoteTodo.withId('a'), SampleRemoteTodo.withId('b')], 2),
        );
        when(() => localSource.putFresh(any())).thenAnswer((_) async => {});
        when(() => revisionSetting.set(any())).thenAnswer((_) async => true);
        when(() => remoteSource.addTodo(any())).thenAnswer((_) async => {});
        when(() => localSource.addTodo(any())).thenAnswer((_) async => {});
        when(() => revisionSetting.increment()).thenAnswer((_) async => {});

        // Act
        await todoRepository.addTodo(SampleTodo.withId('c'));

        // Assert
        verify(() => revisionSetting.increment()).called(1);
      });

      test(
          'должен увеличивать локальную ревизию при неудачном добавлении на сервере, но успешном на локальном уровне',
          () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(2);
        when(() => initSyncSetting.value).thenReturn(true);
        when(() => remoteSource.getTodos()).thenAnswer(
          (_) async =>
              ([SampleRemoteTodo.withId('a'), SampleRemoteTodo.withId('b')], 2),
        );
        when(() => localSource.putFresh(any())).thenAnswer((_) async => {});
        when(() => revisionSetting.set(any())).thenAnswer((_) async => true);
        when(() => remoteSource.addTodo(any()))
            .thenThrow(Exception('Ошибка на сервере'));
        when(() => localSource.addTodo(any())).thenAnswer((_) async => {});
        when(() => revisionSetting.increment()).thenAnswer((_) async => {});

        // Act
        await todoRepository.addTodo(SampleTodo.withId('c'));

        // Assert
        verify(() => revisionSetting.increment()).called(1);
      });

      test(
          'не должен увеличивать ревизию при неудачном добавлении как на сервере, так и на локальном уровне',
          () async {
        // Arrange
        when(() => revisionSetting.value).thenReturn(2);
        when(() => initSyncSetting.value).thenReturn(true);
        when(() => remoteSource.getTodos()).thenAnswer(
          (_) async =>
              ([SampleRemoteTodo.withId('a'), SampleRemoteTodo.withId('b')], 2),
        );
        when(() => localSource.putFresh(any())).thenAnswer((_) async => {});
        when(() => revisionSetting.set(any())).thenAnswer((_) async => true);
        when(() => remoteSource.addTodo(any()))
            .thenThrow(Exception('Ошибка на сервере'));
        when(() => localSource.addTodo(any()))
            .thenThrow(Exception('Ошибка на локальном уровне'));
        when(() => revisionSetting.increment()).thenAnswer((_) async => {});

        // Act
        await todoRepository.addTodo(SampleTodo.withId('c'));

        // Assert
        verifyNever(() => revisionSetting.increment());
      });
    });
  });
}
