import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_list/core/services/settings_service.dart';
import 'package:todo_list/features/todo/data/models/remote/remote_todo.dart';
import 'package:todo_list/features/todo/data/sources/local/local_todo_source.dart';
import 'package:todo_list/features/todo/data/sources/remote/remote_source/remote_todo_source.dart';
import 'package:todo_list/features/todo/domain/entities/todo.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_list/features/todo/data/todo_repository_impl.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_list_bloc/todo_list_bloc.dart';
import 'package:todo_list/features/todo/domain/state_management/todo_operation/todo_operation.dart';

import '../../../../../helpers/sample_local_todo.dart';
import '../../../../../helpers/sample_remote_todo.dart';
import '../../../../../helpers/sample_todo.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

class MockRemoteTodoSource extends Mock implements RemoteTodoSource {}

class MockLocalTodoSource extends Mock implements LocalTodoSource {}

class MockRevisionSetting extends Mock implements RevisionSetting {}

class MockInitSyncSetting extends Mock implements InitSyncSetting {}

class MockTodoOperation extends Mock implements TodoOperation {}

void main() {
  late MockTodoRepository mockTodoRepository;
  late MockRemoteTodoSource mockRemoteTodoSource;
  late MockLocalTodoSource mockLocalTodoSource;
  late MockRevisionSetting mockRevisionSetting;
  late MockInitSyncSetting mockInitSyncSetting;
  late MockTodoOperation mockTodoOperation;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    mockRemoteTodoSource = MockRemoteTodoSource();
    mockLocalTodoSource = MockLocalTodoSource();
    mockRevisionSetting = MockRevisionSetting();
    mockInitSyncSetting = MockInitSyncSetting();
    mockTodoOperation = MockTodoOperation();

    registerFallbackValue(SampleTodo.withId('1'));
    registerFallbackValue(SampleRemoteTodo.withId('1'));
    registerFallbackValue(SampleLocalTodo.withId('1'));

    when(() => mockRemoteTodoSource.getTodos()).thenAnswer(
      (_) async => (<RemoteTodo>[SampleRemoteTodo.withId('3')], 1),
    );
    when(() => mockRemoteTodoSource.addTodo(any())).thenAnswer((_) async {});
    when(() => mockRemoteTodoSource.updateTodo(any())).thenAnswer((_) async {});
    when(() => mockRemoteTodoSource.deleteTodo(any())).thenAnswer((_) async {});

    when(() => mockLocalTodoSource.getTodos()).thenAnswer(
      (_) async => [SampleLocalTodo.withId('1')],
    );
    when(() => mockLocalTodoSource.addTodo(any())).thenAnswer((_) async {});
    when(() => mockLocalTodoSource.updateTodo(any())).thenAnswer((_) async {});
    when(() => mockLocalTodoSource.deleteTodo(any())).thenAnswer((_) async {});

    when(() => mockRevisionSetting.value).thenReturn(1);
    when(() => mockRevisionSetting.set(any())).thenAnswer((_) async => true);
    when(() => mockRevisionSetting.increment()).thenAnswer((_) async {});

    when(() => mockInitSyncSetting.value).thenReturn(true);
    when(() => mockInitSyncSetting.set(any())).thenAnswer((_) async => true);

    when(() => mockTodoRepository.fetchTodos()).thenAnswer((_) async => []);
    when(() => mockTodoRepository.addTodo(any())).thenAnswer((_) async {});
    when(() => mockTodoRepository.updateTodo(any())).thenAnswer((_) async {});
    when(() => mockTodoRepository.deleteTodo(any())).thenAnswer((_) async {});
  });

  group('TodoListBloc', () {
    final todo1 = SampleTodo.withId('1');
    final todo2 = SampleTodo.withId('2');

    group('и его событие TodoAdded', () {
      blocTest<TodoListBloc, TodoState>(
        'должен передавать состояние TodoLoadSuccess с добавленной задачей',
        build: () => TodoListBloc(
          todoRepository: TodoRepositoryImpl(
            remote: mockRemoteTodoSource,
            local: mockLocalTodoSource,
            revision: mockRevisionSetting,
            initSync: mockInitSyncSetting,
          ),
          todoOperation: mockTodoOperation,
        ),
        seed: () => TodoLoadSuccess([todo1]),
        act: (bloc) => bloc.add(TodoAdded(todo2)),
        expect: () => [
          isA<TodoLoadSuccess>().having(
            (state) => state.todos,
            'todos',
            containsAllInOrder([
              isA<Todo>().having((todo) => todo.id, 'id', '1'),
              isA<Todo>().having((todo) => todo.id, 'id', '2'),
            ]),
          ),
        ],
      );

      blocTest<TodoListBloc, TodoState>(
        'должен передавать состояние TodoFailure, если репозиторий выбрасывает исключение',
        build: () => TodoListBloc(
          todoRepository: mockTodoRepository,
          todoOperation: mockTodoOperation,
        ),
        act: (bloc) {
          when(() => mockTodoRepository.addTodo(any()))
              .thenThrow(Exception('failed to add todo'));
          bloc.add(TodoAdded(SampleTodo.withId('1')));
        },
        expect: () => [
          isA<TodoFailure>().having(
            (state) => state.message,
            'exception',
            'Exception: failed to add todo',
          ),
        ],
      );
    });

    group('и его событие TodoUpdated', () {
      blocTest<TodoListBloc, TodoState>(
        'должен передавать состояние TodoLoadSuccess с обновленной задачей',
        build: () => TodoListBloc(
          todoRepository: mockTodoRepository,
          todoOperation: mockTodoOperation,
        ),
        seed: () => TodoLoadSuccess([todo1]),
        act: (bloc) => bloc.add(TodoUpdated(todo1.copyWith(text: 'updated'))),
        expect: () => [
          isA<TodoLoadSuccess>().having(
            (state) => state.todos,
            'todos',
            contains(
              isA<Todo>().having((todo) => todo.text, 'text', 'updated'),
            ),
          ),
        ],
      );

      blocTest<TodoListBloc, TodoState>(
        'должен передавать состояние TodoFailure, если репозиторий выбрасывает исключение',
        build: () => TodoListBloc(
          todoRepository: mockTodoRepository,
          todoOperation: mockTodoOperation,
        ),
        act: (bloc) {
          when(() => mockTodoRepository.updateTodo(any()))
              .thenThrow(Exception('failed to update todo'));
          bloc.add(TodoUpdated(SampleTodo.withId('1')));
        },
        expect: () => [
          isA<TodoFailure>().having(
            (state) => state.message,
            'exception',
            'Exception: failed to update todo',
          ),
        ],
      );
    });

    group('и его событие TodoDeleted', () {
      blocTest<TodoListBloc, TodoState>(
        'должен передавать состояние TodoLoadSuccess без удаленной задачи',
        build: () => TodoListBloc(
          todoRepository: mockTodoRepository,
          todoOperation: mockTodoOperation,
        ),
        seed: () => TodoLoadSuccess([todo1, todo1]),
        act: (bloc) => bloc.add(TodoDeleted(todo1)),
        expect: () => [
          isA<TodoLoadSuccess>().having(
            (state) => state.todos,
            'todos',
            isNot(contains(isA<Todo>().having((todo) => todo.id, 'id', '1'))),
          ),
        ],
      );

      blocTest<TodoListBloc, TodoState>(
        'должен передавать состояние TodoFailure, если репозиторий выбрасывает исключение',
        build: () => TodoListBloc(
          todoRepository: mockTodoRepository,
          todoOperation: mockTodoOperation,
        ),
        act: (bloc) {
          when(() => mockTodoRepository.deleteTodo(any()))
              .thenThrow(Exception('failed to delete todo'));
          bloc.add(TodoDeleted(SampleTodo.withId('1')));
        },
        expect: () => [
          isA<TodoFailure>().having(
            (state) => state.message,
            'exception',
            'Exception: failed to delete todo',
          ),
        ],
      );
    });
  });
}
