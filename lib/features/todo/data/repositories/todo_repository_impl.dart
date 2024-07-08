import 'package:todo_list/config/logger/logger.dart';
import 'package:todo_list/core/services/preferences/preferences/revision_preference.dart';
import 'package:todo_list/features/todo/data/dto/local/local_todo.dart';
import 'package:todo_list/features/todo/data/dto/remote/remote_todo.dart';
import 'package:todo_list/features/todo/data/extensions.dart';
import 'package:todo_list/features/todo/data/sources/local/local_todo_source.dart';
import 'package:todo_list/features/todo/data/sources/remote/remote_source/remote_todo_source.dart';
import 'package:todo_list/features/todo/domain/entities/todo_entity.dart';
import 'package:todo_list/features/todo/domain/repository/todo_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/core/services/preferences/preferences_service/preferences_service.dart';

class TodoRepositoryImpl implements TodoRepository {
  final RemoteTodoSource _remote;
  final LocalTodoSource _local;
  final RevisionPreference _revision;

  TodoRepositoryImpl({
    required RemoteTodoSource remote,
    required LocalTodoSource local,
  })  : _remote = remote,
        _local = local,
        _revision = GetIt.I<PreferencesService>().revision;

  @override
  Future<List<TodoEntity>> fetchTodos() async {
    final int localRevision = _revision.value;
    try {
      Log.i('Fetching todos remote');
      final (List<RemoteTodo> remoteTodos, int remoteRevision) =
          await _remote.getTodos();
      if (remoteRevision < localRevision) {
        final List<LocalTodo> localTodos = await _local.getTodos();
        final localEntities =
            localTodos.map((localTodo) => localTodo.toEntity()).toList();
        await _remote.putFresh(
            localEntities.map((entity) => entity.toRemote()).toList(),);
        await _revision.set(remoteRevision);
        Log.w('Local revision won, overwritten remote');
        return localEntities;
      } else {
        final remoteEntities =
            remoteTodos.map((remoteTodo) => remoteTodo.toEntity()).toList();
        await _local.putFresh(
            remoteEntities.map((entity) => entity.toLocal()).toList(),);
        await _revision.set(remoteRevision);
        Log.w('Remote revision won, overwritten local');
        return remoteEntities;
      }
    } catch (e, s) {
      Log.e('Error fetching todos from remote: $e, $s');
      Log.i('Fetching todos local');
      try {
        final List<LocalTodo> localTodos = await _local.getTodos();
        return localTodos.map((localTodo) => localTodo.toEntity()).toList();
      } catch (e, s) {
        Log.e('Error fetching todos from local: $e, $s');
        rethrow;
      }
    }
  }

  @override
  Future<void> addTodo(TodoEntity todo) async {
    await _executeAction(
      remoteAction: () => _remote.addTodo(todo.toRemote()),
      localAction: () => _local.addTodo(todo.toLocal()),
    );
  }

  @override
  Future<void> updateTodo(TodoEntity todo) async {
    await _executeAction(
      remoteAction: () => _remote.updateTodo(todo.toRemote()),
      localAction: () => _local.updateTodo(todo.toLocal()),
    );
  }

  @override
  Future<void> deleteTodo(TodoEntity todo) async {
    await _executeAction(
      remoteAction: () => _remote.deleteTodo(todo.toRemote()),
      localAction: () => _local.deleteTodo(todo.toLocal()),
    );
  }

  Future<void> _executeAction({
    required Future<void> Function() remoteAction,
    required Future<void> Function() localAction,
  }) async {
    bool saved = false;
    try {
      await remoteAction();
      await _revision.increment().then((_) => saved = true);
    } catch (e, s) {
      Log.e('Error in remote: $e, $s');
    }
    try {
      await localAction();
      if (!saved) await _revision.increment();
    } catch (e, s) {
      Log.e('Error in local: $e, $s');
      rethrow;
    }
  }
}
